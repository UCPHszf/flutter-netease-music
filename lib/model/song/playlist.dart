class PlayList {
  final int _id;
  final String _name;
  final String? _cover;
  final int _songCount;
  final String _userName;
  final int _userId;
  final int _playCount;

  PlayList._internal(
      {required int id,
      required String name,
      String? cover,
      required int songCount,
      required String userName,
      required int userId,
      required int playCount})
      : _id = id,
        _name = name,
        _cover = cover,
        _songCount = songCount,
        _userName = userName,
        _userId = userId,
        _playCount = playCount;

  int get id => _id;

  String get name => _name;

  int get playCount => _playCount;

  int get userId => _userId;

  String get userName => _userName;

  int get songCount => _songCount;

  String? get cover => _cover;

  int showedPlayCount() {
    if (playCount > 100000) {
      return playCount ~/ 10000;
    } else {
      return playCount;
    }
  }

  static T? _getJsonValue<T>(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      return json[key];
    }
    return null;
  }

  factory PlayList.fromJson(Map<String, dynamic> json) {
    return PlayList._internal(
      id: _getJsonValue(json, 'id'),
      name: _getJsonValue(json, 'name'),
      cover: _getJsonValue(json, 'coverImgUrl'),
      songCount: _getJsonValue(json, 'trackCount'),
      userName: _getJsonValue(json, "userName"),
      userId: _getJsonValue(json, 'userId'),
      playCount: _getJsonValue(json, 'playCount'),
    );
  }
}
