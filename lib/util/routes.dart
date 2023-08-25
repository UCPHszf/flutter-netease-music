import 'package:cloud_music/model/pageArgs.dart';
import 'package:cloud_music/page/home.dart';
import 'package:cloud_music/page/search.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/resource/enum.dart';
import 'package:cloud_music/widget/customRoute.dart';
import 'package:flutter/material.dart';
import '../page/signIn.dart';

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
