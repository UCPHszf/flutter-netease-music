import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_music/model/song/album.dart';
import 'package:cloud_music/model/song/cursorInfo.dart';
import 'package:cloud_music/model/song/song.dart';
import 'package:cloud_music/model/song/topListSong.dart';
import 'package:cloud_music/model/style/musicStyle.dart';
import 'package:cloud_music/model/user/artist.dart';
import 'package:cloud_music/model/user/topListSinger.dart';
import 'package:cloud_music/model/widget/bannerItem.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/resource/enum.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'dependencies.dart';
import 'networkManager.dart';

class NetworkRequest {
  static Logger _logger = getIt<Logger>();

  static String buildUrl(String url, Map<String, dynamic> params) {
    if (params.isEmpty) {
      return url;
    }
    StringBuffer sb = StringBuffer();
    sb.write(url);
    sb.write("?");
    params.forEach((key, value) {
      sb.write("$key=$value&");
    });
    String result = sb.toString();
    result = result.substring(0, result.length - 1);
    return result;
  }

  static Dio getDio() => GetIt.instance<NetworkManager>().dio;

  static String timestampString() =>
      DateTime.now().millisecondsSinceEpoch.toString();

  // 验证码发送
  static Future<bool> sentCaptcha(String phoneNumber,
      {String ctcode = Constants.defaultCtCode}) async {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlSendCaptcha;
    final Map<String, dynamic> params = {
      "phone": phoneNumber,
      "ctcode": ctcode,
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    Response response = await dio.get(buildUrl);
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return data["code"] == Constants.statusCodeSuccess;
  }

  // 验证码验证
  static Future<bool> captchaVerify(String phoneNumber, String captcha,
      {String ctcode = Constants.defaultCtCode}) async {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlCaptchaVerify;
    final Map<String, dynamic> params = {
      "phone": phoneNumber,
      "ctcode": ctcode,
      "captcha": captcha,
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    Response response = await dio.get(buildUrl);
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return data["data"] == true && data["code"] == Constants.statusCodeSuccess;
  }

  // 生成二维码key
  static Future<String> generateQRCodeKey() async {
    Dio dio = getDio();
    String fieldName = "unikey";
    final String url = dio.options.baseUrl + Constants.urlQrcodeKeyGenerate;
    final Map<String, dynamic> params = {"timestamp": timestampString()};
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    Response response = await dio.get(buildUrl);
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    if (data["code"] != Constants.statusCodeSuccess) {
      return Constants.qrcodeKeyGenerateFailedInfo;
    } else {
      return data["data"][fieldName] as String;
    }
  }

  // 生成二维码
  static Future<String> generateQRCode(String qrCodeKey) async {
    if (qrCodeKey == Constants.qrcodeKeyGenerateFailedInfo) {
      return Constants.qrcodeGenerateFailedInfo;
    }
    String fieldName = "qrimg";
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlQrcodeGenerate;
    final Map<String, dynamic> params = {
      "key": qrCodeKey,
      "qrimg": true,
      "timestamp": timestampString()
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    Response response = await dio.get(buildUrl);
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    if (data["code"] != 200) {
      return Constants.qrcodeGenerateFailedInfo;
    } else {
      return data["data"][fieldName] as String;
    }
  }

  // 检查二维码状态
  static Future<int> checkQRCodeStatus(String qrCodeKey) async {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlQrcodeStatus;
    final Map<String, dynamic> params = {
      "key": qrCodeKey,
      "timestamp": timestampString()
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    Response response = await dio.get(buildUrl);
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    if (data["code"] != 200) {
      return data["code"] as int;
    } else {
      return data["data"]["status"] as int;
    }
  }

  // 获取默认搜索词
  static Future<String> getDefaultSearchWord() {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlDefaultSearchWord;
    return dio.get(url).then((response) {
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data["code"] != 200) {
        return "";
      } else {
        return data["data"]["showKeyword"] as String;
      }
    });
  }

  // 获取轮播图
  static Future<List<BannerItem>> getBannerData() {
    int getPlatformType() {
      if (Platform.isAndroid) {
        return 1;
      } else if (Platform.isIOS) {
        return 2;
      } else {
        return 0;
      }
    }

    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlBanner;
    final Map<String, dynamic> params = {
      "type": getPlatformType(),
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    return dio.get(buildUrl).then((response) {
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      if (data["code"] != 200) {
        return [];
      } else {
        List<BannerItem> bannerList = [];
        List<dynamic> banners = data["banners"] as List<dynamic>;
        for (var element in banners) {
          bannerList.add(BannerItem.fromJson(element as Map<String, dynamic>));
        }
        return bannerList;
      }
    });
  }

  // 获取用户喜爱歌曲列表
  static Future<List<String>> favoriteList(int userid) {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlFavoriteSongList;
    final Map<String, dynamic> params = {"id": userid};
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    return dio.get(buildUrl).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200) {
          return [];
        } else {
          List<String> favoriteList = [];
          List<dynamic> favorites = data["data"] as List<dynamic>;
          for (var element in favorites) {
            favoriteList.add(element as String);
          }
          return favoriteList;
        }
      },
    );
  }

  // 获取歌手列表
  static Future<List<TopListSinger>> artistList(
      {int singerType = Constants.singerTypeMale,
      int singerArea = Constants.singerAreaCN,
      Char? initial}) {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlSingerList;
    final Map<String, dynamic> params = {
      "type": singerType,
      "area": singerArea,
    };
    if (initial != null) {
      params["initial"] = initial;
    }
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    return dio.get(buildUrl).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200) {
          return [];
        } else {
          List<TopListSinger> singerList = [];
          List<dynamic> singers = data["artists"] as List<dynamic>;
          for (var element in singers) {
            singerList.add(
              TopListSinger.fromJson(element as Map<String, dynamic>),
            );
          }
          return singerList;
        }
      },
    );
  }

  // 获取热搜歌曲列表
  @Deprecated("replace by topList")
  static Future<List<TopListSong>> hotSearchSongList() {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlHotSearchDetail;
    return dio.get(url).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200) {
          return [];
        } else {
          List<TopListSong> hotSearchSongList = [];
          List<dynamic> hotSearchSongs = data["data"] as List<dynamic>;
          for (var element in hotSearchSongs) {
            hotSearchSongList.add(
              TopListSong.fromHotSearch(element as Map<String, dynamic>),
            );
          }
          return hotSearchSongList;
        }
      },
    );
  }

  // 搜索建议
  Future<List<String>> searchSuggestList(String keywords,
      {String type = "mobile"}) {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlSearchSuggestList;
    final Map<String, dynamic> params = {
      "keywords": keywords,
      "type": type,
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    return dio.get(buildUrl).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200) {
          return [];
        } else {
          List<String> suggestList = [];
          List<dynamic> suggests = data["result"]["allMatch"] as List<dynamic>;
          for (var element in suggests) {
            suggestList.add(element["keyword"] as String);
          }
          return suggestList;
        }
      },
    );
  }

  // 获取所有榜单
  static Future<Map<String, int>> allTopList() {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlAllList;
    return dio.get(url).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200) {
          return {};
        } else {
          Map<String, int> topList = {};
          List<dynamic> topLists = data["list"] as List<dynamic>;
          for (var element in topLists) {
            topList[element["name"]] = element["id"];
          }
          return topList;
        }
      },
    );
  }

  // 获取榜单信息
  static Future<List<TopListSong>> topList(
      {required TopListType topListType, int? topListId}) {
    Dio dio = getDio();
    final String url;
    if (topListType == TopListType.hotSearch) {
      url = dio.options.baseUrl + Constants.urlHotSearchDetail;
      return dio.get(url).then(
        (response) {
          final Map<String, dynamic> data =
              response.data as Map<String, dynamic>;
          if (data["code"] != 200) {
            return [];
          } else {
            List<TopListSong> hotSearchSongList = [];
            List<dynamic> hotSearchSongs = data["data"] as List<dynamic>;
            for (var element in hotSearchSongs) {
              hotSearchSongList.add(
                TopListSong.fromHotSearch(element as Map<String, dynamic>),
              );
            }
            return hotSearchSongList;
          }
        },
      );
    } else {
      url = dio.options.baseUrl + Constants.urlSongListAllTrack;
      Map<String, dynamic> params = {
        "id": topListId,
      };
      final String buildUrl = NetworkRequest.buildUrl(url, params);
      return dio.get(buildUrl).then(
        (response) {
          final Map<String, dynamic> data =
              response.data as Map<String, dynamic>;
          if (data["code"] != 200) {
            return [];
          } else {
            List<TopListSong> topList = [];
            List<dynamic> songs = data["songs"] as List<dynamic>;
            for (var element in songs) {
              topList.add(
                TopListSong.fromSongList(element as Map<String, dynamic>),
              );
            }
            return topList;
          }
        },
      );
    }
  }

  // 获取pageSettingDoc的所有配置
  static Future<Map<String, dynamic>> pageSetting() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collection(Constants.firebaseCollection)
        .doc(Constants.pageSettingDoc)
        .get()
        .then(
      (DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          return snapshot.data() as Map<String, dynamic>;
        } else {
          return {};
        }
      },
    );
  }

  // 检测是否登录
  static Future<bool> isLogin() {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlLoginStatus;
    return dio.get(url).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200) {
          return false;
        } else {
          return data["profile"] != null;
        }
      },
    );
  }

  // 获取热门歌手列表
  static Future<List<TopListSinger>> hotSingerList({int offset = 0}) {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlTopSingerList;
    return dio.get(url).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200) {
          return [];
        } else {
          List<TopListSinger> result = [];
          List<dynamic> hotSingers = data["artists"] as List<dynamic>;
          for (var element in hotSingers) {
            result.add(
              TopListSinger.fromJson(element as Map<String, dynamic>),
            );
          }
          return result;
        }
      },
    );
  }

  // 获取歌手详情
  static Future<Artist?> artistDetail(int artistId) {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlArtistDetail;
    final Map<String, dynamic> params = {
      "id": artistId,
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    return dio.get(buildUrl).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200) {
          return null;
        } else {
          return Artist.fromJson(data["data"] as Map<String, dynamic>);
        }
      },
    );
  }

  // 关注用户
  static Future<bool> followUser(int userId, bool follow) {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlFollowUser;
    final Map<String, dynamic> params = {
      "id": userId,
      "t": follow ? 1 : 0,
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    return dio.post(buildUrl).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        return data["code"] == 200;
      },
    );
  }

  // 获取曲风列表
  static Future<List<MusicStyle>> styleList() {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlStyleList;
    return dio.get(url).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200) {
          return [];
        } else {
          List<MusicStyle> result = [];
          List<dynamic> musicStyles = data["data"] as List<dynamic>;
          for (var element in musicStyles) {
            result.add(
              MusicStyle.fromJson(element as Map<String, dynamic>),
            );
          }
          return result;
        }
      },
    );
  }

  // 获取用户曲风偏好
  static Future<(List<MusicStyle>, List<MusicStyle>)> stylePreference() {
    Dio dio = getDio();
    (List<MusicStyle>, List<MusicStyle>) result = ([], []);
    final String url = dio.options.baseUrl + Constants.urlStylePreference;
    return dio.get(url).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] != 200 || data["data"] == null) {
          return result;
        } else {
          for (var element in data["data"]["tagPreferenceVos"]) {
            result.$1.add(MusicStyle.fromStylePreference(element));
          }
          for (var element in data["data"]["tags"]) {
            result.$2.add(MusicStyle.fromJson(element));
          }
          return result;
        }
      },
    );
  }

  // 获取曲风详情
  static Future<MusicStyle?> styleDetail(int tagId) {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlStyleDetail;
    final Map<String, dynamic> params = {
      "tagId": tagId,
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    return dio.get(buildUrl).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data["code"] == Constants.statusCodeSuccess) {
          return MusicStyle.fromStyleDetail(
              data["data"] as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  //获取曲风歌曲
  static Future<(CursorInfo, List<Song>)> styleSong(
      {required int tagId,
      int size = 20,
      cursor = 0,
      sortType = Constants.sortByHot}) {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlStyleSong;
    final Map<String, dynamic> params = {
      "tagId": tagId,
      "size": size,
      "cursor": cursor,
      "sort": sortType,
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    return dio.get(buildUrl).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        List<Song> result = [];
        if (data["code"] == Constants.statusCodeSuccess) {
          for (var element in data["data"]["songs"]) {
            result.add(Song.fromBrief(element as Map<String, dynamic>));
          }
        }
        CursorInfo cursorInfo =
            CursorInfo.fromJson(data["data"]["page"] as Map<String, dynamic>);
        return (cursorInfo, result);
      },
    );
  }

  //获取曲风专辑
  static Future<(CursorInfo, List<Album>)> styleAlbum(
      {required int tagId,
      int size = 20,
      cursor = 0,
      sortType = Constants.sortByHot}) {
    Dio dio = getDio();
    final String url = dio.options.baseUrl + Constants.urlStyleAlbum;
    final Map<String, dynamic> params = {
      "tagId": tagId,
      "size": size,
      "cursor": cursor,
      "sort": sortType,
    };
    final String buildUrl = NetworkRequest.buildUrl(url, params);
    return dio.get(buildUrl).then(
      (response) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        List<Album> result = [];
        if (data["code"] == Constants.statusCodeSuccess) {
          for (var element in data["data"]["albums"]) {
            result.add(Album.fromAlbumBrief(element as Map<String, dynamic>));
          }
        }
        CursorInfo cursorInfo =
            CursorInfo.fromJson(data["data"]["page"] as Map<String, dynamic>);
        return (cursorInfo, result);
      },
    );
  }
}
