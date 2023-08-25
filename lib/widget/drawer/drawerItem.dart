import 'package:cloud_music/model/widget/drawerListTileData.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final DrawerListTileData data;

  const DrawerItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Text(data.text),
        leading: Icon(data.icon),
        trailing: Row(
          children: [
            if (data.trailingText != null)
              Text(
                data.trailingText!,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.right,
              ),
            const Icon(Icons.arrow_right)
          ],
        ),
        onTap: data.onTap as void Function()?,
      ),
    );
  }
}
