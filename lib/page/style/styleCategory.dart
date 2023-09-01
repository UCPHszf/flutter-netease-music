import 'package:cloud_music/model/style/musicStyle.dart';
import 'package:cloud_music/resource/appIcon.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:cloud_music/widget/itemBlock/styleBlock.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../resource/color.dart';
import '../../resource/constants.dart';
import '../../resource/dim.dart';
import '../../util/dependencies.dart';

class StyleCategory extends StatefulWidget {
  const StyleCategory({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StyleCategoryState();
  }
}

class _StyleCategoryState extends State<StyleCategory> {
  final List<MusicStyle> _styleList = [
    MusicStyle.fromJson({
      'tagId': null,
      'tagName': '我的',
      'colorDeep': AppColor.myStylePreferenceColorDeep,
      'colorShallow': AppColor.myStylePreferenceColorShallow,
      'enName': 'myStylePreference',
      'level': 1,
      'showText': '我的',
      'picUrl': '',
      'link': '',
      'tabs': [],
      'childrenTags': []
    })
  ];

  // 一级分类滚动控制器
  late final ScrollController _firstLevelTagScrollController;

  // 二级分类滚动控制器
  late final ScrollController _secondLevelTagScrollController;

  // 一级分类高度
  double categoryItemHeight = Dim.screenUtilOnVertical(50);

  // 顶部内容高度
  double topContentHeight = Dim.screenUtilOnVertical(180);

  // 一级分类选中的index
  int _fistLevelSelectedTagIndex = 0;

  // 二级分类选中的index
  int _secondLevelSelectedTagIndex = 0;

  // 我的曲风偏好顶部区域展示的列表
  List<MusicStyle> _showedPreferenceList = [];

  final Logger _logger = getIt<Logger>();

  final List<MusicStyle> _stylePreferenceListBrief = [];
  final List<MusicStyle> _stylePreferenceListDetail = [];

  @override
  void initState() {
    super.initState();
    _firstLevelTagScrollController = ScrollController();
    _secondLevelTagScrollController = ScrollController();
    NetworkRequest.styleList().then((value) {
      setState(
        () {
          _styleList.addAll(value);
        },
      );
    });
    NetworkRequest.stylePreference().then((value) {
      setState(() {
        // 因为不太明确顶部哪如如何按ratio划分，所以这里只取前两个
        _stylePreferenceListBrief.addAll(value.$1);
        if (_stylePreferenceListBrief.length > 2) {
          _showedPreferenceList = _stylePreferenceListBrief.sublist(0, 2);
        } else {
          _showedPreferenceList = _stylePreferenceListBrief;
        }
        _stylePreferenceListDetail.addAll(value.$2);
      });
    });
  }

