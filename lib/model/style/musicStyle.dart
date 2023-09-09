import 'package:cloud_music/model/style/styleTemplateTextContent.dart';

class MusicStyle {
  final int _tagId;
  final String? _tagName;
  final String? _name;
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
    String? tagName,
    String? name,
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
        _name = name,
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

  static T? _getJsonValue<T>(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      return json[key];
    }
    return null;
  }

  static T? _parseJsonObjectInJson<T>(Map<String, dynamic> json, String key,
      T Function(Map<String, dynamic>) parser) {
    if (json.containsKey(key) && json[key] != null) {
      return parser(json[key]);
    }
    return null;
  }

  factory MusicStyle.fromJson(Map<String, dynamic> json) {
    return MusicStyle._internal(
      tagId: json['tagId'],
      name: _getJsonValue(json, 'name'),
      tagName: _getJsonValue(json, 'tagName'),
      enName: _getJsonValue(json, 'enName'),
      level: _getJsonValue(json, 'level'),
      showText: _getJsonValue(json, 'showText'),
      picUrl: _getJsonValue(json, 'picUrl'),
      link: _getJsonValue(json, 'link'),
      tabs: _getJsonValue(json, 'tabs'),
      colorDeep: _getJsonValue(json, 'colorDeep'),
      colorShallow: _getJsonValue(json, 'colorShallow'),
      childrenTags: _getJsonValue(json, 'childrenTags'),
      ratio: _getJsonValue(json, 'ratio'),
      songNum: _getJsonValue(json, 'songNum'),
      artistNum: _getJsonValue(json, 'artistNum'),
      professionalReviews: _parseJsonObjectInJson<StyleTemplateTextContent>(
        json,
        'professionalReviews',
        (Map<String, dynamic> jsonObject) {
          return StyleTemplateTextContent.fromJson(jsonObject);
        },
      ),
      tagPortrait: _parseJsonObjectInJson<StyleTemplateTextContent>(
        json,
        'tagPortrait',
        (Map<String, dynamic> jsonObject) {
          return StyleTemplateTextContent.fromJson(jsonObject);
        },
      ),
      cover: _getJsonValue(json, 'cover'),
      desc: _getJsonValue(json, 'desc'),
      parentNames: _getJsonValue(json, 'parentNames'),
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

  int get tagId => _tagId;

  StyleTemplateTextContent? get tagPortrait => _tagPortrait;

  StyleTemplateTextContent? get professionalReviews => _professionalReviews;

  String? get artistNum => _artistNum;

  String? get songNum => _songNum;

  List<dynamic>? get cover => _cover;

  String? get desc => _desc;

  String? get parentNames => _parentNames;

  String? get name => _name;
}
