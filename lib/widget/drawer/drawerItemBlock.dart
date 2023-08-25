import 'package:cloud_music/model/widget/drawerListTileData.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/widget/drawer/drawerItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerItemBlock extends StatelessWidget {
  final String itemBlockTitle;
  final List<DrawerListTileData> itemBlockData;

  const DrawerItemBlock(
      {Key? key, required this.itemBlockTitle, required this.itemBlockData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dim.screenUtilOnHorizontal(Dim.padding5),
        vertical: Dim.screenUtilOnVertical(Dim.padding5),
      ),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            itemBlockTitle,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(Dim.fontSize20),
            ),
          ),
          Divider(
            height: Dim.screenUtilOnVertical(Dim.drawerItemDividingLineHeight),
            color: Colors.grey[300],
          ),
          // a column which data is a list of ListTile, there should be a divider between each ListTile, there should not
          //be a divider after the last ListTile
          Column(
            children: [
              for (int i = 0; i < itemBlockData.length; i++)
                Column(
                  children: [
                    DrawerItem(data: itemBlockData[i]),
                    if (i != itemBlockData.length - 1)
                      Divider(
                        height: Dim.screenUtilOnVertical(
                            Dim.drawerItemDividingLineHeight),
                        color: Colors.grey[300],
                      )
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
