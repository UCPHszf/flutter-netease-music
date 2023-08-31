class MusicStyle {
  final int? _tagId;
  final String? _tagName;
  final String? _enName;
  final int? _level;
  final String? _showText;
  final String? _picUrl;
  final String? _link;
  final List<dynamic>? _tabs;
  final String? _colorDeep;
  final String? _colorShallow;
  final List<dynamic>? _childrenTags;
  final String? _ratio;

  int? get tagId => _tagId;

  MusicStyle._internal(
      {int? tagId,
      String? ratio,
      String? tagName,
      String? enName,
      int? level,
      String? showText,
      String? picUrl,
      String? link,
      List<dynamic>? tabs,
      String? colorDeep,
      String? colorShallow,
      List<dynamic>? childrenTags})
      : _tagId = tagId,
        _tagName = tagName,
        _enName = enName,
        _level = level,
        _showText = showText,
        _picUrl = picUrl,
        _link = link,
        _tabs = tabs,
        _colorDeep = colorDeep,
        _colorShallow = colorShallow,
        _childrenTags = childrenTags,
        _ratio = ratio;

  factory MusicStyle.fromJson(Map<String, dynamic> json) {
    return MusicStyle._internal(
      tagId: json['tagId'],
      tagName: json['tagName'],
      enName: json['enName'],
      level: json['level'],
      showText: json['showText'],
      picUrl: json['picUrl'],
      link: json['link'],
      tabs: json['tabs'],
      colorDeep: json['colorDeep'],
      colorShallow: json['colorShallow'],
      childrenTags: json['childrenTags'],
      ratio: null,
    );
  }

  factory MusicStyle.fromStylePreference(Map<String, dynamic> json) {
    return MusicStyle._internal(
      tagId: json['tagId'],
      tagName: json['tagName'],
      enName: null,
      level: null,
      showText: null,
      picUrl: json['picUrl'],
      link: null,
      tabs: null,
      colorDeep: null,
      colorShallow: null,
      childrenTags: null,
      ratio: json['ratio'],
    );
  }

  static List<MusicStyle> parseChildrenTags(MusicStyle style) {
    List<MusicStyle> childrenTags = [];
    if (style.childrenTags != null) {
      for (var child in style.childrenTags!) {
        childrenTags.add(MusicStyle.fromJson(child));
      }
    }
    return childrenTags;
  }

  String? get tagName => _tagName;

  List<dynamic>? get childrenTags => _childrenTags;

  String? get colorShallow => _colorShallow;

  String? get colorDeep => _colorDeep;

  List<dynamic>? get tabs => _tabs;

  String? get link => _link;

  String? get picUrl => _picUrl;

  String? get showText => _showText;

  int? get level => _level;

  String? get enName => _enName;

  String? get ratio => _ratio;

  @override
  String toString() {
    return 'MusicStyle{_tagId: $_tagId, _tagName: $_tagName, _enName: $_enName, _level: $_level, _showText: $_showText, _picUrl: $_picUrl, _link: $_link, _tabs: $_tabs, _colorDeep: $_colorDeep, _colorShallow: $_colorShallow, _childrenTags: $_childrenTags, _ratio: $_ratio}';
  }
}
