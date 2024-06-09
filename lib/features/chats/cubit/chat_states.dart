part of 'chat_cubit.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatLoadingState extends ChatStates {}

class ChatLoadingMsgState extends ChatStates {}

class ChatCreatedState extends ChatStates {
  final ChatModel chat;

  ChatCreatedState({required this.chat});
}

class ChatMsgSendedState extends ChatStates {
  final MessageModel msg;

  ChatMsgSendedState({required this.msg});
}

class ChatFailureState extends ChatStates {
  final String? errorMsg;
  ChatFailureState({
    this.errorMsg,
  });
}

class ChatLoadAllChatsState extends ChatStates {}

class ChatLoadAllMessagesState extends ChatStates {}
