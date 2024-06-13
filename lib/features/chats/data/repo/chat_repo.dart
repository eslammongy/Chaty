import 'package:dartz/dartz.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';

abstract class ChatRepo {
  Future<Either<String, List<ChatModel>>> fetchAllUserChats();

  ///* This function responsible for fetching all the messages of specific chat
  Future<Either<String, List<MessageModel>>> fetchAllChatMsgs({
    required String chatId,
  });
  // Future<void> sendNewTextMsg();
  // Future<void> sendNewImageMsg();
}
