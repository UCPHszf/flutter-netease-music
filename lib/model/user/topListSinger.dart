class TopListSinger {
  final String _name;
  final int _id;
  final String? _picUrl;
  final List<dynamic> _alias;
  final bool _followed;

  TopListSinger._internal(
      this._name, this._id, this._picUrl, this._alias, this._followed);

  String get name => _name;

  int get id => _id;

  bool get followed => _followed;

  String? get picUrl => _picUrl;

  List<dynamic> get alias => _alias;

  factory TopListSinger.fromJson(Map<String, dynamic> json) {
    return TopListSinger._internal(
      json['name'] as String,
      json['id'] as int,
      json['picUrl'] as String?,
      json['alias'],
      json['followed'] as bool,
    );
  }
}
