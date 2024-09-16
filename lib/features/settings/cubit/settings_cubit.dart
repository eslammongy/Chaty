import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/theme/theme_data.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/core/theme/common_palette.dart';
import 'package:chaty/features/settings/data/settings_repo.dart';
part 'settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit({required this.settingsRepo}) : super(SettingsInitialState()) {
    getSelectedTheme();
    getMsgBKColor();
  }
  static SettingsCubit get(context) => BlocProvider.of(context);
  final SettingsRepo settingsRepo;

  int currentPageIndex = 0;
  ThemeData currentTheme = darkThemeData();
  bool isLight = false;
  Color msgBkColor = CommonColorPalette.primaryColor;
  String msgFont = ubuntuSans;

  switchAppTheme(ThemeData theme) {
    try {
      settingsRepo.switchAppTheme(theme: theme);
      currentTheme = theme;
      isLight = currentTheme == lightThemeData();
      emit(SettingsSwitchThemeState());
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  switchMsgBKColor(Color color) {
    try {
      settingsRepo.switchMsgBKColor(color: color);
      msgBkColor = color;
      emit(SettingsSwitchAccentColorState());
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  changeMsgFontFamily(String font) {
    try {
      settingsRepo.changeMessageFont(font: font);
      msgFont = font;
      emit(SettingsChangeFontState());
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  getSelectedTheme() {
    try {
      final theme = settingsRepo.getThemeData();
      currentTheme = theme;
      isLight = currentTheme == lightThemeData();
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  getMsgBKColor() {
    try {
      final color = settingsRepo.getMsgBKColor();
      msgBkColor = color;
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  getSelectedMsgFont() {
    try {
      final font = settingsRepo.getMessageFont();
      msgFont = font;
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }
}
