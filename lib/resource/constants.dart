class Constants {
  static const String firebaseSettingCollection = "setting";
  static const String firebasePageSettingCollection = "pageSetting";
  static const String apiDocument = 'api';
  static const String searchPageDocument = 'searchPage';
  static const String apiServerField = 'apiServer';
  static const String topListField = 'topList';
  static const String topListLimitField = 'topListLimit';

  static const String urlSendCaptcha = "/captcha/sent";
  static const String urlCaptchaVerify = "/captcha/verify";
  static const String urlQrcodeKeyGenerate = "/login/qr/key";
  static const String urlQrcodeGenerate = "/login/qr/create";
  static const String urlQrcodeStatus = "/login/qr/check";
  static const String urlDefaultSearchWord = "/search/default";
  static const String urlBanner = "/banner";
  static const String urlFavoriteSongList = "/likelist";
  static const String urlSingerList = "/artist/list";
  static const String urlHotSearchDetail = "/search/hot/detail";
  static String urlSearchSuggestList = "/search/suggest";
  static String urlSongListAllTrack = "/playlist/track/all";
  static String urlAllList = "/toplist";

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
  static const String unKnownPageTitle = "You are lost";

  static const String search = "搜索";
  static const String defaultSearchText = "搜索音乐、视频、播客、歌词";
  static const int singerTypeMale = 1;
  static const int singerTypeFemale = 2;
  static const int singerTypeBand = 3;
  static const int singerAreaCN = 7;
  static const int singerAreaJP = 8;
  static const int singerAreaKR = 16;
  static const int singerAreaEUNA = 96;
  static const int singerAreaOther = 0;

  static const String songRecognition = "识曲";
  static const String singer = "歌手";
  static const String musicStyle = "曲风";

  static const String topListHotSearch = "热搜榜";

  static String unKnownPageText(String pageName) => "UnKnown Page: $pageName";

  static const String defaultCtCode = "86";
  static const int defaultTopListLimit = 20;

  static const int connectTimeoutSeconds = 10;
  static const int receiveTimeoutSeconds = 10;

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
}
