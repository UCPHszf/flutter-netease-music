import 'package:cloud_music/model/song/album.dart';
import 'package:cloud_music/model/user/artist.dart';

class Quality {
  final int _size;
  final int _vd;
  final int _br;
  final int _sr;

  Quality._internal({
    required int size,
    required int vd,
    required int br,
    required int sr,
  })  : _size = size,
        _vd = vd,
        _br = br,
        _sr = sr;

  int get size => _size;

  int get vd => _vd;

  int get br => _br;

  int get sr => _sr;

  factory Quality.fromJson(Map<String, dynamic> json) {
    return Quality._internal(
      size: json['size'].toInt(),
      vd: json['vd'].toInt(),
      br: json['br'].toInt(),
      sr: json['sr'].toInt(),
    );
  }
}

class Song {
  final int _id;
  final String _name;
  final int? _type;
  final List<ArtistProfile>? _artists;
  final List<dynamic>? _alias;

  // 歌曲热度
  final int? _popularity;

  //   0: 免费或无版权
  //   1: VIP 歌曲
  //   4: 购买专辑
  //   8: 非会员可免费播放低音质，会员可播放高音质及下载
  //   fee 为 1 或 8 的歌曲均可单独购买 2 元单曲

  final int? _fee;
  final Album? _album;
  final int? _version;

  // 0: 有专辑信息或者是DJ节目 1: 未知专辑
  final int? _single;

  // 单位为毫秒的时间戳
  final int? _publishTime;

  //0: 不是DJ节目 其他：是DJ节目，表示DJ ID
  final int? _djId;

  // 对于t == 2的歌曲，表示匹配到的公开版本歌曲ID
  final int? _s_id;

  // 歌曲时长，单位为毫秒
  final int? _durationTime;

  // 0:未知 1:原曲 2.翻唱
  final int? _originCoverType;

  // 表示专辑中第几张cd
  final String? _cd;

  // 表示歌曲属于CD中第几曲
  final int? _no;

  //无损音质
  final Quality? _sq;

  //高品音质
  final Quality? _h;

  //标准音质
  final Quality? _m;

  //低品音质
  final Quality? _l;

  // 非零表示有MV ID
  final int? _mvId;

  final bool? _resourceState;

  int get id => _id;

  DateTime get publishTimeDate =>
      DateTime.fromMillisecondsSinceEpoch(publishTime!);

  String getSongDuration() {
    int seconds = durationTime! ~/ 1000;
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    String secondsStr = seconds.toString();
    if (seconds < 10) {
      secondsStr = '0$secondsStr';
    }
    String minutesStr = minutes.toString();
    if (minutes < 10) {
      minutesStr = '0$minutesStr';
    }
    if (minutes >= 60) {
      int hours = minutes ~/ 60;
      minutes = minutes % 60;
      String hoursStr = hours.toString();
      if (hours < 10) {
        hoursStr = '0$hoursStr';
      }
      return '$hoursStr:$minutesStr:$secondsStr';
    }
    return '$minutesStr:$secondsStr';
  }

  String get name => _name;

  int? get type => _type;

  List<ArtistProfile>? get artists => _artists;

  List<dynamic>? get alias => _alias;

  int? get popularity => _popularity;

  int? get fee => _fee;

  Album? get album => _album;

  int? get version => _version;

  int? get single => _single;

  int? get publishTime => _publishTime;

  int? get djId => _djId;

  int? get s_id => _s_id;

  int? get durationTime => _durationTime;

  int? get originCoverType => _originCoverType;

  String? get cd => _cd;

  int? get no => _no;

  Quality? get sq => _sq;

  Quality? get h => _h;

  Quality? get m => _m;

  Quality? get l => _l;

  int? get mvId => _mvId;

  bool? get resourceState => _resourceState;

  Song._internal({
    required int id,
    required String name,
    int? type,
    List<ArtistProfile>? artists,
    List<dynamic>? alias,
    int? popularity,
    int? fee,
    Album? album,
    int? version,
    int? single,
    int? publishTime,
    int? djId,
    int? s_id,
    int? durationTime,
    int? originCoverType,
    String? cd,
    int? no,
    Quality? sq,
    Quality? h,
    Quality? m,
    Quality? l,
    int? mvId,
    bool? resourceState,
  })  : _id = id,
        _name = name,
        _type = type,
        _artists = artists,
        _alias = alias,
        _popularity = popularity,
        _fee = fee,
        _album = album,
        _version = version,
        _single = single,
        _publishTime = publishTime,
        _djId = djId,
        _s_id = s_id,
        _durationTime = durationTime,
        _originCoverType = originCoverType,
        _cd = cd,
        _no = no,
        _sq = sq,
        _h = h,
        _m = m,
        _l = l,
        _mvId = mvId,
        _resourceState = resourceState;

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

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song._internal(
      id: _getJsonValue(json, 'id'),
      name: _getJsonValue(json, 'name'),
      type: _getJsonValue(json, 'type'),
      artists: json.containsKey("ar") && json["ar"] != null
          ? List<ArtistProfile>.from(
              json["ar"].map((x) => ArtistProfile.fromJson(x)))
          : null,
      alias: _getJsonValue(json, 'alias'),
      popularity: _getJsonValue(json, 'pop'),
      fee: _getJsonValue(json, 'fee'),
      album: _parseJsonObjectInJson<Album>(
          json, "al", (json) => Album.fromJson(json)),
      version: _getJsonValue(json, "version"),
      single: _getJsonValue(json, "single"),
      publishTime: _getJsonValue(json, "publishTime"),
      djId: _getJsonValue(json, "djId"),
      s_id: _getJsonValue(json, "s_id"),
      durationTime: _getJsonValue(json, "dt"),
      originCoverType: _getJsonValue(json, "originCoverType"),
      cd: _getJsonValue(json, "cd"),
      no: _getJsonValue(json, "no"),
      sq: _parseJsonObjectInJson<Quality>(
          json, "sq", (json) => Quality.fromJson(json)),
      h: _parseJsonObjectInJson(json, "h", (json) => Quality.fromJson(json)),
      m: _parseJsonObjectInJson(json, "m", (json) => Quality.fromJson(json)),
      l: _parseJsonObjectInJson(json, "l", (json) => Quality.fromJson(json)),
      mvId: _getJsonValue(json, "mv"),
      resourceState: _getJsonValue(json, "resourceState"),
    );
  }
}
