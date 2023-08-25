class TopListItem {
  final String _text;
  final String? _iconUrl;

  TopListItem._internal(this._text, this._iconUrl);

  String get text => _text;

  String? get iconUrl => _iconUrl;

  factory TopListItem.fromHotSearch(Map<String, dynamic> json) {
    return TopListItem._internal(
      json['searchWord'] as String,
      json['iconUrl'] as String?,
    );
  }

  factory TopListItem.fromSongList(Map<String, dynamic> json) {
    return TopListItem._internal(json['name'] as String, null);
  }
}
