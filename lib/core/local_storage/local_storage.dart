import 'package:intl/intl.dart';
import 'package:mvvm/features/auth/data/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/injections.dart';
import 'tokens.dart';

class LocalStorage {
  ///////////////////////////////////////////////
  ///   SET TOKENS
  static Future setTokens(Tokens tokens) async {
    final prefs = sl<SharedPreferences>();
    if (tokens.accessToken != null) {
      await prefs.setString('emebetAccessToken', tokens.accessToken ?? "");
    }
    if (tokens.refreshToken != null) {
      await prefs.setString('emebetRefreshToken', tokens.refreshToken ?? "");
    }
  }

  ///////////////////////////////////////////////
  ///   GET TOKENS
  static Future<Tokens> getTokens() async {
    final prefs = sl<SharedPreferences>();
    return Tokens(
      accessToken: prefs.getString('emebetAccessToken'),
      refreshToken: prefs.getString('emebetRefreshToken'),
    );
  }

  ///////////////////////////////////////////////
  ///   SET ID
  static Future setId(String id) async {
    final prefs = sl<SharedPreferences>();
    prefs.setString("id", id);
  }

  ///////////////////////////////////////////////
  ///   GET ID
  static Future<String> getId() async {
    final prefs = sl<SharedPreferences>();
    return prefs.getString("id") ?? "";
  }

  ///////////////////////////////////////////////
  ///   GET ID
  static Future<String> getUserId() async {
    final prefs = sl<SharedPreferences>();
    return prefs.getString("id") ?? "";
  }

  ///////////////////////////////////////////////
  ///   SET USER INFORMATION
  static Future setUserInformation(AuthModel profile) async {
    final prefs = sl<SharedPreferences>();
    prefs.setString("name", profile.name ?? "");
  }

  ///////////////////////////////////////////////
  ///   SET USER INFORMATION
  // static Future<RegistrationParam> getUrerInformationFromLocalStorage() async {
  // final prefs = sl<SharedPreferences>();
  //   return RegistrationParam(
  //     gender: "",
  //     name: prefs.getString("name") ?? "",
  //     password: "",
  //     phoneNumber: prefs.getString("phoneNumber") ?? "",
  //   );
  // }

  ///////////////////////////////////////////////
  ///   SET PROFILE IMAGE
  static Future setProfileImage(String profileImage) async {
    final prefs = sl<SharedPreferences>();
    prefs.setString("profileImage", profileImage);
  }

  ///////////////////////////////////////////////
  ///   GET PROFILE IMAGE
  static Future<String?> getProfileImage() async {
    final prefs = sl<SharedPreferences>();
    return prefs.getString("profileImage");
  }

  ///////////////////////////////////////////////
  ///   Check First Time Opening App
  static Future<bool?> isFirstTimeOpeningApp() async {
    final prefs = sl<SharedPreferences>();
    return prefs.getBool("isFirstTimeOpeningApp");
  }

  ///////////////////////////////////////////////
  ///   set First Time Opening App
  static Future setFirstTimeOpeningApp() async {
    final prefs = sl<SharedPreferences>();
    prefs.setBool("isFirstTimeOpeningApp", true);
  }

  ///////////////////////////////////////////////
  ///   set wallet
  static Future setWalletBalance(double? balance) async {
    final prefs = sl<SharedPreferences>();
    prefs.setDouble("walletBalance", balance ?? 0);
  }

  ///////////////////////////////////////////////
  ///   set wallet
  static Future<String?> getWalletBalance() async {
    final prefs = sl<SharedPreferences>();
    var formatter = NumberFormat('#,###,###,000');
    double? balance = prefs.getDouble("walletBalance");
    if ((balance ?? 0) < 100) {
      return balance?.toStringAsFixed(2);
    }
    return "${formatter.format(balance)}.00";
  }

  ///////////////////////////////////////////////
  ///   GET PROFILE IMAGE
  static Future clearLocalStorage() async {
    final prefs = sl<SharedPreferences>();
    prefs.reload();
    prefs.clear();
    setFirstTimeOpeningApp();

    // Session().logSession(
    //     "cleared", prefs.getString("passengerAccessToken").toString());
    return;
  }
}
