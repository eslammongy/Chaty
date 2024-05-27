import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());
  static ChatCubit get(context) => BlocProvider.of(context);
}
