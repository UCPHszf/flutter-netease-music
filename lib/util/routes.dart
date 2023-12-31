import 'package:cloud_music/model/pageArgs.dart';
import 'package:cloud_music/page/home.dart';
import 'package:cloud_music/page/search.dart';
import 'package:cloud_music/page/singerCategory.dart';
import 'package:cloud_music/page/style/styleCategory.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/resource/enum.dart';
import 'package:cloud_music/widget/customRoute.dart';
import 'package:flutter/material.dart';
import '../page/signIn.dart';
import '../page/style/styleDetail.dart';

class Routes {
  static dynamic route() {
    return {
      Constants.signInPageRoute: (BuildContext context) => const SignInPage(),
    };
  }

  static dynamic onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.homePageRoute:
        return CustomRoute<bool>(
            builder: (BuildContext context) => const HomePage(),
            transitionType: TransitionType.slide);
      case Constants.searchPageRoute:
        return CustomRoute<bool>(
            builder: (BuildContext context) => const SearchPage(),
            transitionType: TransitionType.slide);
      case Constants.singerCategoryPageRoute:
        return CustomRoute<bool>(
            builder: (BuildContext context) => const SingerCategory(),
            transitionType: TransitionType.slide);
      case Constants.styleCategoryPageRoute:
        return CustomRoute<bool>(
            builder: (BuildContext context) => const StyleCategory(),
            transitionType: TransitionType.slide);
      case Constants.styleDetailPageRoute:
        final arguments = settings.arguments as PageArgument;
        int styleId = arguments.args[Constants.pageArgumentStyleId];
        return CustomRoute<bool>(
            builder: (BuildContext context) => StyleDetail(styleId: styleId),
            transitionType: TransitionType.slide);
      default:
        return onUnknownRoute(settings);
    }
  }

  static dynamic onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: const Text(Constants.unKnownPageTitle),
          ),
          body: Center(
            child: Text(Constants.unKnownPageText(settings.name!)),
          )),
    );
  }
}
