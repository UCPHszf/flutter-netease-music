import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_music/provider/pageSettingState.dart';
import 'package:cloud_music/provider/searchBarState.dart';
import 'package:cloud_music/resource/appIcon.dart';
import 'package:cloud_music/resource/color.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:cloud_music/widget/drawer/homeDrawer.dart';
import 'package:cloud_music/widget/search/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/widget/bannerItem.dart';
import '../resource/constants.dart';
import '../util/dependencies.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerItem> _bannerList = [];

  @override
  void initState() {
    super.initState();
    Logger logger = getIt<Logger>();
    NetworkRequest.getBannerData().then(
      (value) => {
        if (mounted)
          {
            setState(
              () {
                _bannerList = value;
              },
            )
          },
      },
    );
    PageSettingState pageSettingState =
        Provider.of<PageSettingState>(context, listen: false);
    NetworkRequest.pageSetting().then(
      (value) {
        List<String> topList = List<String>.from(
          value[Constants.searchPageTopListField].map(
            (e) {
              return e.toString();
            },
          ),
        );
        if (context.mounted) {
          pageSettingState.searchPageTopList = topList;
          pageSettingState.searchPageTopListLimit =
              value[Constants.topListLimitField];
        }
      },
    );

    NetworkRequest.allTopList().then(
      (value) {
        pageSettingState.allTopList = value;
      },
    );
  }

  final activeDotColor = Colors.white;
  final inactiveDotColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: CustomSearchBar(
          onTap: () {
            Provider.of<SearchBarState>(context, listen: false).autoUpdate =
                false;
            Navigator.pushNamed(context, Constants.searchPageRoute);
          },
          decorationColorGradientType: true,
          gradientStartColor: AppColor.homePageSearchBarGradientStart,
          gradientEndColor: AppColor.homePageSearchBarGradientEnd,
          rightIcon: AppIcon.qrCodeScanner,
        ),
        actions: [
          IconButton(
            icon: const Icon(AppIcon.songRecognition),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      drawer: HomeDrawer(
        drawerBlocks: [],
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: Dim.screenUtilOnHorizontal(Dim.padding15),
              vertical: Dim.screenUtilOnVertical(Dim.padding15),
            ),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: Dim.screenUtilOnVertical(Dim.bannerHeight),
                child: Swiper(
                  itemCount: _bannerList.length,
                  control: const SwiperControl(
                    color: Colors.transparent,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dim.borderRadius10),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Dim.borderRadius10),
                            child: Image.network(
                              _bannerList[index].pic,
                              fit: BoxFit.fill,
                              height:
                                  Dim.screenUtilOnVertical(Dim.bannerHeight),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom:
                              Dim.screenUtilOnVertical(Dim.bannerInnerPadding),
                          right: Dim.screenUtilOnHorizontal(
                              Dim.bannerInnerPadding),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dim.screenUtilOnHorizontal(
                                      Dim.bannerInnerPadding)),
                              color: Colors.white,
                            ),
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dim.screenUtilOnHorizontal(
                                    Dim.bannerInnerPadding),
                                vertical: Dim.screenUtilOnVertical(
                                    Dim.bannerInnerPadding),
                              ),
                              child: Text(
                                _bannerList[index].typeTitle,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dim.screenUtilOnSp(
                                        Dim.bannerTitleTypeFontSize)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  pagination: SwiperPagination(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(
                      bottom: Dim.screenUtilOnVertical(Dim.bannerInnerPadding),
                      left: Dim.screenUtilOnHorizontal(Dim.bannerInnerPadding),
                    ),
                    builder: DotSwiperPaginationBuilder(
                      color: inactiveDotColor,
                      activeColor: activeDotColor,
                      size: Dim.screenUtilOnSp(Dim.bannerDotSmall),
                      activeSize: Dim.screenUtilOnSp(Dim.bannerDotMedium),
                    ),
                  ),
                  autoplayDisableOnInteraction: false,
                  autoplayDelay: 3000,
                  autoplay: true,
                  loop: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
