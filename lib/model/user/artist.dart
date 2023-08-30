// artist detail
class Artist {
  final int? _videoCount;
  final bool? _isVip;
  final String? _identifyImgUrl;
  final String? _identifyImgDesc;
  final String? _coverUrl;
  final int _artistid;
  final String _name;
  final String? _avatarUrl;
  final List<dynamic>? _transnames;
  final List<dynamic>? _alias;
  final List<dynamic>? _identifyTag;
  final List<dynamic>? _identities;
  final String? _briefDesc;
  final int? _albumSize;
  final int? _musicSize;
  final int? _mvSize;
  final bool _blacklist;
  final bool? _gender;
  final int? _provinceCode;
  final int? _cityCode;
  final String? _nickname;
  bool _followed;
  final int? _userId;

  int? get videoCount => _videoCount;

  String? get identifyImgUrl => _identifyImgUrl;

  bool get followed => _followed;

  int? get provinceCode => _provinceCode;

  int? get albumSize => _albumSize;

  List<dynamic>? get identities => _identities;

  int? get cityCode => _cityCode;

  bool get blacklist => _blacklist;

  String? get briefDesc => _briefDesc;

  List<dynamic>? get identifyTag => _identifyTag;

  String? get avatarUrl => _avatarUrl;

  int get artistid => _artistid;

  String? get identifyImgDesc => _identifyImgDesc;

  int? get userId => _userId;

  String? get nickname => _nickname;

  bool? get gender => _gender;

  int? get mvSize => _mvSize;

  int? get musicSize => _musicSize;

  List<dynamic>? get alias => _alias;

  List<dynamic>? get transnames => _transnames;

  String get name => _name;

  String? get coverUrl => _coverUrl;

  bool? get isVip => _isVip;

  set followed(bool followed) {
    _followed = followed;
  }

  Artist._internal(
      {int? videoCount,
      bool? isVip,
      String? identifyImgUrl,
      String? identifyImgDesc,
      String? coverUrl,
      required int artistid,
      required String name,
      String? avatarUrl,
      List<dynamic>? transnames,
      List<dynamic>? alias,
      List<dynamic>? identifyTag,
      List<dynamic>? identities,
      String? briefDesc,
      int? albumSize,
      int? musicSize,
      int? mvSize,
      required bool blacklist,
      bool? gender,
      int? provinceCode,
      int? cityCode,
      String? nickname,
      required bool followed,
      int? userid})
      : _avatarUrl = avatarUrl,
        _albumSize = albumSize,
        _alias = alias,
        _artistid = artistid,
        _blacklist = blacklist,
        _briefDesc = briefDesc,
        _cityCode = cityCode,
        _coverUrl = coverUrl,
        _followed = followed,
        _gender = gender,
        _identifyImgDesc = identifyImgDesc,
        _identifyImgUrl = identifyImgUrl,
        _identifyTag = identifyTag,
        _identities = identities,
        _isVip = isVip,
        _musicSize = musicSize,
        _mvSize = mvSize,
        _name = name,
        _nickname = nickname,
        _provinceCode = provinceCode,
        _transnames = transnames,
        _userId = userid,
        _videoCount = videoCount;

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist._internal(
      artistid: json['artist']['id'],
      alias: json['artist']['alias'],
      albumSize: json['artist']['albumSize'],
      avatarUrl: json['artist']['avatar'],
      blacklist: json['blacklist'],
      briefDesc: json['artist']['briefDesc'],
      cityCode: json['user'] != null && json['user'].containsKey('city')
          ? json['user']['city']
          : null,
      coverUrl: json['artist']['cover'],
      followed: json['user'] != null && json['user'].containsKey('followed')
          ? json['user']['followed']
          : false,
      gender: json['user'] != null && json['user'].containsKey('gender')
          ? json['user']['followed']
          : null,
      identifyImgDesc: json['artist']['identify'] != null &&
              json['artist']['identify'].containsKey('imageDesc')
          ? json['artist']['identify']['imageDesc']
          : null,
      identifyImgUrl: json['artist']['identify'] != null &&
              json['artist']['identify'].containsKey('imageUrl')
          ? json['artist']['identify']['imageUrl']
          : null,
      identifyTag: json['artist']['identifyTag'],
      identities: json['artist']['identities'],
      isVip: json.containsKey('vipRights'),
      musicSize: json['artist']['musicSize'],
      mvSize: json['artist']['mvSize'],
      name: json['artist']['name'],
      nickname: json['user'] != null && json['user'].containsKey('nickname')
          ? json['user']['nickname']
          : null,
      provinceCode: json['user'] != null && json['user'].containsKey('province')
          ? json['user']['province']
          : null,
      transnames: json['artist']['transNames'],
      userid: json['user'] != null && json['user'].containsKey('userId')
          ? json['user']['userId']
          : null,
      videoCount: json['artist']['videoCount'],
    );
  }
}
