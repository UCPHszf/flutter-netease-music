import 'package:cloud_music/resource/constants.dart';
import 'package:flutter/material.dart';

import '../../resource/color.dart';
import '../../resource/dim.dart';

class ListDataSort extends StatefulWidget {
  ListDataSort({
    Key? key,
    required this.sortVariable,
    this.onSelectSortByHot,
    this.onSelectSortByTime,
  }) : super(key: key);

  int sortVariable;
  VoidCallback? onSelectSortByHot;
  VoidCallback? onSelectSortByTime;

  @override
  State<StatefulWidget> createState() {
    return _ListDataSortState();
  }
}

class _ListDataSortState extends State<ListDataSort> {
  @override
  void initState() {
    super.initState();
  }

  final double dataTopBarWidgetMargin = 3.5;
  double sortByHotTextOpacity = 1;
  double sortByTimeTextOpacity = 1;
  final int fadeInDelay = 50;
  final int fadeOutDelay = 150;

  @override
  Widget build(BuildContext context) {
    Widget marginWidget = SizedBox(
      width: Dim.screenUtilOnHorizontal(dataTopBarWidgetMargin),
    );
    return IntrinsicHeight(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.sortVariable == Constants.sortByTime) {
                setState(() {
                  widget.sortVariable = Constants.sortByHot;
                });
                widget.onSelectSortByHot?.call();
              }

              // fade animation
              Future.delayed(Duration(milliseconds: fadeInDelay), () {
                setState(() {
                  sortByHotTextOpacity = 0;
                });
              });
              Future.delayed(Duration(milliseconds: fadeOutDelay), () {
                setState(() {
                  sortByHotTextOpacity = 1;
                });
              });
            },
            child: AnimatedOpacity(
              opacity: sortByHotTextOpacity,
              duration: const Duration(
                milliseconds: 100,
              ),
              child: Text(
                Constants.sortByHotString,
                style: TextStyle(
                  color: widget.sortVariable == Constants.sortByHot
                      ? AppColor.black
                      : AppColor.grey,
                  fontWeight: widget.sortVariable == Constants.sortByHot
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
          marginWidget,
          VerticalDivider(
            width: Dim.screenUtilOnHorizontal(5),
            color: AppColor.grey,
          ),
          marginWidget,
          SizedBox(
            width: Dim.screenUtilOnHorizontal(dataTopBarWidgetMargin),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (widget.sortVariable == Constants.sortByHot) {
                  widget.sortVariable = Constants.sortByTime;
                  widget.onSelectSortByTime?.call();
                }
                Future.delayed(Duration(milliseconds: fadeInDelay), () {
                  setState(() {
                    sortByTimeTextOpacity = 0;
                  });
                });
                Future.delayed(Duration(milliseconds: fadeOutDelay), () {
                  setState(() {
                    sortByTimeTextOpacity = 1;
                  });
                });
              });
            },
            child: AnimatedOpacity(
              opacity: sortByTimeTextOpacity,
              duration: const Duration(
                milliseconds: 100,
              ),
              child: Text(
                Constants.sortByTimeString,
                style: TextStyle(
                  color: widget.sortVariable == Constants.sortByTime
                      ? AppColor.black
                      : AppColor.grey,
                  fontWeight: widget.sortVariable == Constants.sortByTime
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
