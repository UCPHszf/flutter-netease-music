import 'package:cloud_music/model/user/artist.dart';

class Album {
  final String _name;
  final int _id;
  final String? _picUrl;
  final bool? _onSale;
  final int? _publishTime;
  Artist? _artist;

  Album._internal({
    required String name,
    required int id,
    String? picUrl,
    bool? onSale,
    int? publishTime,
    Artist? artist,
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

  Artist? get artist => _artist;

  String getDateOfPublish() {
    if (_publishTime == null) {
      return "";
    }
    DateTime date = DateTime.fromMillisecondsSinceEpoch(_publishTime!);
    return "${date.year}-${date.month}-${date.day}";
  }

  factory Album.fromSongAlbum(Map<String, dynamic> json) {
    return Album._internal(
      name: json['name'],
      id: json['id'],
      picUrl: json['picUrl'],
    );
  }

  factory Album.fromAlbumBrief(Map<String, dynamic> json) {
    return Album._internal(
      name: json['name'],
      id: json['id'],
      picUrl: json['picUrl'],
      publishTime: json['publishTime'],
      artist: Artist.fromBrief(json['artist']),
    );
  }
}
