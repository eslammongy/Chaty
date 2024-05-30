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
    await sharedPreferences.setBool('UserAuthCheckerKey', isLogged);
  }

  static Future<bool> isUserAuthenticated() async {
    return sharedPreferences.getBool('UserAuthCheckerKey') ?? false;
  }

  static Future<bool> saveSelectedTheme(String theme) async {
    return await sharedPreferences.setString(selectedThemeKey, theme);
  }

  static Future<String?> getSelectedThem() async {
    return sharedPreferences.getString(selectedThemeKey);
  }

  static Future<bool> saveSelectedMsgFont(String font) async {
    return await sharedPreferences.setString(selectedFontKey, font);
  }

  static Future<String?> getSelectedMsgFont() async {
    return sharedPreferences.getString(selectedFontKey);
  }

  static Future<bool> saveSelectedAccentColor(Color color) async {
    return await sharedPreferences.setInt(selectedAColorKey, color.value);
  }

  static Future<bool?> getSelectedAccentColor() async {
    return sharedPreferences.getBool(selectedAColorKey);
  }
}
