import 'package:cloud_music/model/user/topListSinger.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:cloud_music/widget/image/avatar.dart';
import 'package:flutter/material.dart';
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
          leading: Avatar(
            url: widget._singer.picUrl ?? '',
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
                artist != null &&
                        artist?.userProfile != null &&
                        artist!.userProfile!.followed!
                    ? "已关注"
                    : "+关注",
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
