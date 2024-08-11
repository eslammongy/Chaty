import 'package:flutter/material.dart';

abstract class SettingsRepo {
  void switchAppTheme({required ThemeData theme});
  void switchMsgBKColor({required Color color});
  void changeMessageFont({required String font});
  ThemeData getThemeData();
  Color getMsgBKColor();
  String getMessageFont();
}
