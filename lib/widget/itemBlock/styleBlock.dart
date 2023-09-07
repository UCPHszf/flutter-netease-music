import 'package:cloud_music/model/style/musicStyle.dart';
import 'package:cloud_music/resource/appIcon.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:flutter/material.dart';

import '../../model/pageArgs.dart';
import '../../resource/color.dart';
import '../../resource/constants.dart';

class StyleBlock extends StatelessWidget {
  final MusicStyle _style;

  const StyleBlock({super.key, required MusicStyle style}) : _style = style;

  void navigatorToStyleDetailPage(BuildContext context, MusicStyle style) {
    Navigator.of(context).pushNamed(
      Constants.styleDetailPageRoute,
      arguments: PageArgument(
        args: {Constants.pageArgumentStyleId: style.tagId},
      ),
    );
  }

  Widget childrenTags() {
    List<MusicStyle> tags = MusicStyle.parseChildrenTags(_style);
    if (tags.isEmpty) {
      return Container();
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tags.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: Dim.screenUtilOnVertical(Dim.margin5),
            ),
            child: GestureDetector(
              onTap: () {
                navigatorToStyleDetailPage(context, tags[index]);
              },
              child: ListTile(
                title: Text(
                  tags[index].tagName,
                  style: TextStyle(
                    fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                    color: AppColor.grey,
                  ),
                ),
                subtitle: Text(
                  tags[index].enName!,
                  style: TextStyle(
                    fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                    color: Colors.grey.shade400,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    //todo:播放该风格的歌曲
                  },
                  child: const Icon(
                    AppIcon.playCircle,
                    color: AppColor.grey,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dim.screenUtilOnHorizontal(Dim.padding15),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              navigatorToStyleDetailPage(context, _style);
            },
            child: ListTile(
              title: Text(
                _style.tagName,
                style: TextStyle(
                  fontSize: Dim.screenUtilOnSp(Dim.fontSize20),
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              subtitle: Text(
                _style.enName!,
                style: TextStyle(
                  fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
                  color: AppColor.grey,
                ),
              ),
              trailing: GestureDetector(
                onTap: () {},
                child: const Icon(
                  AppIcon.playCircle,
                  color: AppColor.grey,
                ),
              ),
            ),
          ),
          Divider(
            height: Dim.screenUtilOnVertical(1),
            color: AppColor.grey,
          ),
          childrenTags(),
        ],
      ),
    );
  }
}
