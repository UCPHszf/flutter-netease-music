import 'package:cloud_music/model/user/topListSinger.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/user/artist.dart';

class TopListSingerItem extends StatefulWidget {
  const TopListSingerItem({Key? key, required TopListSinger singer})
      : _singer = singer,
        super(key: key);

  final TopListSinger _singer;

  @override
  State<StatefulWidget> createState() {
    return _TopListSingerItemState();
  }
}

class _TopListSingerItemState extends State<TopListSingerItem> {
  String showedTitle(TopListSinger singer) {
    String showedTitle = singer.name;
    if (singer.alias.isNotEmpty) {
      showedTitle += "(${singer.alias[0].toString()})";
    }
    return showedTitle;
  }

  Artist? artist;
  Color trailingColor = Colors.red;

  @override
  void initState() {
    super.initState();
    NetworkRequest.artistDetail(widget._singer.id).then((value) {
      if (mounted) {
        setState(() {
          if (value != null) {
            artist = value;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: ClipOval(
            child: widget._singer.picUrl == null
                ? Image.asset(
                    "assets/images/placeholder_disk_play_song.png",
                    width: Dim.screenUtilOnHorizontal(50),
                    height: Dim.screenUtilOnVertical(50),
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    widget._singer.picUrl!,
                    width: Dim.screenUtilOnHorizontal(50),
                    height: Dim.screenUtilOnVertical(50),
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      );
                    },
                  ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  showedTitle(widget._singer),
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          trailing: Container(
            width: Dim.screenUtilOnHorizontal(60),
            height: Dim.screenUtilOnVertical(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: trailingColor,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                artist != null && artist!.followed! ? "已关注" : "+关注",
                style: TextStyle(
                  color: trailingColor,
                  fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
