import 'package:flutter/material.dart';
import 'package:chaty/core/utils/user_pref.dart';
import 'package:chaty/core/theme/theme_data.dart';
import 'package:chaty/features/settings/data/settings_repo.dart';

class SettingsRepoImpl extends SettingsRepo {
  @override
  changeMessageFont({required String font}) {
    try {
      SharedPref.saveSelectedMsgFont(font);
    } catch (e) {
      //* Indicate there is an exception happened when saving user preferred message font family
      throw Exception("Failed to save the selected font family.");
    }
  }

  @override
  switchMsgBKColor({required Color color}) {
    try {
      SharedPref.saveSelectedAccentColor(color);
    } catch (e) {
      //* Indicate there is an exception happened when saving user preferred color
      throw Exception("Failed to save the selected color.");
    }
  }

  @override
  switchAppTheme({required ThemeData theme}) {
    try {
      if (theme == getDarkThemeData()) {
        SharedPref.saveSelectedTheme("DARK_THEME");
      }
      SharedPref.saveSelectedTheme("LIGHT_THEME");
    } catch (e) {
      //* Indicate there is an exception happened when saving user preferred theme
      throw Exception("Failed to save the selected theme.");
    }
  }

  @override
  Color? getMsgBKColor() {
    final colorValue = SharedPref.getSelectedAccentColor();
    if (colorValue == null) {
      return null;
    }
    return Color(colorValue);
  }

  @override
  String? getMessageFont() {
    final msgFont = SharedPref.getSelectedMsgFont();
    if (msgFont == null) {
      return null;
    }
    return msgFont;
  }

  @override
  ThemeData? getThemeData() {
    final theme = SharedPref.getSelectedTheme();
    if (theme == null) {
      return null;
    }
    if (theme == "DARK_THEME") {
      return getDarkThemeData();
    }
    return getLightThemeData();
  }
}
