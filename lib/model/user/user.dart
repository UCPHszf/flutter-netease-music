class UserPoint {
  final int _userId;
  final int? _balance;
  final int? _updateTime;
  final int? _version;
  final int? _status;
  final int? _blockBalance;

  int get userId => _userId;

  int? get balance => _balance;

  int? get updateTime => _updateTime;

  int? get version => _version;

  int? get status => _status;

  int? get blockBalance => _blockBalance;

  UserPoint._internal(
      {required int userId,
      int? balance,
      int? updateTime,
      int? version,
      int? status,
      int? blockBalance})
      : _userId = userId,
        _balance = balance,
        _updateTime = updateTime,
        _version = version,
        _status = status,
        _blockBalance = blockBalance;

  factory UserPoint.fromJson(Map<String, dynamic> json) {
    return UserPoint._internal(
        userId: json['userId'],
        balance: json['balance'],
        updateTime: json['updateTime'],
        version: json['version'],
        status: json['status'],
        blockBalance: json['blockBalance']);
  }
}

class AvatarDetail {
  int? _userType;
  int? _identityLevel;
  String? _identityIconUrl;

  int? get userType => _userType;

  int? get identityLevel => _identityLevel;

  String? get identityIconUrl => _identityIconUrl;

  AvatarDetail._internal(
      {int? userType, int? identityLevel, String? identityIconUrl})
      : _userType = userType,
        _identityLevel = identityLevel,
        _identityIconUrl = identityIconUrl;

  factory AvatarDetail.fromJson(Map<String, dynamic> json) {
    return AvatarDetail._internal(
        userType: json['userType'],
        identityLevel: json['identityLevel'],
        identityIconUrl: json['identityIconUrl']);
  }
}

class UserIdentify {
  final String? _identifyImgUrl;
  final String? _identifyImgDesc;

  String? get identifyImgUrl => _identifyImgUrl;

  String? get identifyImgDesc => _identifyImgDesc;

  UserIdentify._internal({String? identifyImgUrl, String? identifyImgDesc})
      : _identifyImgUrl = identifyImgUrl,
        _identifyImgDesc = identifyImgDesc;

  factory UserIdentify.fromJson(Map<String, dynamic> json) {
    return UserIdentify._internal(
        identifyImgUrl: json['identifyImgUrl'],
        identifyImgDesc: json['identifyImgDesc']);
  }
}

class UserProfile {
  final AvatarDetail? _avatarDetail;
  final int? _userType;
  final int? _birthday;
  final String? _nickname;
  final String? _remarkName;
  final int? _authStatus;
  final String? _detailDescription;
  final List<dynamic>? _experts;
  final dynamic _expertTags;
  final int _userId;
  final bool? _mutual;
  final bool? _defaultAvatar;
  final String? _avatarUrl;
  final int? _province;
  final int? _city;
  final int? _gender;
  final bool? _followed;
  final int? _djStatus;
  final int? _vipType;
  final int? _accountStatus;
  final int? _createTime;
  final String? _description;
  final String? _signature;
  final int? _authority;
  final int? _followeds;
  final bool? _blacklist;
  final int? _artistId;
  final int? _eventCount;
  final int? _allSubscribedCount;
  final int? _playlistSubscribedCount;
  final int? _followTime;
  final bool? _followMe;
  final String? _artistName;
  final int? _cCount;
  final int? _playlistCount;

  int? get birthday => _birthday;

  String? get nickname => _nickname;

  String? get remarkName => _remarkName;

  int? get authStatus => _authStatus;

  String? get detailDescription => _detailDescription;

  List<dynamic>? get experts => _experts;

  dynamic get expertTags => _expertTags;

  int get userId => _userId;

  bool? get mutual => _mutual;

  bool? get defaultAvatar => _defaultAvatar;

  String? get avatarUrl => _avatarUrl;

  int? get province => _province;

  int? get city => _city;

  int? get playlistCount => _playlistCount;

  int? get cCount => _cCount;

  bool? get followMe => _followMe;

  int? get followTime => _followTime;

