class Artist {
  final int _id;
  final String _name;
  final bool? _followed;
  final String? _picUrl;
  final List<String> _alias;

  Artist._internal(this._id, this._name, this._followed, this._picUrl, this._alias);


  int get id => _id;

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist._internal(
      json['id'],
      json['name'],
      json['followed'],
      json['picUrl'],
      json['alias']
    );
  }

  String get name => _name;

  bool? get followed => _followed;

  String? get picUrl => _picUrl;

  List<String> get alias => _alias;


}
