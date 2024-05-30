import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/theme/theme_data.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/features/settings/data/settings_repo.dart';
part 'settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit(this.settingsRepo) : super(SettingsInitialState());
  static SettingsCubit get(context) => BlocProvider.of(context);
  final SettingsRepo settingsRepo;

  ThemeData currentTheme = getDarkThemeData();
  String msgFont = ubuntuSans;

  switchAppTheme(ThemeData theme) {
    try {
      settingsRepo.switchAppTheme(theme: theme);
      currentTheme = theme;
      emit(SettingsSwitchThemeState());
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  switchAppAccentColor(Color color) {
    try {
      settingsRepo.switchAccentColor(color: color);
      currentTheme = currentTheme.copyWith(primaryColor: color);
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
    } catch (e) {
      emit(SettingsFailureState(error: e.toString()));
    }
  }

  getSelectedAccentColor() {
    try {
      final color = settingsRepo.getAccentColor();
      if (color == null) {
        emit(SettingsFailureState(
            error: "There is an error happened when set your selected color"));
        return;
      }
      currentTheme = currentTheme.copyWith(primaryColor: color);
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
