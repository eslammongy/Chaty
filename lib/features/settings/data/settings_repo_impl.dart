import 'package:flutter/material.dart';
import 'package:chaty/core/utils/user_pref.dart';
import 'package:chaty/core/theme/theme_data.dart';
import 'package:chaty/features/settings/data/settings_repo.dart';

class SettingsRepoImpl extends SettingsRepo {
  @override
  String? changeMessageFont({required String font}) {
    try {
      SharedPref.saveSelectedMsgFont(font);
      return font;
    } catch (e) {
      //* Indicate there is an exception happened when saving user preferred message font family
      return null;
    }
  }

  @override
  Color? switchAccentColorC({required Color color}) {
    try {
      SharedPref.saveSelectedAccentColor(color);
      return color;
    } catch (e) {
      //* Indicate there is an exception happened when saving user preferred color
      return null;
    }
  }

  @override
  ThemeData? switchAppTheme({required ThemeData theme}) {
    try {
      if (theme == getDarkThemeData()) {
        SharedPref.saveSelectedTheme("DARK_THEME");
        return getDarkThemeData();
      }
      SharedPref.saveSelectedTheme("LIGHT_THEME");
      return getLightThemeData();
    } catch (e) {
      //* Indicate there is an exception happened when saving user preferred theme
      return null;
    }
  }
}
