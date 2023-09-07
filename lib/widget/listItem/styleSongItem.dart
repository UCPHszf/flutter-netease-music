import 'package:cloud_music/model/user/artist.dart';
import 'package:cloud_music/resource/color.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:flutter/material.dart';

import '../../model/song/song.dart';

class StyleSongItem extends StatelessWidget {
  const StyleSongItem({Key? key, required this.song}) : super(key: key);
  final Song song;

  String _getSubTitle() {
    List<Artist> artist = [];
    if (song.artists != null) {
      for (var item in song.artists!) {
        artist.add(Artist.fromSongArtistList(item));
      }
    }
    String artistName = artist.isNotEmpty ? artist[0].name : "";
    String albumName = song.album != null ? song.album!.name : "";
    return "$artistName - $albumName";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.symmetric(
        vertical: Dim.screenUtilOnVertical(Dim.margin5),
      ),
      child: GestureDetector(
        onTap: () {
          //todo : play song
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: Dim.screenUtilOnHorizontal(Dim.styleDetailListPadding),
          ),
          // rectangle image
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(Dim.screenUtilOnSp(10)),
            child: song.album == null
                ? Image.asset(
                    "assets/images/default_album.jpg",
                    width: Dim.screenUtilOnSp(50),
                    height: Dim.screenUtilOnSp(50),
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    song.album!.picUrl!,
                    width: Dim.screenUtilOnSp(50),
                    height: Dim.screenUtilOnSp(50),
                    fit: BoxFit.cover,
                  ),
          ),
          title: Text(
            song.name,
            style: TextStyle(
              fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
              color: Colors.black,
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
      ),
    );
  }
}
