import 'package:flutter/material.dart';

class StylePlaylistItemTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;
    Path path = Path();
    path.moveTo(w / 8, h);
    path.quadraticBezierTo(w / 8, h / 2, w / 8 + 2, h / 2 - 1);
    path.lineTo((7 * w) / 8 - 2, h / 2 - 1);
    path.quadraticBezierTo((7 * w) / 8, h / 2, (7 * w) / 8, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
