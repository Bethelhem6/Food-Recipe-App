import 'package:emebet/shared/data/data_sources/app_shared_prefs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constant/app_constants.dart';
import '../utils/injections.dart';

class Helper {
  /// Get svg picture path
  static String getSvgPath(String name) {
    return "$svgPath$name";
  }

  /// Get image picture path
  static String getImagePath(String name) {
    return "$imagePath$name";
  }

  /// Get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  /// Get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }

  /// Get Dio Header
  static Map<String, dynamic> getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }..removeWhere((key, value) => value == null);
    // Tokens tokens = await LocalStorage.getTokens();
    // return {
    // 'Content-Type': 'application/json',
    // 'Accept': 'application/json',
    //   'Authorization': 'Bearer ${tokens.accessToken}',
    // };
  }

  static bool isDarkTheme() {
    return sl<AppSharedPrefs>().getIsDarkTheme();
  }
}
