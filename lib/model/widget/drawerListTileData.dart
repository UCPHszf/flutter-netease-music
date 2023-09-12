import 'package:flutter/material.dart';

class DrawerListTileData {
  final String titleText;
  final String? subTitleText;
  final IconData? leadingIcon;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final ShapeBorder? shape;

  const DrawerListTileData({
    required this.titleText,
    this.subTitleText,
    this.leadingIcon,
    this.trailingWidget,
    this.onTap,
    this.shape,
  });
}
