import 'package:emebet/features/auth/data/model/auth_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tokens.dart';

class LocalStorage {
  ///////////////////////////////////////////////
  ///   SET TOKENS
  static Future setTokens(Tokens tokens) async {
    final prefs = await SharedPreferences.getInstance();
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
    final prefs = await SharedPreferences.getInstance();
    return Tokens(
      accessToken: prefs.getString('emebetAccessToken'),
      refreshToken: prefs.getString('emebetRefreshToken'),
    );
  }

  ///////////////////////////////////////////////
  ///   SET ID
  static Future setId(dynamic id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("id", id);
  }

  ///////////////////////////////////////////////
  ///   GET ID
  static Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id") ?? "";
  }

  ///////////////////////////////////////////////
  ///   GET ID
  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id") ?? "";
  }

  ///////////////////////////////////////////////
  ///   SET USER INFORMATION
  static Future setUserInformation(Profile profile) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("name", profile.name ?? "");
    prefs.setString("email", profile.email ?? "");
    prefs.setString("phoneNumber", profile.phoneNumber ?? "");
  }

  ///////////////////////////////////////////////
  ///   SET USER INFORMATION
  // static Future<RegistrationParam> getUrerInformationFromLocalStorage() async {
  //   final prefs = await SharedPreferences.getInstance();
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
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("profileImage", profileImage);
  }

  ///////////////////////////////////////////////
  ///   GET PROFILE IMAGE
  static Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("profileImage");
  }

  ///////////////////////////////////////////////
  ///   Check First Time Opening App
  static Future<bool?> isFirstTimeOpeningApp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isFirstTimeOpeningApp");
  }

  ///////////////////////////////////////////////
  ///   set First Time Opening App
  static Future setFirstTimeOpeningApp() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstTimeOpeningApp", true);
  }

  ///////////////////////////////////////////////
  ///   set wallet
  static Future setWalletBalance(double? balance) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble("walletBalance", balance ?? 0);
  }

  ///////////////////////////////////////////////
  ///   set wallet
  static Future<String?> getWalletBalance() async {
    final prefs = await SharedPreferences.getInstance();
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
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    prefs.clear();
    setFirstTimeOpeningApp();

    // Session().logSession(
    //     "cleared", prefs.getString("passengerAccessToken").toString());
    return;
  }
}
