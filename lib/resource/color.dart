import 'package:flutter/material.dart';

class AppColor {
  static const Color signInPageTopContainerGradientStart = Color(0x90ffe0b2);
  static const Color signInPageTopContainerGradientEnd = Color(0x00FFE0B2);

  static const Color homePageSearchBarGradientStart = Color(0x20bba4fe);
  static const Color homePageSearchBarGradientEnd = Color(0x20e5b2fe);

  static const String myStylePreferenceColorShallow = "FFCDD2";
  static const String myStylePreferenceColorDeep = "D32F2F";

  static const Color styleTopContentTextShallow = Color(0x80FFE0B2);

  static const Color subCategoryIconColor = Colors.redAccent;
  static const Color dividerColor = grey;
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  static Color parseColorString(String colorString) {
    return Color(int.parse("0xFF$colorString"));
  }

  static Color brighterColor(String colorString, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    Color originalColor = Color(int.parse("0xFF$colorString"));
    final hsl = HSLColor.fromColor(originalColor);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  static Color darkerColor(String colorString, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    Color originalColor = Color(int.parse("0xFF$colorString"));
    final hsl = HSLColor.fromColor(originalColor);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
