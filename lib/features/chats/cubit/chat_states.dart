part of 'chat_cubit.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatLoadingState extends ChatStates {}

class ChatLoadingMsgState extends ChatStates {}

class ChatCreatedNewState extends ChatStates {
  final ChatModel chat;

  ChatCreatedNewState({required this.chat});
}

class ChatSendingMsgState extends ChatStates {
  final MessageModel msg;

  ChatSendingMsgState({required this.msg});
}

class ChatFailureState extends ChatStates {
  final String? errorMsg;
  ChatFailureState({
    this.errorMsg,
  });
}

class ChatFetchAllChatsState extends ChatStates {}

class ChatFetchChatMsgsState extends ChatStates {
  final List<MessageModel> messages;

  ChatFetchChatMsgsState({required this.messages});
}
