import 'package:cloud_music/provider/appState.dart';
import 'package:cloud_music/resource/constants.dart';

class UpstreamPageSettingState extends AppState {
  List<String> _searchPageTopList = [];
  int _searchPageTopListLimit = Constants.defaultTopListLimit;

  List<String> get searchPageTopList => _searchPageTopList;
  Map<String, int> _allTopList = {};

  set searchPageTopList(List<String> value) {
    _searchPageTopList = value;
    notifyListeners();
  }

  int get searchPageTopListLimit => _searchPageTopListLimit;

  set searchPageTopListLimit(int value) {
    _searchPageTopListLimit = value;
    notifyListeners();
  }

  Map<String, int> get allTopList => _allTopList;

  set allTopList(Map<String, int> value) {
    _allTopList = value;
    notifyListeners();
  }
}
