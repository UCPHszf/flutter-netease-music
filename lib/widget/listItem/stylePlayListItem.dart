import 'package:cloud_music/model/song/playlist.dart';
import 'package:cloud_music/widget/clipper/stylePlaylistItemTopClipper.dart';
import 'package:cloud_music/widget/image/ClipRRectImage.dart';
import 'package:flutter/material.dart';

import '../../resource/dim.dart';

class StylePlayListItem extends StatelessWidget {
  final PlayList playList;

  const StylePlayListItem({Key? key, required this.playList}) : super(key: key);

  String _subtitle() {
    return "${playList.songCount}首, by ${playList.userName}, 播放${playList.showedPlayCount()}次";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo: 跳转歌单详情
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dim.screenUtilOnHorizontal(Dim.styleDetailListPadding),
        ),
        leading: Column(
          children: [
            ClipPath(
              clipper: StylePlaylistItemTopClipper(),
              child: Container(
                width: Dim.screenUtilOnHorizontal(
                    Dim.styleDetailDataItemImageWidth),
                height: Dim.screenUtilOnVertical(8),
                color: Colors.grey.shade200,
              ),
            ),
            Expanded(
              child: ClipRRectImage(
                url: playList.cover,
                width: Dim.screenUtilOnHorizontal(Dim.styleDetailDataItemImageWidth),
                height: Dim.screenUtilOnVertical(Dim.styleDetailDataItemImageHeight),
              ),
            ),
          ],
        ),
        title: Text(
          playList.name,
          style: TextStyle(
            fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          _subtitle(),
          style: TextStyle(
            fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
            color: Colors.grey,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
