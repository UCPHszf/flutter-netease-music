import 'package:cloud_music/model/user/artist.dart';

class Album {
  final String _name;
  final int _id;
  final String? _picUrl;
  final bool? _onSale;
  final int? _publishTime;
  ArtistProfile? _artist;

  Album._internal({
    required String name,
    required int id,
    String? picUrl,
    bool? onSale,
    int? publishTime,
    ArtistProfile? artist,
  })  : _name = name,
        _id = id,
        _picUrl = picUrl,
        _onSale = onSale,
        _publishTime = publishTime,
        _artist = artist;

  String get name => _name;

  int get id => _id;

  String? get picUrl => _picUrl;

  bool? get onSale => _onSale;

  int? get publishTime => _publishTime;

  ArtistProfile? get artist => _artist;

  String getDateOfPublish() {
    if (_publishTime == null) {
      return "";
    }
    DateTime date = DateTime.fromMillisecondsSinceEpoch(_publishTime!);
    return "${date.year}-${date.month}-${date.day}";
  }

  static T? _getJsonValue<T>(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      return json[key];
    }
    return null;
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album._internal(
      name: _getJsonValue(json, 'name'),
      id: _getJsonValue(json, 'id'),
      picUrl: _getJsonValue(json, 'picUrl'),
      onSale: _getJsonValue(json, 'onSale'),
      publishTime: _getJsonValue(json, 'publishTime'),
      artist: json.containsKey('artist')
          ? ArtistProfile.fromJson(json['artist'])
          : null,
    );
  }

}
