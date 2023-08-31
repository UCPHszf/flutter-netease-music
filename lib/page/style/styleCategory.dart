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
  late final ScrollController _firstLevelTagScrollController;
  late final ScrollController _secondLevelTagScrollController;
  double categoryItemHeight = Dim.screenUtilOnVertical(50);
  double topContentHeight = Dim.screenUtilOnVertical(180);
  int _selectedTagIndex = 0;
  final Logger _logger = getIt<Logger>();
  List<MusicStyle> _showedPreferenceList = [];

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

  Widget buildStyleTopContent() {
    return SizedBox(
      height: topContentHeight,
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
            Expanded(
              flex: 1,
              child: ListView.builder(
                controller: _firstLevelTagScrollController,
                itemCount: _styleList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTagIndex = index;
                      });
                    },
                    child: Container(
                      color: index == _selectedTagIndex
                          ? AppColor.parseColorString(
                              _styleList[index].colorShallow!)
                          : Colors.transparent,
                      height: categoryItemHeight,
                      child: Center(
                        child: Text(
                          _styleList[index].tagName!,
                          style: TextStyle(
                            fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                            color: index == _selectedTagIndex
                                ? AppColor.parseColorString(
                                    _styleList[index].colorDeep!)
                                : Colors.grey,
                            fontWeight: index == _selectedTagIndex
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
                    child: _selectedTagIndex == 0
                        ? buildMyStylePreferenceTopContent()
                        : buildStyleTopContent(),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      _selectedTagIndex == 0
                          ? _stylePreferenceListDetail
                              .map((e) => StyleBlock(
                                    style: e,
                                  ))
                              .toList()
                          : MusicStyle.parseChildrenTags(
                                  _styleList[_selectedTagIndex])
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
