import 'package:cloud_music/resource/dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDrawer extends StatelessWidget {
  List<Widget> drawerBlocks;

  HomeDrawer({Key? key, required this.drawerBlocks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          // there should be a divider between each block of drawer item, there should not be a divider after the last block
          return Column(
            children: [
              drawerBlocks[index],
              if (index != drawerBlocks.length - 1)
                Divider(
                  height: Dim.screenUtilOnVertical(
                      Dim.drawerItemDividingLineHeight),
                  color: Colors.grey[300],
                )
            ],
          );
        },
      ),
    );
  }
}
