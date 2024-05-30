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

  ThemeData currentTheme = getDarkThemeData();
  bool isLight = false;
  Color primaryColor = CommonColorPalette.primaryColor;
  String msgFont = ubuntuSans;

  switchAppTheme(ThemeData theme) {
    try {
      settingsRepo.switchAppTheme(theme: theme);
      currentTheme = theme;
      setThemeSwitcher();
      emit(SettingsSwitchThemeState());
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  void setThemeSwitcher() {
    if (currentTheme == getLightThemeData()) {
      isLight = true;
    } else {
      isLight = false;
    }
  }

  switchMsgBKColor(Color color) {
    try {
      settingsRepo.switchMsgBKColor(color: color);
      final scheme = currentTheme.colorScheme.copyWith(primary: color);
      currentTheme = currentTheme.copyWith(colorScheme: scheme);
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
      if (theme == null) {
        emit(SettingsFailureState(
            error: "There is an error happened when set your selected theme"));
        return;
      }
      currentTheme = theme;
      setThemeSwitcher();
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  getMsgBKColor() {
    try {
      final color = settingsRepo.getMsgBKColor();
      if (color == null) {
        emit(SettingsFailureState(
            error: "There is an error happened when set your selected color"));
        return;
      }
      final scheme = currentTheme.colorScheme.copyWith(primary: color);
      currentTheme = currentTheme.copyWith(colorScheme: scheme);
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  getSelectedMsgFont() {
    try {
      final font = settingsRepo.getMessageFont();
      if (font == null) {
        emit(SettingsFailureState(
            error:
                "There is an error happened when set your selected msg font"));
        return;
      }
      msgFont = font;
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }
}
