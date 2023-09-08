import 'package:flutter/material.dart';

class StyleAlbumItemTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    var path = Path();
    path.moveTo(w / 4, h);
    path.quadraticBezierTo(w / 4, h / 2, w / 2, h / 2);
    path.quadraticBezierTo((3 * w) / 4, h / 2, (3 * w) / 4, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