  int? get allSubscribedCount => _allSubscribedCount;

  int? get eventCount => _eventCount;

  int? get artistId => _artistId;

  bool? get blacklist => _blacklist;

  int? get followeds => _followeds;

  String? get description => _description;

  int? get createTime => _createTime;

  int? get vipType => _vipType;

  int? get djStatus => _djStatus;

  bool? get followed => _followed;

  int? get userType => _userType;

  AvatarDetail? get avatarDetail => _avatarDetail;

  int? get playlistSubscribedCount => _playlistSubscribedCount;

  int? get authority => _authority;

  String? get signature => _signature;

  int? get accountStatus => _accountStatus;

  int? get gender => _gender;

  String? get artistName => _artistName;

  UserProfile._internal({
    AvatarDetail? avatarDetail,
    int? userType,
    int? birthday,
    String? nickname,
    String? remarkName,
    int? authStatus,
    String? detailDescription,
    List<dynamic>? experts,
    dynamic expertTags,
    required int userId,
    bool? mutual,
    bool? defaultAvatar,
    String? avatarUrl,
    int? province,
    int? city,
    int? gender,
    bool? followed,
    int? djStatus,
    int? vipType,
    int? accountStatus,
    int? createTime,
    String? description,
    String? signature,
    int? authority,
    int? followeds,
    bool? blacklist,
    int? artistId,
    int? eventCount,
    int? allSubscribedCount,
    int? playlistSubscribedCount,
    int? followTime,
    bool? followMe,
    String? artistName,
    int? cCount,
    int? playlistCount,
  })  : _avatarUrl = avatarUrl,
        _userType = userType,
        _birthday = birthday,
        _nickname = nickname,
        _remarkName = remarkName,
        _authStatus = authStatus,
        _detailDescription = detailDescription,
        _experts = experts,
        _expertTags = expertTags,
        _userId = userId,
        _mutual = mutual,
        _defaultAvatar = defaultAvatar,
        _province = province,
        _city = city,
        _gender = gender,
        _followed = followed,
        _djStatus = djStatus,
        _vipType = vipType,
        _accountStatus = accountStatus,
        _createTime = createTime,
        _description = description,
        _signature = signature,
        _authority = authority,
        _followeds = followeds,
        _blacklist = blacklist,
        _artistId = artistId,
        _eventCount = eventCount,
        _allSubscribedCount = allSubscribedCount,
        _playlistSubscribedCount = playlistSubscribedCount,
        _followTime = followTime,
        _followMe = followMe,
        _artistName = artistName,
        _cCount = cCount,
        _playlistCount = playlistCount,
        _avatarDetail = avatarDetail;

  static T? _getJsonValue<T>(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      return json[key];
    }
    return null;
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile._internal(
      userId: json['userId'],
      avatarUrl: _getJsonValue(json, "avatarUrl"),
      userType: _getJsonValue(json, "userType"),
      birthday: _getJsonValue(json, "birthday"),
      nickname: _getJsonValue(json, "nickname"),
      remarkName: _getJsonValue(json, "remarkName"),
      authStatus: _getJsonValue(json, "authStatus"),
      detailDescription: _getJsonValue(json, "detailDescription"),
      experts: _getJsonValue(json, "experts"),
      expertTags: _getJsonValue(json, "expertTags"),
      mutual: _getJsonValue<bool>(json, "mutual"),
      defaultAvatar: _getJsonValue<bool>(json, "defaultAvatar"),
      province: _getJsonValue<int>(json, "province"),
      city: _getJsonValue<int>(json, "city"),
      gender: _getJsonValue(json, "gender"),
      followed: _getJsonValue<bool>(json, "followed"),
      djStatus: _getJsonValue<int>(json, "djStatus"),
      vipType: _getJsonValue<int>(json, "vipType"),
      accountStatus: _getJsonValue<int>(json, "accountStatus"),
      createTime: _getJsonValue<int>(json, "createTime"),
      description: _getJsonValue(json, "description"),
      signature: _getJsonValue(json, "signature"),
      authority: _getJsonValue<int>(json, "authority"),
      followeds: _getJsonValue<int>(json, "followeds"),
      blacklist: _getJsonValue<bool>(json, "blacklist"),
      artistId: _getJsonValue<int>(json, "artistId"),
      eventCount: _getJsonValue<int>(json, "eventCount"),
      allSubscribedCount: _getJsonValue<int>(json, "allSubscribedCount"),
      playlistSubscribedCount:
          _getJsonValue<int>(json, "playlistSubscribedCount"),
      followTime: _getJsonValue<int>(json, "followTime"),
      followMe: _getJsonValue<bool>(json, "followMe"),
      artistName: _getJsonValue(json, "artistName"),
      cCount: _getJsonValue<int>(json, "cCount"),
      playlistCount: _getJsonValue<int>(json, "playlistCount"),
      avatarDetail: json.containsKey('avatarDetail')
          ? AvatarDetail.fromJson(json['avatarDetail'])
          : null,
    );
  }
}

