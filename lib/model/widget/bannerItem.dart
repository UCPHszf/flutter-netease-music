class BannerItem {
  final String _pic;
  final String _titleColor;
  final String _typeTitle;

  BannerItem._internal({
    required String pic,
    required String titleColor,
    required String typeTitle,
  })  : _pic = pic,
        _titleColor = titleColor,
        _typeTitle = typeTitle;

  String get pic => _pic;

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem._internal(
      pic: json['pic'],
      titleColor: json['titleColor'],
      typeTitle: json['typeTitle'],
    );
  }

  String get titleColor => _titleColor;

  String get typeTitle => _typeTitle;
}
