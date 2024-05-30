import 'package:flutter/material.dart';

abstract class SettingsRepo {
  void switchAppTheme({required ThemeData theme});
  void switchAccentColor({required Color color});
  void changeMessageFont({required String font});
  ThemeData? getThemeData();
  Color? getAccentColor();
  String? getMessageFont();
}
