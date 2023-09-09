import 'package:cloud_music/model/song/cursorInfo.dart';
import 'package:cloud_music/model/style/musicStyle.dart';
import 'package:cloud_music/model/user/artist.dart';
import 'package:cloud_music/resource/appIcon.dart';
import 'package:cloud_music/resource/color.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:cloud_music/util/dependencies.dart';
import 'package:cloud_music/widget/clipper/styleDetailCoverClipper.dart';
import 'package:cloud_music/widget/listItem/listDataSort.dart';
import 'package:cloud_music/widget/listItem/styleAlbumItem.dart';
import 'package:cloud_music/widget/listItem/styleArtistItem.dart';
import 'package:cloud_music/widget/listItem/stylePlayListItem.dart';
import 'package:cloud_music/widget/listItem/styleSongItem.dart';
import 'package:cloud_music/widget/progressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../model/song/album.dart';
import '../../model/song/playlist.dart';
import '../../model/song/song.dart';

class StyleDetail extends StatefulWidget {
  const StyleDetail({Key? key, required this.styleId}) : super(key: key);

  final int styleId;

  @override
  State<StatefulWidget> createState() {
    return _StyleDetailState();
  }
}

class _StyleDetailState extends State<StyleDetail>
    with AutomaticKeepAliveClientMixin<StyleDetail> {
  @override
  bool get wantKeepAlive => true;

  // 曲风详情网络请求
  late final Future future;

  final Logger _logger = getIt<Logger>();

  late final ScrollController _scrollController;

  // appbar height
  double _appbarHeight = 240;

  // appbar collapsed height
  final double _appBarCollapsedHeight = 65;

  // 顶部图片使用clip裁剪高度
  double _cutHeight = 20;

  final int dataTopBarHeight = 22;
  final double dataTopBarWidgetMargin = 3.5;

  bool _appbarCollapsed = false;
  bool songDataLoading = true;
  bool albumDataLoading = true;
  bool playlistDataLoading = true;
  bool artistDataLoading = true;

  final List<String> styleDataType = ["歌曲", "专辑", "歌单", "艺人"];
  int songSortType = Constants.sortByHot;
  int albumSortType = Constants.sortByHot;

  final List<Song> styleSongs = [];
  final List<Album> styleAlbums = [];
  final List<PlayList> stylePlaylists = [];
  final List<ArtistProfile> styleArtists = [];

  List<CursorInfo?> styleCursorInfo = List.filled(4, null);

  final double customScrollViewHorizontalPadding =
      Dim.screenUtilOnHorizontal(Dim.styleDetailListPadding);
  final double customScrollViewVerticalPadding =
      Dim.screenUtilOnVertical(Dim.padding10);

  void loadSongData() {
    setState(() {
      songDataLoading = true;
    });
    NetworkRequest.styleSong(tagId: widget.styleId, sortType: songSortType)
        .then((value) {
      // cursor info of song
      CursorInfo cursorInfo = value.$1;
      // song list
      List<Song> songs = value.$2;
      setState(() {
        styleSongs.addAll(songs);
      });
      setState(() {
        styleCursorInfo[0] = cursorInfo;
      });
      setState(() {
        songDataLoading = false;
      });
    });
  }

  void loadAlbumData() {
    setState(() {
      albumDataLoading = true;
    });
    NetworkRequest.styleAlbum(tagId: widget.styleId, sortType: albumSortType)
        .then((value) {
      // cursor info of album
      CursorInfo cursorInfo = value.$1;
      // album list
      List<Album> albums = value.$2;
      setState(() {
        styleAlbums.addAll(albums);
      });
      setState(() {
        styleCursorInfo[1] = cursorInfo;
      });
      setState(() {
        albumDataLoading = false;
      });
    });
  }

  void loadPlayListData() {
    setState(() {
      playlistDataLoading = true;
    });
    NetworkRequest.stylePlaylist(tagId: widget.styleId).then((value) {
      // cursor info of album
      CursorInfo cursorInfo = value.$1;
      // album list
      List<PlayList> playLists = value.$2;
      setState(() {
        stylePlaylists.addAll(playLists);
      });
      setState(() {
        styleCursorInfo[2] = cursorInfo;
      });
      setState(() {
        playlistDataLoading = false;
      });
    });
  }

  void loadArtistData() {
    setState(() {
      artistDataLoading = true;
    });
    NetworkRequest.styleArtist(tagId: widget.styleId).then((value) {
      // cursor info of album
      CursorInfo cursorInfo = value.$1;
      // album list
      List<ArtistProfile> artists = value.$2;
      setState(() {
        styleArtists.addAll(artists);
      });
      setState(() {
        styleCursorInfo[3] = cursorInfo;
      });
      setState(() {
        artistDataLoading = false;
      });
    });
  }

  @override
  void initState() {
    future = NetworkRequest.styleDetail(widget.styleId);
    _scrollController = ScrollController()
      ..addListener(() {
        // from offset 220-240 cutheight from 20-0
        // clip height
        if (_scrollController.offset < Dim.screenUtilOnVertical(100)) {
          setState(() {
            _cutHeight = 20;
          });
        } else if (_scrollController.offset > Dim.screenUtilOnVertical(140)) {
          setState(() {
            _cutHeight = 0;
          });
        } else {
          setState(() {
            _cutHeight = 20 - (_scrollController.offset - 100) / 2;
          });
        }

        // appbar fixed
        if (_scrollController.offset >=
            _appbarHeight - _appBarCollapsedHeight) {
          setState(() {
            _appbarCollapsed = true;
          });
        } else {
          setState(() {
            _appbarCollapsed = false;
          });
        }
      });
    // song as the default tab
    loadSongData();
    loadAlbumData();
    loadPlayListData();
    loadArtistData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildBottomPlayedButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: Dim.screenUtilOnVertical(50),
        width: Dim.screenUtilOnHorizontal(140),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                AppIcon.playCircleFilled,
                color: Colors.red,
              ),
              SizedBox(
                width: Dim.screenUtilOnHorizontal(5),
              ),
              Text(
                Constants.styleListen,
                style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Dim.screenUtilOnSp(Dim.fontSize20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 曲风-歌曲
  List<Widget> styleSong() {
    Widget marginWidget = SizedBox(
      width: Dim.screenUtilOnHorizontal(dataTopBarWidgetMargin),
    );
    return [
      SliverPadding(
        padding: EdgeInsets.symmetric(
          horizontal: customScrollViewHorizontalPadding,
          vertical: customScrollViewVerticalPadding,
        ),
        sliver: SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  //todo: play all
                },
                child: SizedBox(
                  height: Dim.screenUtilOnVertical(dataTopBarHeight),
                  child: Row(
                    children: [
                      const Icon(
                        AppIcon.playCircleFilled,
                        color: AppColor.red,
                      ),
                      marginWidget,
                      Text(
                        Constants.playAll,
                        style: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dim.screenUtilOnSp(Dim.fontSize18),
                        ),
                      ),
                      marginWidget,
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          styleCursorInfo[0] == null
                              ? ""
                              : "(${styleCursorInfo[0]?.total})",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.grey,
                            fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 排序方式
              ListDataSort(
                sortVariable: songSortType,
                onSelectSortByHot: () {
                  setState(() {
                    songSortType = Constants.sortByHot;
                    styleSongs.clear();
                    loadSongData();
                  });
                },
                onSelectSortByTime: () {
                  setState(() {
                    songSortType = Constants.sortByTime;
                    styleSongs.clear();
                    loadSongData();
                  });
                },
              ),
            ],
          ),
        ),
      ),
      !songDataLoading
          ? SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return StyleSongItem(
                  song: styleSongs[index],
                );
              },
              itemCount: styleSongs.length,
            )
          : const SliverFillRemaining(
              child: AppProgressIndicator(),
            ),
    ];
  }

  List<Widget> styleAlbum() {
    return [
      SliverPadding(
        padding: EdgeInsets.symmetric(
          horizontal: customScrollViewHorizontalPadding,
          vertical: customScrollViewVerticalPadding,
        ),
        sliver: SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "按${albumSortType == Constants.sortByHot ? "最热" : "最新"}排序",
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: Dim.screenUtilOnSp(Dim.fontSize15),
                ),
              ),
              ListDataSort(
                sortVariable: albumSortType,
                onSelectSortByHot: () {
                  setState(() {
                    albumSortType = Constants.sortByHot;
                    styleAlbums.clear();
                    loadAlbumData();
                  });
                },
                onSelectSortByTime: () {
                  setState(() {
                    albumSortType = Constants.sortByTime;
                    styleAlbums.clear();
                    loadAlbumData();
                  });
                },
              ),
            ],
          ),
        ),
      ),
      !albumDataLoading
          ? SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return StyleAlbumItem(
                  album: styleAlbums[index],
                );
              },
              itemCount: styleAlbums.length,
            )
          : const SliverFillRemaining(
              child: AppProgressIndicator(),
            ),
    ];
  }

  List<Widget> stylePlayList() {
    return [
      playlistDataLoading
          ? const SliverFillRemaining(
              child: AppProgressIndicator(),
            )
          : SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return StylePlayListItem(
                  playList: stylePlaylists[index],
                );
              },
              itemCount: stylePlaylists.length,
            ),
    ];
  }

  List<Widget> styleArtist() {
    return [
      artistDataLoading
          ? const SliverFillRemaining(
              child: AppProgressIndicator(),
            )
          : SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return StyleArtistItem(artistProfile: styleArtists[index]);
              },
              itemCount: styleArtists.length,
            ),
    ];
  }

  //曲风列表通用
  Widget styleList(List<Widget> widget) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          MusicStyle style = snapshot.data as MusicStyle;
          return Scaffold(
            body: DefaultTabController(
              length: 4,
              child: NestedScrollView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverStack(
                      children: [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _StyleAppBarDelegate(
                            min: 2 * _appBarCollapsedHeight + 40,
                            max: 340,
                            widget: Container(
                              color: Colors.white,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: TabBar(
                                  unselectedLabelStyle: TextStyle(
                                    fontSize:
                                        Dim.screenUtilOnSp(Dim.fontSize15),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize:
                                        Dim.screenUtilOnSp(Dim.fontSize15),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelColor: AppColor.black,
                                  unselectedLabelColor: AppColor.black,
                                  indicatorColor: AppColor.red,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicatorWeight: 2,
                                  tabs: styleDataType
                                      .map(
                                        (e) => GestureDetector(
                                          child: Tab(
                                            text: e,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverAppBar(
                          leading: const BackButton(
                            color: AppColor.white,
                          ),
                          stretch: true,
                          expandedHeight: _appbarHeight,
                          collapsedHeight: _appBarCollapsedHeight,
                          pinned: true,
                          flexibleSpace: !_appbarCollapsed
                              ? FlexibleSpaceBar(
                                  collapseMode: CollapseMode.pin,
                                  stretchModes: const [],
                                  background: ClipPath(
                                    clipper: StyleDetailCoverClipper(
                                      cutHeight: _cutHeight,
                                    ),
                                    child: Container(
                                      height: _appbarHeight,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(style.cover![0]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 2 * _appBarCollapsedHeight,
                                  color: Colors.pink,
                                ),
                        ),
                      ],
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    styleList(styleSong()),
                    styleList(styleAlbum()),
                    styleList(stylePlayList()),
                    styleList(styleArtist()),
                  ],
                ),
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

class _StyleAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double max;
  final double min;

  _StyleAppBarDelegate({required this.widget, this.max = 100, this.min = 50});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
