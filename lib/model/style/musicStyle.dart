import 'package:cloud_music/model/style/styleTemplateTextContent.dart';

class MusicStyle {
  final int _tagId;
  final String _tagName;
  final String? _enName;
  final int? _level;
  final String? _showText;
  final String? _picUrl;
  final String? _link;
  final List<dynamic>? _tabs;
  final String? _colorDeep;
  final String? _colorShallow;
  final List<dynamic>? _childrenTags;

  // for style preference
  final String? _ratio;

  // for style detail
  final String? _songNum;
  final String? _artistNum;
  final StyleTemplateTextContent? _professionalReviews;
  final StyleTemplateTextContent? _tagPortrait;
  final List<dynamic>? _cover;
  final String? _desc;
  final String? _parentNames;

  MusicStyle._internal({
    required int tagId,
    String? ratio,
    required String tagName,
    String? enName,
    int? level,
    String? showText,
    String? picUrl,
    String? link,
    List<dynamic>? tabs,
    String? colorDeep,
    String? colorShallow,
    List<dynamic>? childrenTags,
    String? songNum,
    String? artistNum,
    StyleTemplateTextContent? professionalReviews,
    StyleTemplateTextContent? tagPortrait,
    List<dynamic>? cover,
    String? desc,
    String? parentNames,
  })  : _tagId = tagId,
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
        _ratio = ratio,
        _songNum = songNum,
        _artistNum = artistNum,
        _professionalReviews = professionalReviews,
        _tagPortrait = tagPortrait,
        _cover = cover,
        _desc = desc,
        _parentNames = parentNames;

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
    );
  }

  factory MusicStyle.fromStylePreference(Map<String, dynamic> json) {
    return MusicStyle._internal(
      tagId: json['tagId'],
      tagName: json['tagName'],
      picUrl: json['picUrl'],
      ratio: json['ratio'],
    );
  }

  factory MusicStyle.fromStyleDetail(Map<String, dynamic> json) {
    return MusicStyle._internal(
      tagId: json['tagId'],
      enName: json['enName'],
      tagName: json['name'],
      songNum: json['songNum'],
      artistNum: json['artistNum'],
      professionalReviews: json['professionalReviews'] != null
          ? StyleTemplateTextContent.fromJson(json['professionalReviews'])
          : null,
      tagPortrait: json['tagPortrait'] != null
          ? StyleTemplateTextContent.fromJson(json['tagPortrait'])
          : null,
      cover: json['cover'],
      colorDeep: json['colorDeep'],
      colorShallow: json['colorShallow'],
      desc: json['desc'],
      parentNames: json['parentNames'],
      level: json['level'],
      tabs: json['tabs'],
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

  String get tagName => _tagName;

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

  int get tagId => _tagId;

  StyleTemplateTextContent? get tagPortrait => _tagPortrait;

  StyleTemplateTextContent? get professionalReviews => _professionalReviews;

  String? get artistNum => _artistNum;

  String? get songNum => _songNum;

  List<dynamic>? get cover => _cover;

  String? get desc => _desc;

  String? get parentNames => _parentNames;
}
