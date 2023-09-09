import 'package:cloud_music/model/style/musicStyle.dart';
import 'package:cloud_music/resource/appIcon.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:cloud_music/widget/itemBlock/styleBlock.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../resource/color.dart';
import '../../resource/constants.dart';
import '../../resource/dim.dart';
import '../../util/dependencies.dart';
import '../../widget/progressIndicator.dart';

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
      'tagId': 0,
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

  // 一级分类高度
  double categoryItemHeight = Dim.screenUtilOnVertical(50);

  // 顶部内容高度
  double topContentHeight = Dim.screenUtilOnVertical(180);

  // scrollable positioned list itemscroll控制器
  late final ItemScrollController _itemScrollController;

  // scroll offset控制器
  late final ScrollOffsetController _scrollOffsetController;
  late final ItemPositionsListener _itemPositionsListener;
  late final ScrollOffsetListener _scrollOffsetListener;

  // 一级分类选中的index
  int _firstLevelSelectedTagIndex = 0;

  // 二级分类选中的index
  int _secondLevelSelectedTagIndex = 0;

  final Logger _logger = getIt<Logger>();

  final future = Future.wait([
    NetworkRequest.styleList(),
    NetworkRequest.stylePreference(),
  ]);

  // 左侧 positioned selected tag是否可见
  bool _fixedTabVisible = false;

  // 右侧 positioned children tags列表是否可见
  bool _positionedSecondLevelTagsVisible = true;

  //
  double rightScrollTotalOffset = 0;

  void updateFixedTabVisibility() {
    double currentOffset = _firstLevelTagScrollController.offset;
    double selectedOffset = _firstLevelSelectedTagIndex * categoryItemHeight;
    if (currentOffset >= selectedOffset) {
      setState(() {
        _fixedTabVisible = true;
      });
    } else {
      setState(() {
        _fixedTabVisible = false;
      });
    }
  }

  @override
  void initState() {
    _firstLevelTagScrollController = ScrollController();
    _itemScrollController = ItemScrollController();
    _scrollOffsetController = ScrollOffsetController();
    _itemPositionsListener = ItemPositionsListener.create();
    _scrollOffsetListener = ScrollOffsetListener.create();
    _scrollOffsetListener.changes.listen((event) {
      rightScrollTotalOffset += event;
      if (rightScrollTotalOffset >= Dim.screenUtilOnVertical(135)) {
        setState(() {
          _positionedSecondLevelTagsVisible = true;
        });
      } else {
        setState(() {
          _positionedSecondLevelTagsVisible = false;
        });
      }
    });

    // NetworkRequest.styleList().then((value) {
    //   setState(
    //         () {
    //       _styleList.addAll(value);
    //     },
    //   );
    // });
    // NetworkRequest.stylePreference().then((value) {
    //   setState(() {
    //     // 因为不太明确顶部哪如如何按ratio划分，所以这里只取前两个
    //     _stylePreferenceListBrief.addAll(value.$1);
    //     if (_stylePreferenceListBrief.length > 2) {
    //       _showedPreferenceList = _stylePreferenceListBrief.sublist(0, 2);
    //     } else {
    //       _showedPreferenceList = _stylePreferenceListBrief;
    //     }
    //     _stylePreferenceListDetail.addAll(value.$2);
    //   });
    // });
    super.initState();
  }

  List<MusicStyle> getShowedPreferenceList(List<MusicStyle> data) {
    return data.length > 2 ? data.sublist(0, 2) : data;
  }

  @override
  void dispose() {
    _firstLevelTagScrollController.dispose();
    super.dispose();
  }

  // 我的曲风偏好右侧顶部内容
  Widget buildMyStylePreferenceTopContent(
      List<MusicStyle> showedPreferenceList) {
    return Column(
      children: [
        SizedBox(
          height: topContentHeight,
          child: Stack(
            children: [
              Row(
                children: showedPreferenceList.map(
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
                            '${e.tagName}${e.ratio}%',
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
                    color: AppColor.styleTopContentTextShallow,
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
    MusicStyle style = _styleList[_firstLevelSelectedTagIndex];
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
                            style.tagName??'',
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
                        onTap: () {
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
              // 二级分类
              child: ScrollablePositionedList.builder(
                itemCount: MusicStyle.parseChildrenTags(style).length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _secondLevelSelectedTagIndex = index;
                      });
                      _itemScrollController.scrollTo(
                        index: _secondLevelSelectedTagIndex + 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOutCubic,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dim.screenUtilOnHorizontal(Dim.padding10),
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
                          MusicStyle.parseChildrenTags(style)[index].tagName ??
                              "",
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<MusicStyle> allTags = snapshot.data[0];
          _styleList.addAll(allTags);
          List<MusicStyle> tagPreferenceVos = snapshot.data[1].$1;
          List<MusicStyle> preferenceTags = snapshot.data[1].$2;
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
                  // 左侧一级分类
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        ListView.builder(
                          controller: _firstLevelTagScrollController,
                          itemCount: _styleList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  // 需要先移除listener再添加 因为listener无法监听_firstLevelSelectedTagIndex的变化
                                  _firstLevelTagScrollController
                                      .removeListener(() {
                                    updateFixedTabVisibility();
                                  });
                                  setState(() {
                                    _fixedTabVisible = false;
                                  });
                                  _firstLevelTagScrollController
                                      .addListener(() {
                                    updateFixedTabVisibility();
                                  });
                                  _firstLevelSelectedTagIndex = index;

                                  // 二级分类选中的index重置为0
                                  _secondLevelSelectedTagIndex = 0;
                                  if (_itemScrollController.isAttached) {
                                    _itemScrollController.jumpTo(index: 0);
                                  }

                                  // 右侧scroll offset重置为0
                                  _positionedSecondLevelTagsVisible = false;
                                  rightScrollTotalOffset = 0;
                                });
                              },
                              child: Container(
                                color: index == _firstLevelSelectedTagIndex
                                    ? AppColor.parseColorString(
                                        _styleList[index].colorShallow!)
                                    : Colors.transparent,
                                height: categoryItemHeight,
                                child: Center(
                                  child: Text(
                                    _styleList[index].tagName ?? "",
                                    style: TextStyle(
                                      fontSize:
                                          Dim.screenUtilOnSp(Dim.fontSize15),
                                      color:
                                          index == _firstLevelSelectedTagIndex
                                              ? AppColor.parseColorString(
                                                  _styleList[index].colorDeep!)
                                              : Colors.grey,
                                      fontWeight:
                                          index == _firstLevelSelectedTagIndex
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // 一级分类选中的tag，当左侧一级分类列表滑动到选中tag下方时，该tag会固定在顶部
                        Visibility(
                          visible: _fixedTabVisible,
                          child: Positioned(
                            left: 0,
                            top: 0,
                            right: 0,
                            child: Container(
                              color: AppColor.parseColorString(
                                  _styleList[_firstLevelSelectedTagIndex]
                                      .colorShallow!),
                              height: categoryItemHeight,
                              child: Center(
                                child: Text(
                                  _styleList[_firstLevelSelectedTagIndex]
                                          .tagName ??
                                      "",
                                  style: TextStyle(
                                      fontSize:
                                          Dim.screenUtilOnSp(Dim.fontSize15),
                                      color: AppColor.parseColorString(
                                          _styleList[
                                                  _firstLevelSelectedTagIndex]
                                              .colorDeep!),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 右侧内容
                  Expanded(
                    flex: 3,
                    child: _firstLevelSelectedTagIndex == 0
                        ? Column(
                            children: [
                              buildMyStylePreferenceTopContent(
                                  getShowedPreferenceList(tagPreferenceVos)),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return StyleBlock(
                                      style: preferenceTags[index],
                                    );
                                  },
                                  itemCount: preferenceTags.length,
                                  physics: const BouncingScrollPhysics(),
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              ScrollablePositionedList.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: MusicStyle.parseChildrenTags(
                                            _styleList[
                                                _firstLevelSelectedTagIndex])
                                        .length +
                                    1,
                                itemScrollController: _itemScrollController,
                                scrollOffsetController: _scrollOffsetController,
                                itemPositionsListener: _itemPositionsListener,
                                scrollOffsetListener: _scrollOffsetListener,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return buildStyleTopContent();
                                  } else {
                                    return StyleBlock(
                                      style: MusicStyle.parseChildrenTags(
                                              _styleList[
                                                  _firstLevelSelectedTagIndex])[
                                          index - 1],
                                    );
                                  }
                                },
                              ),
                              // 浮动在右侧上方的二级分类列表
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                child: Visibility(
                                  visible: _positionedSecondLevelTagsVisible,
                                  child: Container(
                                    height:
                                        Dim.screenUtilOnVertical(180 * (1 / 4)),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dim.screenUtilOnHorizontal(
                                          Dim.padding10),
                                      vertical: Dim.screenUtilOnVertical(
                                          Dim.padding5),
                                    ),
                                    color: AppColor.parseColorString(
                                        _styleList[_firstLevelSelectedTagIndex]
                                            .colorShallow!),
                                    child: ScrollablePositionedList.builder(
                                      itemCount: MusicStyle.parseChildrenTags(
                                              _styleList[
                                                  _firstLevelSelectedTagIndex])
                                          .length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _secondLevelSelectedTagIndex =
                                                  index;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Dim.screenUtilOnHorizontal(
                                                      Dim.padding10),
                                              vertical:
                                                  Dim.screenUtilOnVertical(
                                                      Dim.padding5),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: index ==
                                                      _secondLevelSelectedTagIndex
                                                  ? AppColor.darkerColor(
                                                      _styleList[
                                                              _firstLevelSelectedTagIndex]
                                                          .colorShallow!,
                                                      0.05)
                                                  : Colors.transparent,
                                            ),
                                            child: Center(
                                              child: Text(
                                                MusicStyle.parseChildrenTags(
                                                                _styleList[
                                                                    _firstLevelSelectedTagIndex])[
                                                            index]
                                                        .tagName ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: Dim.screenUtilOnSp(
                                                      Dim.fontSize15),
                                                  color: AppColor.parseColorString(
                                                      _styleList[
                                                              _firstLevelSelectedTagIndex]
                                                          .colorDeep!),
                                                  fontWeight: index ==
                                                          _secondLevelSelectedTagIndex
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
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const AppProgressIndicator();
        }
      },
    );
  }
}
