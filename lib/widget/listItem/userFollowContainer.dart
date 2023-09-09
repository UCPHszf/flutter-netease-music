import 'package:cloud_music/resource/color.dart';
import 'package:flutter/material.dart';

import '../../resource/dim.dart';

class UserFollowContainer extends StatefulWidget {
  const UserFollowContainer({
    Key? key,
    required this.followed,
    required this.accountId,
    this.width = 60,
    this.height = 30,
  }) : super(key: key);

  final bool followed;
  final int accountId;
  final double width;
  final double height;

  @override
  State<StatefulWidget> createState() {
    return _UserFollowContainerState();
  }
}

class _UserFollowContainerState extends State<UserFollowContainer> {
  bool _followed = false;

  @override
  void initState() {
    super.initState();
    _followed = widget.followed;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo 关注/取消关注
      },
      child: Container(
        width: Dim.screenUtilOnHorizontal(widget.width),
        height: Dim.screenUtilOnVertical(widget.height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.followed ? AppColor.grey : AppColor.red,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            widget.followed ? "已关注" : "+关注",
            style: TextStyle(
              color: widget.followed ? AppColor.grey : AppColor.red,
              fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
            ),
          ),
        ),
      ),
    );
  }
}
