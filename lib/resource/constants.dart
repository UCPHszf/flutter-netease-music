class Constants {
  static const String firebaseCollection = "NeteaseMusicApp";

  static const String settingDoc = 'settings';
  static const String pageSettingDoc = 'pageSetting';

  static const String apiServerField = 'apiServer';
  static const String searchPageTopListField = 'searchPageTopList';
  static const String topListLimitField = 'topListLimit';
  static const String mmkvQRKey = 'qr_key';

  static const String urlSendCaptcha = "/captcha/sent";
  static const String urlCaptchaVerify = "/captcha/verify";

  static const String urlQrcodeKeyGenerate = "/login/qr/key";
  static const String urlQrcodeGenerate = "/login/qr/create";
  static const String urlQrcodeStatus = "/login/qr/check";
  static const String urlLoginStatus = "/login/status";

  static const String urlBanner = "/banner";

  static const String urlArtistDetail = "/artist/detail";
  static const String urlFollowUser = "/follow";

  static const String urlFavoriteSongList = "/likelist";

  static const String urlDefaultSearchWord = "/search/default";
  static const String urlHotSearchDetail = "/search/hot/detail";
  static const String urlSearchSuggestList = "/search/suggest";

  static const String urlSingerList = "/artist/list";
  static const String urlTopSingerList = "/top/artists";
  static const String urlSongListAllTrack = "/playlist/track/all";
  static const String urlAllList = "/toplist";

  static const String urlStyleList = "/style/list";
  static const String urlStylePreference = "/style/preference";
  static const String urlStyleDetail = "/style/detail";
  static const String urlStyleSinger = "/style/artist";
  static const String urlStyleSong = "/style/song";
  static const String urlStyleAlbum = "/style/album";
  static const String urlStylePlayList = "/style/playlist";

  static const String qrcodeKeyGenerateFailedInfo =
      "Failed to generate QRCode key";
  static const String qrcodeGenerateFailedInfo = "Failed to generate QRCode";
  static const String qrcodeGenerateSuccessInfo = "Generate QRCode success";
  static const String qrcodeStatusAccessFailedInfo =
      "Failed to access QRCode status";
  static const String generateQRCode = "点击按钮生成二维码";
  static const String agreePrivacyPolicy =
      "I have read and agree to the privacy policy";
  static const String signInPageAppBarTitle = "登录";
  static const String unKnownPageTitle = "找不到页面";

  static const String search = "搜索";
  static const String defaultSearchText = "搜索音乐、视频、播客、歌词";
  static const String singerCategory = "歌手分类";
  static const String styleCategory = "曲风分类";
  static const String styleDataTip = "根据你的听歌记录生成,每周日更新";
  static const String myStylePreference = "我的曲风偏好";
  static const String playAll = "播放全部";
  static const String sortByHotString = "最热";
  static const String sortByTimeString = "最新";

  static const int singerTypeMale = 1;
  static const int singerTypeFemale = 2;
  static const int singerTypeBand = 3;
  static const int singerAreaCN = 7;
  static const int singerAreaJP = 8;
  static const int singerAreaKR = 16;
  static const int singerAreaEUNA = 96;
  static const int singerAreaOther = 0;

  static const int sortByTime = 1;
  static const int sortByHot = 0;

  static const String songRecognition = "识曲";
  static const String singer = "歌手";
  static const String musicStyle = "曲风";
  static const String styleListen = "听听看";

  static const String topListHotSearch = "热搜榜";
  static const String hotSinger = "热门歌手";

  static String unKnownPageText(String pageName) => "UnKnown Page: $pageName";

  static const String defaultCtCode = "86";
  static const int defaultTopListLimit = 20;

  static const int connectTimeoutSeconds = 20;
  static const int receiveTimeoutSeconds = 20;

  static int statusCodeUnAuthorized = 401;
  static int statusCodeSuccess = 200;
  static int qrExpired = 800;
  static int qrToBeScan = 801;
  static int qrToBeConfirm = 802;
  static int qrAuthorizeSuccess = 803;

  static int requestQRCodeStatusInterval = 2;
  static int requestDefaultSearchTextInterval = 5;

  static const String signInPageRoute = "/signIn";
  static const String homePageRoute = "/home";
  static const String searchPageRoute = "/search";
  static const String singerCategoryPageRoute = "/singerCategory";
  static const String styleCategoryPageRoute = "/styleCategory";
  static const String styleDetailPageRoute = "/styleDetail";

  static const String pageArgumentStyleId = "styleId";
}
