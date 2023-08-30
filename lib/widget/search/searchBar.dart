import 'dart:async';

import 'package:cloud_music/provider/searchBarState.dart';
import 'package:cloud_music/resource/appIcon.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget {
  final bool decorationColorGradientType;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final IconData? rightIcon;
  final VoidCallback? onTap;
  final VoidCallback? rightIconOnTap;

  const CustomSearchBar({
    Key? key,
    required this.decorationColorGradientType,
    this.gradientStartColor,
    this.gradientEndColor,
    this.onTap,
    this.rightIcon,
    this.rightIconOnTap,
  })  : assert(
          !decorationColorGradientType ||
              (gradientStartColor != null && gradientEndColor != null),
          'If decorationColorGradientType is true, gradientStartColor and gradientEndColor must not be null',
        ),
        assert(rightIcon != null || rightIconOnTap == null,
            'If rightIcon is null, rightIconOnTap must be null'),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomSearchBarState();
  }
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  Timer? timer;
  String? defaultSearchText;

  void startTimer() {
    timer = Timer.periodic(
      Duration(seconds: Constants.requestDefaultSearchTextInterval),
      (timer) async {
        String defaultSearchText = await NetworkRequest.getDefaultSearchWord();
        setState(
          () {
            this.defaultSearchText = defaultSearchText;
            Provider.of<SearchBarState>(context, listen: false).searchText =
                defaultSearchText;
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (Provider.of<SearchBarState>(context, listen: false).autoUpdate) {
      startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
        timer?.cancel();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Dim.screenUtilOnVertical(Dim.padding6),
          horizontal: Dim.screenUtilOnHorizontal(Dim.padding6),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: widget.decorationColorGradientType ? null : Colors.white,
            gradient: widget.decorationColorGradientType
                ? LinearGradient(
                    colors: [
                      widget.gradientStartColor!,
                      widget.gradientEndColor!,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(Dim.borderRadius20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dim.screenUtilOnVertical(Dim.padding6),
                horizontal: Dim.screenUtilOnHorizontal(Dim.padding6)),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: Dim.screenUtilOnHorizontal(Dim.padding6),
                  ),
                  child: const Icon(
                    Icons.search,
                  ),
                ),
                Expanded(
                  child: Text(
                    Provider.of<SearchBarState>(context, listen: false)
                            .autoUpdate
                        ? defaultSearchText ?? ""
                        : Provider.of<SearchBarState>(context)
                                .searchText
                                .isNotEmpty
                            ? Provider.of<SearchBarState>(context).searchText
                            : Constants.defaultSearchText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(Dim.fontSize15),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: Dim.screenUtilOnHorizontal(Dim.padding6),
                  ),
                  child: GestureDetector(
                    onTap: widget.rightIconOnTap,
                    child: Icon(widget.rightIcon),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
