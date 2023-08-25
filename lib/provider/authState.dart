import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  late bool _isLogin;

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }
}