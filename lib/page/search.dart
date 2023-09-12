import 'package:cloud_music/provider/searchBarState.dart';
import 'package:cloud_music/resource/color.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/resource/enum.dart';
import 'package:cloud_music/widget/progressIndicator.dart';
import 'package:cloud_music/widget/search/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/song/topListSong.dart';
import '../provider/upstreamSettingState.dart';
import '../util/NetworkRequest.dart';
import '../util/dependencies.dart';
import '../widget/itemBlock/searchPageTopList.dart';
import '../widget/search/subSearchCategory.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const double _dividerWidth = 1;
  static const double _dividerIndent = 3;
  static const double _dividerEndIndent = 3;
  static const double _dividerThickness = 1;

  static const divider = VerticalDivider(
    color: AppColor.dividerColor,
    width: _dividerWidth,
    thickness: _dividerThickness,
    indent: _dividerIndent,
    endIndent: _dividerEndIndent,
  );

  late final List<Widget> subSearchCategoryList;
  late final List<String> loadedTopList;
  late final UpstreamPageSettingState pageSettingState;
  Logger logger = getIt<Logger>();

  Future<List<List<TopListSong>>> getAllTopListData() async {
    final List<Future<List<TopListSong>>> listOfFutures = [];
    for (int i = 0; i < loadedTopList.length; i++) {
      listOfFutures.add(NetworkRequest.topList(
        topListType: TopListType.songList,
        topListId: pageSettingState.allTopList[loadedTopList[i]],
      ));
    }
    final result = await Future.wait(listOfFutures);
    return result;
  }

  @override
  void initState() {
    super.initState();
    subSearchCategoryList = [
      SubSearchCategory(
        title: Constants.singer,
        icon: Icons.person,
        iconColor: AppColor.subCategoryIconColor,
        onTap: () {
          Navigator.pushNamed(context, Constants.singerCategoryPageRoute);
        },
      ),
      divider,
      SubSearchCategory(
        title: Constants.musicStyle,
        icon: Icons.library_music,
        iconColor: AppColor.subCategoryIconColor,
        onTap: () {
          Navigator.pushNamed(context, Constants.styleCategoryPageRoute);
        },
      ),
      divider,
      SubSearchCategory(
        title: Constants.songRecognition,
        icon: Icons.keyboard_voice,
        iconColor: AppColor.subCategoryIconColor,
        onTap: () {},
      ),
    ];
    pageSettingState = Provider.of<UpstreamPageSettingState>(context, listen: false);
    loadedTopList = pageSettingState.searchPageTopList;
    loadedTopList.retainWhere(
      (element) => pageSettingState.allTopList.containsKey(element),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        NetworkRequest.topList(topListType: TopListType.hotSearch),
        getAllTopListData()
      ]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
                leading: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dim.screenUtilOnHorizontal(Dim.padding15)),
                  child: BackButton(
                    onPressed: () {
                      Provider.of<SearchBarState>(context, listen: false)
                          .autoUpdate = true;
                      Navigator.pop(context);
                    },
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dim.screenUtilOnHorizontal(Dim.padding15)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          Constants.search,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dim.screenUtilOnSp(Dim.fontSize20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                title: CustomSearchBar(
                  onTap: () {},
                  decorationColorGradientType: false,
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                    Dim.screenUtilOnVertical(40),
                  ),
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: subSearchCategoryList,
                        ),
                      ),
                      SizedBox(
                        height: Dim.screenUtilOnVertical(5),
                      ),
                    ],
                  ),
                )),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dim.screenUtilOnVertical(0),
                ),
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Dim.screenUtilOnVertical(1000),
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                Dim.screenUtilOnHorizontal(Dim.padding15),
                            vertical: Dim.screenUtilOnVertical(Dim.padding15),
                          ),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return SearchPageTopList(
                                  listTitle: Constants.topListHotSearch,
                                  data: snapshot.data[0]);
                            } else {
                              return SearchPageTopList(
                                listTitle: loadedTopList[index - 1],
                                data: snapshot.data[1][index - 1].length >=
                                        pageSettingState.searchPageTopListLimit
                                    ? snapshot.data[1][index - 1].sublist(0,
                                        pageSettingState.searchPageTopListLimit)
                                    : snapshot.data[1][index - 1],
                              );
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: Dim.screenUtilOnHorizontal(Dim.margin20),
                            );
                          },
                          itemCount: loadedTopList.length + 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // bottomNavigationBar: SafeArea(
            //   child: Container(
            //     height: 50,
            //   ),
            // ),
          );
        } else {
          return const AppProgressIndicator();
        }
      },
    );
  }
}
