part of 'chat_cubit.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatLoadingState extends ChatStates {}

class ChatFailureState extends ChatStates {}

class ChatLoadAllFriendsState extends ChatStates {}

class ChatLoadAllChatsState extends ChatStates {}

class ChatLoadAllMessagesState extends ChatStates {}
