import 'package:flutter/material.dart';

import '../../resource/dim.dart';

class ClipRRectImage extends StatelessWidget {
  final String? url;
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
    this.url,
    this.errorWidget,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dim.screenUtilOnSp(10)),
      child: url == null || url!.isEmpty
          ? placeholder ?? Container()
          : Image.network(
              url!,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return errorWidget ?? Container();
              },
            ),
    );
  }
}
