import 'package:flutter/material.dart';

abstract class SettingsRepo {
  ThemeData? switchAppTheme({required ThemeData theme});
  Color? switchAccentColorC({required Color color});
  String? changeMessageFont({required String font});
}
