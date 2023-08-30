import 'package:cloud_music/resource/color.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:cloud_music/widget/listItem/topListSingeritem.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/user/topListSinger.dart';
import '../util/dependencies.dart';

class SingerCategory extends StatefulWidget {
  const SingerCategory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SingerCategoryState();
  }
}

class _SingerCategoryState extends State<SingerCategory> {
  late ScrollController _scrollController;
  List<TopListSinger> data = [];
  Logger logger = getIt<Logger>();

  int defaultSelectedIndex = -1;
  int selectedArea = -1;
  int selectedType = -1;
  final singerAreaArr = ["华语", "欧美", "日本", "韩国", "其他"];
  final singerTypeArr = ["男", "女", "乐队/组合"];

  final singerAreaCode = [
    Constants.singerAreaCN,
    Constants.singerAreaEUNA,
    Constants.singerAreaJP,
    Constants.singerAreaKR,
    Constants.singerAreaOther
  ];

  final singerTypeCode = [
    Constants.singerTypeMale,
    Constants.singerTypeFemale,
    Constants.singerTypeBand
  ];

  void requestSingerData() {
    NetworkRequest.artistList(
            singerArea: singerAreaCode[selectedArea],
            singerType: singerTypeCode[selectedType])
        .then((value) {
      if (context.mounted) {
        setState(() {
          data = value;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    NetworkRequest.hotSingerList().then((value) {
      if (context.mounted) {
        setState(() {
          data = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          Constants.singerCategory,
          style: TextStyle(
            color: AppColor.black,
            fontSize: Dim.screenUtilOnSp(Dim.fontSize20),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            Dim.screenUtilOnVertical(100),
          ),
          child: Column(
            children: [
              Row(
                children: singerAreaArr
                    .asMap()
                    .map(
                      (index, value) {
                        return MapEntry(
                          index,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedArea = index;
                              });
                              if (selectedType == defaultSelectedIndex) {
                                setState(() {
                                  selectedType = 0;
                                });
                              }
                              requestSingerData();
                            },
                            child: Container(
                              width: Dim.screenUtilOnHorizontal(40),
                              margin: EdgeInsets.symmetric(
                                horizontal: Dim.screenUtilOnHorizontal(10),
                              ),
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: selectedArea == index
                                      ? AppColor.red
                                      : AppColor.grey,
                                  fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    .values
                    .toList(),
              ),
              SizedBox(
                height: Dim.screenUtilOnVertical(Dim.margin15),
              ),
              Row(
                children: singerTypeArr
                    .asMap()
                    .map(
                      (index, value) {
                        if (index == singerTypeArr.length - 1) {
                          return MapEntry(
                            index,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedType = index;
                                });
                                if (selectedArea == defaultSelectedIndex) {
                                  setState(() {
                                    selectedArea = 0;
                                  });
                                }
                                requestSingerData();
                              },
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: selectedType == index
                                      ? AppColor.red
                                      : AppColor.grey,
                                  fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          );
                        } else {
                          return MapEntry(
                            index,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedType = index;
                                });
                                if (selectedArea == defaultSelectedIndex) {
                                  setState(() {
                                    selectedArea = 0;
                                  });
                                }
                                requestSingerData();
                              },
                              child: Container(
                                width: Dim.screenUtilOnHorizontal(40),
                                margin: EdgeInsets.symmetric(
                                  horizontal: Dim.screenUtilOnHorizontal(10),
                                ),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: selectedType == index
                                        ? AppColor.red
                                        : AppColor.grey,
                                    fontSize:
                                        Dim.screenUtilOnSp(Dim.fontSize15),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    )
                    .values
                    .toList(),
              ),
              SizedBox(
                height: Dim.screenUtilOnVertical(Dim.margin15),
              ),
              Container(
                color: Colors.grey.shade200,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: Dim.screenUtilOnVertical(Dim.padding5),
                  horizontal: Dim.screenUtilOnHorizontal(Dim.padding10),
                ),
                child: Text(
                  Constants.hotSinger,
                  style: TextStyle(
                    color: AppColor.grey,
                    fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                data.map(
                  (topListSinger) {
                    return TopListSingerItem(singer: topListSinger);
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
