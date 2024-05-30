import 'package:flutter/material.dart';

abstract class SettingsRepo {
  void switchAppTheme({required ThemeData theme});
  void switchAccentColorC({required Color color});
  void changeMessageFont({required String font});
}
