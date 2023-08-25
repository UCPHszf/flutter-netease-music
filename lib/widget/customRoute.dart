import 'package:cloud_music/resource/enum.dart';
import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute(
      {required WidgetBuilder builder,
      RouteSettings? settings,
      required this.transitionType})
      : super(builder: builder, settings: settings);

  TransitionType transitionType;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    switch (transitionType) {
      case TransitionType.none:
        return child;
      case TransitionType.fade:
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
          child: child,
        );
      case TransitionType.slide:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
          child: child,
        );
      default:
        return child;
    }
  }
}