class User {
  final UserIdentify? _userIdentify;
  final int? _level;
  final int? _listenSongs;
  final UserPoint? _userPoint;
  final bool? _mobileSign;
  final bool? _pcSign;
  final UserProfile? _userProfile;
  final bool? _peopleCanSeeMyPlayRecord;
  final bool? _adValid;
  final bool? _newUser;
  final bool? _recallUser;
  final int? _createTime;
  final int? _createDays;

  User._internal({
    UserIdentify? userIdentify,
    int? level,
    int? listenSongs,
    UserPoint? userPoint,
    bool? mobileSign,
    bool? pcSign,
    UserProfile? userProfile,
    bool? peopleCanSeeMyPlayRecord,
    bool? adValid,
    bool? newUser,
    bool? recallUser,
    int? createTime,
    int? createDays,
  })  : _userIdentify = userIdentify,
        _level = level,
        _listenSongs = listenSongs,
        _userPoint = userPoint,
        _mobileSign = mobileSign,
        _pcSign = pcSign,
        _userProfile = userProfile,
        _peopleCanSeeMyPlayRecord = peopleCanSeeMyPlayRecord,
        _adValid = adValid,
        _newUser = newUser,
        _recallUser = recallUser,
        _createTime = createTime,
        _createDays = createDays;

  UserIdentify? get userIdentify => _userIdentify;

  int? get level => _level;

  int? get listenSongs => _listenSongs;

  UserPoint? get userPoint => _userPoint;

  bool? get mobileSign => _mobileSign;

  bool? get pcSign => _pcSign;

  UserProfile? get userProfile => _userProfile;

  bool? get peopleCanSeeMyPlayRecord => _peopleCanSeeMyPlayRecord;

  bool? get adValid => _adValid;

  bool? get newUser => _newUser;

  bool? get recallUser => _recallUser;

  int? get createTime => _createTime;

  int? get createDays => _createDays;

  static T? _getJsonValue<T>(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      return json[key];
    }
    return null;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User._internal(
      userIdentify: json['userIdentify'] != null
          ? UserIdentify.fromJson(json['userIdentify'])
          : null,
      level: _getJsonValue<int>(json, "level"),
      listenSongs: _getJsonValue<int>(json, "listenSongs"),
      userPoint: json['userPoint'] != null
          ? UserPoint.fromJson(json['userPoint'])
          : null,
      mobileSign: _getJsonValue(json, "mobileSign"),
      pcSign: _getJsonValue(json, "pcSign"),
      userProfile: json['profile'] != null
          ? UserProfile.fromJson(json['profile'])
          : null,
      peopleCanSeeMyPlayRecord:
          _getJsonValue<bool>(json, "peopleCanSeeMyPlayRecord"),
      adValid: _getJsonValue<bool>(json, "adValid"),
      newUser: _getJsonValue<bool>(json, "newUser"),
      recallUser: _getJsonValue<bool>(json, "recallUser"),
      createTime: _getJsonValue<int>(json, "createTime"),
      createDays: _getJsonValue<int>(json, "createDays"),
    );
  }
}
