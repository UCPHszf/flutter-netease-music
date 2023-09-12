// artist detail
import 'package:cloud_music/model/user/user.dart';

class ExpertIdentify {
  final int _expertIdentityId;
  final String? _expertIdentityName;
  final int? _expertIdentityCount;

  int get expertIdentityId => _expertIdentityId;

  String? get expertIdentityName => _expertIdentityName;

  int? get expertIdentityCount => _expertIdentityCount;

  ExpertIdentify._internal(
      {required int expertIdentityId,
      String? expertIdentityName,
      int? expertIdentityCount})
      : _expertIdentityId = expertIdentityId,
        _expertIdentityName = expertIdentityName,
        _expertIdentityCount = expertIdentityCount;

  factory ExpertIdentify.fromJson(Map<String, dynamic> json) {
    return ExpertIdentify._internal(
      expertIdentityId: json['expertIdentityId'],
      expertIdentityName: json['expertIdentityName'],
      expertIdentityCount: json['expertIdentityCount'],
    );
  }
}

class Artist {
  final int? _videoCount;
  final UserIdentify? _identify;
  final ArtistProfile? _profile;
  final bool? _blacklist;
  final int? _preferShow;
  final bool? _showPriMsg;
  final List<ExpertIdentify>? _expertIdentifyTags;
  final int? _eventCount;
  final UserProfile? _userProfile;

  int? get videoCount => _videoCount;

  UserIdentify? get identify => _identify;

  ArtistProfile? get profile => _profile;

  bool? get blacklist => _blacklist;

  int? get preferShow => _preferShow;

  bool? get showPriMsg => _showPriMsg;

  List<ExpertIdentify>? get expertIdentifyTags => _expertIdentifyTags;

  int? get eventCount => _eventCount;

  UserProfile? get userProfile => _userProfile;

  Artist._internal(
      {int? videoCount,
      UserIdentify? identify,
      ArtistProfile? profile,
      bool? blacklist,
      int? preferShow,
      bool? showPriMsg,
      List<ExpertIdentify>? expertIdentifyTags,
      int? eventCount,
      UserProfile? userProfile})
      : _videoCount = videoCount,
        _identify = identify,
        _profile = profile,
        _blacklist = blacklist,
        _preferShow = preferShow,
        _showPriMsg = showPriMsg,
        _expertIdentifyTags = expertIdentifyTags,
        _eventCount = eventCount,
        _userProfile = userProfile;

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

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist._internal(
      videoCount: _getJsonValue(json, 'videoCount'),
      identify: _parseJsonObjectInJson(json, 'identify',
          (Map<String, dynamic> json) => UserIdentify.fromJson(json)),
      profile: _parseJsonObjectInJson(json, 'profile',
          (Map<String, dynamic> json) => ArtistProfile.fromJson(json)),
      blacklist: _getJsonValue(json, 'blacklist'),
      preferShow: _getJsonValue(json, 'preferShow'),
      showPriMsg: _getJsonValue(json, 'showPriMsg'),
      expertIdentifyTags: json.containsKey('expertIdentifyTags') &&
              json['expertIdentifyTags'] != null
          ? (json['expertIdentifyTags'] as List<dynamic>)
              .map((e) => ExpertIdentify.fromJson(e))
              .toList()
          : null,
      eventCount: _getJsonValue(json, 'eventCount'),
      userProfile: _parseJsonObjectInJson(json, 'userProfile',
          (Map<String, dynamic> json) => UserProfile.fromJson(json)),
    );
  }
}

class ArtistProfile {
  final int _id;
  final String? _cover;
  final String? _avatar;
  final String _name;
  final List<dynamic>? _transnames;
  final List<dynamic>? _alias;
  final List<dynamic>? _identifyTag;
  final List<dynamic>? _identities;
  final String? _briefDesc;
  final int? _albumSize;
  final int? _musicSize;
  final int? _mvSize;
  final int? _fansCount;
  final String? _picUrl;
  final bool? _followed;
  final int? _accountId;

  int get id => _id;

  String? get cover => _cover;

  String? get avatar => _avatar;

  String get name => _name;

  List<dynamic>? get transnames => _transnames;

  List<dynamic>? get alias => _alias;

  List<dynamic>? get identifyTag => _identifyTag;

  List<dynamic>? get identities => _identities;

  String? get briefDesc => _briefDesc;

  int? get albumSize => _albumSize;

  int? get musicSize => _musicSize;

  int? get mvSize => _mvSize;

  int? get fansCount => _fansCount;

  String? get picUrl => _picUrl;

  bool? get followed => _followed;

  int? get accountId => _accountId;

  ArtistProfile._internal({
    required int id,
    String? cover,
    String? avatar,
    required String name,
    List<dynamic>? transnames,
    List<dynamic>? alias,
    List<dynamic>? identifyTag,
    List<dynamic>? identities,
    String? briefDesc,
    int? albumSize,
    int? musicSize,
    int? mvSize,
    int? fansCount,
    String? picUrl,
    bool? followed,
    int? accountId,
  })  : _id = id,
        _cover = cover,
        _avatar = avatar,
        _name = name,
        _transnames = transnames,
        _alias = alias,
        _identifyTag = identifyTag,
        _identities = identities,
        _briefDesc = briefDesc,
        _albumSize = albumSize,
        _musicSize = musicSize,
        _mvSize = mvSize,
        _fansCount = fansCount,
        _picUrl = picUrl,
        _followed = followed,
        _accountId = accountId;

  static T? _getJsonValue<T>(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      return json[key];
    }
    return null;
  }

  factory ArtistProfile.fromJson(Map<String, dynamic> json) {
    return ArtistProfile._internal(
      id: _getJsonValue(json, 'id'),
      cover: _getJsonValue(json, 'cover'),
      avatar: _getJsonValue(json, 'avatar'),
      name: _getJsonValue(json, 'name'),
      transnames: _getJsonValue(json, 'transnames'),
      alias: _getJsonValue(json, 'alias'),
      identifyTag: _getJsonValue(json, 'identifyTag'),
      identities: _getJsonValue(json, 'identities'),
      briefDesc: _getJsonValue(json, 'briefDesc'),
      albumSize: _getJsonValue(json, 'albumSize'),
      musicSize: _getJsonValue(json, 'musicSize'),
      mvSize: _getJsonValue(json, 'mvSize'),
      fansCount: _getJsonValue(json, 'fansCount'),
      picUrl: _getJsonValue(json, 'picUrl'),
      followed: _getJsonValue(json, 'followed'),
      accountId: _getJsonValue(json, 'accountId'),
    );
  }
}
