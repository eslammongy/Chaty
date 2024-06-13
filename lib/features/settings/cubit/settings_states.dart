part of 'settings_cubit.dart';
abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}

class SettingsLoadingState extends SettingsStates {}

class SettingsSwitchThemeState extends SettingsStates {}

class SettingsChangeFontState extends SettingsStates {}

class SettingsSwitchAccentColorState extends SettingsStates {}

class SettingsFailureState extends SettingsStates {
  final String error;
  SettingsFailureState({required this.error});
}
