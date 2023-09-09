import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar({
    Key? key,
    required this.url,
    this.radius = 50,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  final String url;
  final double radius;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: radius,
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          placeholder ??
          Container(
            width: radius,
            height: radius,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            width: radius,
            height: radius,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
    );
  }
}
