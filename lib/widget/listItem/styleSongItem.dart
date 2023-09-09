import 'package:cloud_music/model/user/artist.dart';
import 'package:cloud_music/resource/color.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/widget/image/ClipRRectImage.dart';
import 'package:flutter/material.dart';

import '../../model/song/song.dart';

class StyleSongItem extends StatelessWidget {
  const StyleSongItem({Key? key, required this.song}) : super(key: key);
  final Song song;

  String _getSubTitle() {
    List<ArtistProfile> artist = song.artists ?? [];
    String artistName = artist.isNotEmpty ? artist[0].name : "";
    String albumName = song.album != null ? song.album!.name : "";
    return "$artistName - $albumName";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo : play song
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dim.screenUtilOnHorizontal(Dim.styleDetailListPadding),
        ),
        // rectangle image
        leading: ClipRRectImage(
          url: song.album?.picUrl ?? '',
          width: Dim.screenUtilOnHorizontal(Dim.styleDetailDataItemImageWidth),
          height: Dim.screenUtilOnVertical(Dim.styleDetailDataItemImageHeight),
        ),
        title: Text(
          song.name,
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
        trailing: GestureDetector(
          onTap: () {
            //todo:more operation
          },
          child: const Icon(Icons.more_vert, size: 20),
        ),
      ),
    );
  }
}
