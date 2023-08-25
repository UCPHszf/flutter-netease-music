import 'package:flutter/material.dart';

class SearchBarState extends ChangeNotifier {
  String _searchText = "";
  bool _autoUpdate = true;

  String get searchText => _searchText;

  bool get autoUpdate => _autoUpdate;

  set autoUpdate(bool value) {
    _autoUpdate = value;
    notifyListeners();
  }

  set searchText(String text) {
    _searchText = text;
    notifyListeners();
  }
}
