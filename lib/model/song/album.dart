class Album {
  final String _name;
  final int _id;
  final String? _picUrl;
  final bool? _onSale;


  Album._internal({
    required String name,
    required int id,
    String? picUrl,
    bool? onSale,
  })  : _name = name,
        _id = id,
        _picUrl = picUrl,
        _onSale = onSale;

  String get name => _name;

  int get id => _id;

  String? get picUrl => _picUrl;

  bool? get onSale => _onSale;

  factory Album.fromBrief(Map<String, dynamic> json) {
    return Album._internal(
      name: json['name'],
      id: json['id'],
      picUrl: json['picUrl'],
    );
  }
}
