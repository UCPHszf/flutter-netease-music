class TopListSong {
  final String _text;
  final String? _iconUrl;

  TopListSong._internal(this._text, this._iconUrl);

  String get text => _text;

  String? get iconUrl => _iconUrl;

  factory TopListSong.fromHotSearch(Map<String, dynamic> json) {
    return TopListSong._internal(
      json['searchWord'] as String,
      json['iconUrl'] as String?,
    );
  }

  factory TopListSong.fromSongList(Map<String, dynamic> json) {
    return TopListSong._internal(json['name'] as String, null);
  }
}
