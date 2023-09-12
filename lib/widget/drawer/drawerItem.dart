import 'package:cloud_music/model/widget/drawerListTileData.dart';
import 'package:cloud_music/resource/color.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final DrawerListTileData data;

  const DrawerItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: ListTile(
        shape: data.shape,
        tileColor: AppColor.white,
        horizontalTitleGap: Dim.screenUtilOnHorizontal(-5),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dim.screenUtilOnHorizontal(Dim.drawerItemHorizontalPadding),
        ),
        iconColor: AppColor.black,
        title: Text(
          data.titleText,
          style: TextStyle(
            fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
          ),
        ),
        leading: Icon(data.leadingIcon),
        trailing: data.trailingWidget,
        onTap: data.onTap,
      ),
    );
  }
}
