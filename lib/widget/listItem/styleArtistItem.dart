import 'package:cloud_music/model/user/artist.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/widget/listItem/userFollowContainer.dart';
import 'package:flutter/material.dart';

class StyleArtistItem extends StatefulWidget {
  const StyleArtistItem({
    Key? key,
    required this.artistProfile,
  }) : super(key: key);

  final ArtistProfile artistProfile;

  @override
  State<StatefulWidget> createState() {
    return _StyleArtistItemState();
  }
}

class _StyleArtistItemState extends State<StyleArtistItem> {
  String _getSubtitle() {
    int? fansCount = widget.artistProfile.fansCount;
    if (fansCount == null) {
      return "0粉丝";
    }
    if (fansCount < 100000) {
      return "$fansCount粉丝";
    }
    return "${(fansCount / 10000).toStringAsFixed(1)}万粉丝";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo 跳转到歌手详情页
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.artistProfile.picUrl!),
          radius: 30,
        ),
        title: Text(
          widget.artistProfile.name,
          style: TextStyle(
            fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          _getSubtitle(),
          style: TextStyle(
            fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
            color: Colors.grey,
          ),
        ),
        trailing: UserFollowContainer(
          followed: widget.artistProfile.followed != null
              ? widget.artistProfile.followed!
              : false,
          accountId: widget.artistProfile.accountId!,
          width: 60,
          height: 30,
        ),
      ),
    );
  }
}