  // 我的曲风偏好右侧顶部内容
  Widget buildMyStylePreferenceTopContent() {
    return Column(
      children: [
        SizedBox(
          height: topContentHeight,
          child: Stack(
            children: [
              Row(
                children: _showedPreferenceList.map(
                  (e) {
                    return Expanded(
                      flex: int.parse(e.ratio!),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Image.network(e.picUrl!).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${e.tagName!}${e.ratio!}%',
                            softWrap: true,
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: Dim.screenUtilOnSp(Dim.fontSize12 +
                                  Dim.fontSize12 * int.parse(e.ratio!) / 100),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
              Positioned(
                left: Dim.screenUtilOnHorizontal(10),
                top: Dim.screenUtilOnVertical(10),
                child: Text(
                  Constants.myStylePreference,
                  style: TextStyle(
                    color: AppColor.grey,
                    fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Dim.screenUtilOnVertical(Dim.padding10),
            horizontal: Dim.screenUtilOnHorizontal(Dim.padding15),
          ),
          child: Row(
            children: [
              const Icon(
                AppIcon.info,
                size: 20,
                color: AppColor.grey,
              ),
              Text(
                Constants.styleDataTip,
                style: TextStyle(
                  fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
                  color: AppColor.grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // 风格分类右侧顶部内容
  Widget buildStyleTopContent() {
    MusicStyle style = _styleList[_fistLevelSelectedTagIndex];
    return SizedBox(
      height: topContentHeight,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.network(style.picUrl!).image,
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: Dim.screenUtilOnHorizontal(10),
                      top: Dim.screenUtilOnVertical(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            style.tagName!,
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: Dim.screenUtilOnSp(Dim.fontSize20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            style.enName!,
                            style: TextStyle(
                              color: AppColor.styleTopContentTextShallow,
                              fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: Dim.screenUtilOnHorizontal(10),
                      bottom: Dim.screenUtilOnVertical(10),
                      child: Text(
                        '${style.showText!} >',
                        style: TextStyle(
                          color: AppColor.styleTopContentTextShallow,
                          fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
                        ),
                      ),
                    ),
                    Positioned(
                      right: Dim.screenUtilOnHorizontal(Dim.margin10),
                      bottom: Dim.screenUtilOnVertical(Dim.margin10),
                      child: GestureDetector(
                        onTap: (){
                          // todo: 播放该风格下的歌曲
                        },
                        child: const Icon(
                          AppIcon.playCircleFilled,
                          color: AppColor.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dim.screenUtilOnHorizontal(Dim.padding10),
                vertical: Dim.screenUtilOnVertical(Dim.padding5),
              ),
              color: AppColor.parseColorString(style.colorDeep!),
              child: ListView.builder(
                controller: _secondLevelTagScrollController,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _secondLevelSelectedTagIndex = index;
                      });

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dim.screenUtilOnHorizontal(Dim.padding5),
                        vertical: Dim.screenUtilOnVertical(Dim.padding5),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index == _secondLevelSelectedTagIndex
                            ? AppColor.brighterColor(style.colorDeep!)
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          MusicStyle.parseChildrenTags(style)[index].tagName!,
                          style: TextStyle(
                            fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                            color: index == _secondLevelSelectedTagIndex
                                ? AppColor.white
                                : AppColor.styleTopContentTextShallow,
                            fontWeight: index == _secondLevelSelectedTagIndex
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: MusicStyle.parseChildrenTags(style).length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _firstLevelTagScrollController.dispose();
    _secondLevelTagScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          Constants.styleCategory,
          style: TextStyle(
            color: AppColor.black,
            fontSize: Dim.screenUtilOnSp(Dim.fontSize20),
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColor.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            // 一级分类
            Expanded(
              flex: 1,
              child: ListView.builder(
                controller: _firstLevelTagScrollController,
                itemCount: _styleList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _fistLevelSelectedTagIndex = index;
                        _secondLevelSelectedTagIndex = 0;
                      });
                    },
                    child: Container(
                      color: index == _fistLevelSelectedTagIndex
                          ? AppColor.parseColorString(
                              _styleList[index].colorShallow!)
                          : Colors.transparent,
                      height: categoryItemHeight,
                      child: Center(
                        child: Text(
                          _styleList[index].tagName!,
                          style: TextStyle(
                            fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                            color: index == _fistLevelSelectedTagIndex
                                ? AppColor.parseColorString(
                                    _styleList[index].colorDeep!)
                                : Colors.grey,
                            fontWeight: index == _fistLevelSelectedTagIndex
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverToBoxAdapter(
                    child: _fistLevelSelectedTagIndex == 0
                        ? buildMyStylePreferenceTopContent()
                        : buildStyleTopContent(),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      _fistLevelSelectedTagIndex == 0
                          ? _stylePreferenceListDetail
                              .map((e) => StyleBlock(
                                    style: e,
                                  ))
                              .toList()
                          : MusicStyle.parseChildrenTags(
                                  _styleList[_fistLevelSelectedTagIndex])
                              .map((e) => StyleBlock(
                                    style: e,
                                  ))
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
