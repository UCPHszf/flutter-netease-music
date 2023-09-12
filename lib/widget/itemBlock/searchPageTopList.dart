import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../model/song/topListSong.dart';
import '../../provider/upstreamSettingState.dart';
import '../../resource/color.dart';
import '../../util/dependencies.dart';

class SearchPageTopList extends StatelessWidget {
  SearchPageTopList({
    Key? key,
    required String listTitle,
    Widget? actions,
    List<TopListSong>? data,
  })  : _listTitle = listTitle,
        _data = data,
        _actions = actions,
        super(key: key);

  final Widget? _actions;
  final String _listTitle;
  final List<TopListSong>? _data;

  Logger logger = getIt<Logger>();

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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: Dim.screenUtilOnVertical(Dim.margin10),
                ),
                child: Text(
                  _listTitle,
                  style: TextStyle(
                    fontSize: Dim.screenUtilOnSp(Dim.fontSize20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _actions ?? Container(),
            ],
          ),
          const Divider(
            color: AppColor.dividerColor,
            height: 1,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _data!.length,
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
                          _data![index].text,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                            overflow: TextOverflow.ellipsis,
                            fontWeight:
                                index > 2 ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                      ),
                      _data![index].iconUrl != null
                          ? Container(
                              margin: EdgeInsets.only(
                                left: Dim.screenUtilOnHorizontal(Dim.margin10),
                              ),
                              child: Image.network(
                                _data![index].iconUrl!,
                                width: Dim.screenUtilOnHorizontal(20),
                                height: Dim.screenUtilOnVertical(20),
                                errorBuilder: (context, error, stackTrace) {
                                  logger.e(error);
                                  return Container();
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
