import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dim {
  static const int signInPageBottomPadding = 70;
  static const double padding5 = 5;
  static const double padding6 = 6;
  static const double padding10 = 10;
  static const double padding15 = 15;
  static const double padding20 = 20;
  static const double padding30 = 30;

  static const double styleDetailListPadding = padding20;

  static const int fontSize20 = 20;
  static const int fontSize18 = 18;
  static const double fontSize15 = 15;
  static const int fontSize12 = 12;

  static const int bannerTitleTypeFontSize = 10;
  static const double bannerDotLarge = 12;
  static const double bannerDotMedium = 9;
  static const double bannerDotSmall = 6;
  static const double bannerInnerPadding = 3;
  static const double borderRadius10 = 10;
  static const double borderRadius20 = 20;

  static const int drawerItemDividingLineHeight = 1;
  static const int drawerBlockDividingLineHeight = 5;

  static const double qrCodeSize = 200;
  static const double bannerHeight = 200;

  static num searchPageTopListWidth = 280;

  static const double margin2 = 2;
  static const double margin5 = 5;
  static const double margin10 = 10;
  static const double margin15 = 15;
  static const double margin20 = 20;

  static const styleDetailDataItemImageHeight = 50;
  static const styleDetailDataItemImageWidth = 50;
  static const styleDetailDataItemTopClipperHeight = 10;

  static const double drawerIconSize = fontSize15;
  static const double drawerItemHorizontalPadding = padding15;
  static const double drawerItemBorderRadius = borderRadius10;

  static double screenUtilOnVertical(num value) {
    return ScreenUtil().setHeight(value);
  }

  static double screenUtilOnHorizontal(num value) {
    return ScreenUtil().setWidth(value);
  }

  static double screenUtilOnSp(num value) {
    return ScreenUtil().setSp(value);
  }
}
