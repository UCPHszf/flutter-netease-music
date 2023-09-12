import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingState extends ChangeNotifier {
  bool _isDarkMode = false;
  Locale? _locale;
  final SharedPreferences _prefs;

  SettingState(this._prefs) {
    _locale = Locale(_prefs.getString("selectedLocale") ?? "zh");
    _isDarkMode = _prefs.getBool("isDarkMode") ?? false;
  }

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    _prefs.setString("selectedLocale", locale.languageCode);
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    _prefs.setBool("isDarkMode", _isDarkMode);
    notifyListeners();
  }
}
