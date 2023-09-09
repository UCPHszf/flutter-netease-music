import 'package:flutter/material.dart';

class StyleArtistItem extends StatefulWidget {
  const StyleArtistItem({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StyleArtistItemState();
  }
}

class _StyleArtistItemState extends State<StyleArtistItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo 跳转到歌手详情页
      },
      child: ListTile(),
    );
  }
}
