import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> keepUserAuthenticated({required bool isLogged}) async {
    await sharedPreferences.setBool(userAuthCheckerKey, isLogged);
  }

  static Future<void> saveFCMToken({required String token}) async {
    await sharedPreferences.setString(firebaseMsgToken, token);
  }

  static String? getFCMToken() {
    return sharedPreferences.getString(firebaseMsgToken);
  }

  static Future<bool> isUserAuthenticated() async {
    return sharedPreferences.getBool(userAuthCheckerKey) ?? false;
  }

  static Future<bool> saveSelectedTheme(String theme) async {
    return await sharedPreferences.setString(selectedThemeKey, theme);
  }

  static String getSelectedTheme() {
    return sharedPreferences.getString(selectedThemeKey) ?? "DARK_THEME";
  }

  static Future<bool> saveSelectedMsgFont(String font) async {
    return await sharedPreferences.setString(selectedFontKey, font);
  }

  static String getSelectedMsgFont() {
    return sharedPreferences.getString(selectedFontKey) ?? cairoFM;
  }

  static Future<bool> saveSelectedAccentColor(Color color) async {
    return await sharedPreferences.setInt(selectedAColorKey, color.value);
  }

  static int getSelectedAccentColor() {
    return sharedPreferences.getInt(selectedAColorKey) ??
        const Color(0xFF4942E4).value;
  }
}
