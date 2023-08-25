import 'package:flutter/cupertino.dart';

class AppState extends ChangeNotifier{
  bool _isBusy = false;

  bool get isbusy => _isBusy;

  set isBusy(bool value) {
    if (value != _isBusy) {
      _isBusy = value;
    }
  }
}
