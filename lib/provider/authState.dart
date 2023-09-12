import 'package:cloud_music/model/user/user.dart';
import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  set userProfile(UserProfile? value) {
    _userProfile = value;
    notifyListeners();
  }
}
