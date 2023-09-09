import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../resource/dim.dart';

class ClipRRectImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? errorWidget;
  final Widget? placeholder;

  const ClipRRectImage({
    Key? key,
    this.width = 50,
    this.height = 50,
    this.fit = BoxFit.cover,
    required this.url,
    this.errorWidget,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dim.screenUtilOnSp(10)),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ??
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
      ),
    );
  }
}
