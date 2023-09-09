import 'package:cloud_music/model/song/album.dart';
import 'package:cloud_music/resource/color.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/widget/clipper/styleAlbumItemTopClipper.dart';
import 'package:cloud_music/widget/image/ClipRRectImage.dart';
import 'package:flutter/material.dart';

class StyleAlbumItem extends StatelessWidget {
  final Album album;

  const StyleAlbumItem({super.key, required this.album});

  String _getSubTitle() {
    String authorName = album.artist?.name ?? "";
    String albumPublishDate = album.getDateOfPublish();
    return "$authorName, $albumPublishDate";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo: 跳转专辑详情
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dim.screenUtilOnHorizontal(Dim.styleDetailListPadding),
        ),
        leading: Column(
          children: [
            ClipPath(
              clipper: StyleAlbumItemTopClipper(),
              child: Container(
                width: Dim.screenUtilOnHorizontal(
                    Dim.styleDetailDataItemImageWidth),
                height: Dim.screenUtilOnVertical(
                    10),
                color: AppColor.black,
              ),
            ),
            Expanded(
              child: ClipRRectImage(
                url: album.picUrl ?? '',
                width: Dim.screenUtilOnHorizontal(
                    Dim.styleDetailDataItemImageWidth),
                height: Dim.screenUtilOnVertical(
                    Dim.styleDetailDataItemImageHeight),
              ),
            ),
          ],
        ),
        title: Text(
          album.name,
          style: TextStyle(
            fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          _getSubTitle(),
          style: TextStyle(
            fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
            color: AppColor.grey,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
