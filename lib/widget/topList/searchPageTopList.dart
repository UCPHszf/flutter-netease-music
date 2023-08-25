import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../model/song/topListItem.dart';
import '../../provider/pageSettingState.dart';
import '../../resource/color.dart';
import '../../resource/enum.dart';
import '../../util/dependencies.dart';

class SearchPageTopList extends StatefulWidget {
  const SearchPageTopList({
    Key? key,
    Widget? actions,
    required String listTitle,
    required TopListType topListType,
    int? topListId,
  })  : _actions = actions,
        _listTitle = listTitle,
        _topListType = topListType,
        _topListId = topListId,
        super(key: key);

  final Widget? _actions;
  final String _listTitle;
  final TopListType _topListType;
  final int? _topListId;

  @override
  State<StatefulWidget> createState() => _SearchPageTopListState();
}

class _SearchPageTopListState extends State<SearchPageTopList> {
  List<TopListItem> _topListItems = [];
  Logger logger = getIt<Logger>();

  @override
  void initState() {
    super.initState();
    NetworkRequest.topList(widget._topListType, widget._topListId).then(
      (value) => {
        if (mounted)
          {
            setState(
              () {
                //according to limit
                _topListItems = value.sublist(
                  0,
                  value.length >
                          context
                              .read<PageSettingState>()
                              .searchPageTopListLimit
                      ? context.read<PageSettingState>().searchPageTopListLimit
                      : value.length,
                );
              },
            )
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dim.screenUtilOnVertical(Dim.padding15),
        horizontal: Dim.screenUtilOnHorizontal(Dim.padding15),
      ),
      width: Dim.screenUtilOnHorizontal(Dim.searchPageTopListWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: Dim.screenUtilOnVertical(Dim.margin10),
                ),
                child: Text(
                  widget._listTitle,
                  style: TextStyle(
                    fontSize: Dim.screenUtilOnSp(Dim.fontSize20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              widget._actions ?? Container(),
            ],
          ),
          const Divider(
            color: AppColor.dividerColor,
            height: 1,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _topListItems.length,
            itemBuilder: (context, index) {
              //top 3 item index color should be red
              Color? indexColor;
              if (index < 3) {
                indexColor = AppColor.red;
              } else {
                indexColor = AppColor.black;
              }
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: Dim.screenUtilOnVertical(Dim.margin10),
                ),
                child: Row(
                  children: [
                    Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: indexColor,
                        fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                      ),
                    ),
                    SizedBox(
                      width: Dim.screenUtilOnHorizontal(Dim.margin10),
                    ),
                    Expanded(
                      child: Text(
                        _topListItems[index].text,
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    _topListItems[index].iconUrl != null
                        ? Container(
                            margin: EdgeInsets.only(
                              left: Dim.screenUtilOnHorizontal(Dim.margin10),
                            ),
                            child: Image.network(
                              _topListItems[index].iconUrl!,
                              width: Dim.screenUtilOnHorizontal(20),
                              height: Dim.screenUtilOnVertical(20),
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
