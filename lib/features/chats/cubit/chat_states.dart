part of 'chat_cubit.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatLoadingState extends ChatStates {}

class ChatSendingMsgLoadingState extends ChatStates {}

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

class ChatFetchAllChatsState extends ChatStates {}

class ChatFetchChatMsgsState extends ChatStates {
  final List<MessageModel> messages;

  ChatFetchChatMsgsState({required this.messages});
}

class ChatImageMsgUploadedState extends ChatStates {
  final String imageUrl;

  ChatImageMsgUploadedState({required this.imageUrl});
}

class ChatSearchState extends ChatStates {
  ChatSearchState();
}
