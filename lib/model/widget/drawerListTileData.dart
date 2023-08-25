import 'package:flutter/material.dart';

class DrawerListTileData {
  String text;
  String? trailingText;
  IconData icon;
  Function onTap;

  DrawerListTileData({
    required this.text,
    required this.trailingText,
    required this.icon,
    required this.onTap,
  });
}
