import 'package:cloud_music/provider/authState.dart';
import 'package:cloud_music/resource/appIcon.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/widget/drawerListTileData.dart';
import '../../util/dependencies.dart';
import 'drawerItem.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeDrawerState();
  }
}

class _HomeDrawerState extends State<HomeDrawer> {
  late AuthState authState;
  late List<DrawerListTileData> firstItemBlock;
  late List<DrawerListTileData> secondItemBlock;
  late List<DrawerListTileData> thirdItemBlock;
  Logger _logger = getIt<Logger>();

  @override
  void initState() {
    authState = Provider.of<AuthState>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    firstItemBlock = [
      DrawerListTileData(
        titleText: AppLocalizations.of(context).messageCenter,
        leadingIcon: AppIcon.msg,
        trailingWidget: Icon(
          Icons.adaptive.arrow_forward,
          color: Colors.grey,
          size: Dim.screenUtilOnSp(Dim.drawerIconSize),
        ),
        onTap: () {
          //todo 跳转到消息中心
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dim.drawerItemBorderRadius),
            topRight: Radius.circular(Dim.drawerItemBorderRadius),
          ),
        ),
      ),
      DrawerListTileData(
        titleText: AppLocalizations.of(context).cloudShellCenter,
        leadingIcon: AppIcon.cloudShellCenter,
        onTap: () {
          //todo 跳转到云贝中心
        },
        trailingWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context).checkIn,
              style: TextStyle(
                fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
                color: Colors.grey,
              ),
            ),
            trailingDivider(
              Dim.screenUtilOnHorizontal(Dim.margin10),
            ),
            Icon(
              Icons.adaptive.arrow_forward,
              color: Colors.grey,
              size: Dim.screenUtilOnSp(Dim.drawerIconSize),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dim.drawerItemBorderRadius),
            bottomRight: Radius.circular(Dim.drawerItemBorderRadius),
          ),
        ),
      ),
    ];

    secondItemBlock = [
      // 设置
      DrawerListTileData(
        titleText: AppLocalizations.of(context).settings,
        leadingIcon: AppIcon.setting,
        onTap: () {
          //todo 跳转到设置页面
        },
        trailingWidget: Icon(
          Icons.adaptive.arrow_forward,
          color: Colors.grey,
          size: Dim.screenUtilOnSp(Dim.drawerIconSize),
        ),
      ),
      // 夜间模式
      DrawerListTileData(
        titleText: AppLocalizations.of(context).darkMode,
        leadingIcon: AppIcon.nightMode,
        trailingWidget: Switch(
          value: false,
          onChanged: (value) {
            //todo 切换夜间模式
          },
        ),
      ),
      // 定时关闭
      DrawerListTileData(
        titleText: AppLocalizations.of(context).timedShutdown,
        leadingIcon: AppIcon.timedShutDown,
        onTap: () {
          //todo 跳转到定时关闭页面
        },
        trailingWidget: Icon(
          Icons.adaptive.arrow_forward,
          color: Colors.grey,
          size: Dim.screenUtilOnSp(Dim.drawerIconSize),
        ),
      ),
      // 边听边存
      DrawerListTileData(
        titleText: AppLocalizations.of(context).saveMusicWhileListening,
        leadingIcon: AppIcon.saveMusicWhileListening,
        onTap: () {
          //todo 跳转到设置边听边存页面
        },
        trailingWidget: Icon(
          Icons.adaptive.arrow_forward,
          color: Colors.grey,
          size: Dim.screenUtilOnSp(Dim.drawerIconSize),
        ),
      ),
      // 音乐黑名单
      DrawerListTileData(
        titleText: AppLocalizations.of(context).musicBlacklist,
        leadingIcon: AppIcon.musicBlackList,
        onTap: () {
          //todo 跳转到音乐黑名单页面
        },
        trailingWidget: Icon(
          Icons.adaptive.arrow_forward,
          color: Colors.grey,
          size: Dim.screenUtilOnSp(Dim.drawerIconSize),
        ),
      ),
      // 青少年模式
      DrawerListTileData(
        titleText: AppLocalizations.of(context).adolescentMode,
        leadingIcon: AppIcon.adolescentMode,
        onTap: () {
          //todo 跳转到青少年模式页面
        },
        trailingWidget: Icon(
          Icons.adaptive.arrow_forward,
          color: Colors.grey,
          size: Dim.screenUtilOnSp(Dim.drawerIconSize),
        ),
      ),
      // 音乐闹钟
      DrawerListTileData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dim.drawerItemBorderRadius),
            bottomRight: Radius.circular(Dim.drawerItemBorderRadius),
          ),
        ),
        titleText: AppLocalizations.of(context).musicAlarm,
        leadingIcon: AppIcon.musicAlarm,
        onTap: () {
          //todo 跳转到音乐闹钟页面
        },
        trailingWidget: Icon(
          Icons.adaptive.arrow_forward,
          color: Colors.grey,
          size: Dim.screenUtilOnSp(Dim.drawerIconSize),
        ),
      ),
    ];
  }

  final double itemBlockDividerHeight = 20;

  Widget sliverDivider(double height) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: Dim.screenUtilOnVertical(height),
      ),
    );
  }

  Widget trailingDivider(double width) {
    return SizedBox(
      width: Dim.screenUtilOnHorizontal(width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade50,
      child: Padding(
        padding: EdgeInsets.only(
          left: Dim.screenUtilOnHorizontal(Dim.padding15),
          right: Dim.screenUtilOnHorizontal(Dim.padding15),
          top: Dim.screenUtilOnVertical(Dim.padding10),
          bottom: Dim.screenUtilOnVertical(Dim.padding20),
        ),
        child: CustomScrollView(
          slivers: [
            // top: user info
            SliverSafeArea(
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                        SizedBox(
                          width: Dim.screenUtilOnHorizontal(Dim.padding10),
                        ),
                        Text(authState.userProfile?.nickname ?? "未登录"),
                      ],
                    ),
                    SvgPicture.asset(
                      "assets/icons/qrcode_scan.svg",
                      width: Dim.screenUtilOnHorizontal(25),
                      height: Dim.screenUtilOnHorizontal(25),
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList.separated(
              itemBuilder: (BuildContext context, int index) {
                return DrawerItem(
                  data: firstItemBlock[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Divider(
                    indent: Dim.screenUtilOnHorizontal(Dim.padding10),
                  ),
                );
              },
              itemCount: firstItemBlock.length,
            ),
            sliverDivider(itemBlockDividerHeight),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dim.screenUtilOnHorizontal(
                      Dim.drawerItemHorizontalPadding),
                ),
                height: Dim.screenUtilOnVertical(40),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dim.drawerItemBorderRadius),
                    topRight: Radius.circular(Dim.drawerItemBorderRadius),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context).others,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: Dim.screenUtilOnSp(Dim.fontSize12),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            sliverDivider(1),
            SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return DrawerItem(
                  data: secondItemBlock[index],
                );
              },
              itemCount: secondItemBlock.length,
            ),
          ],
        ),
      ),
    );
  }
}
