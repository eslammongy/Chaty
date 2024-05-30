import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/theme/theme_data.dart';
part 'settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());
  static SettingsCubit get(context) => BlocProvider.of(context);

  final currentTheme = getDarkThemeData();

  
}
