import 'package:flutter_bloc/flutter_bloc.dart';
part 'settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());
  static SettingsCubit get(context) => BlocProvider.of(context);
}
