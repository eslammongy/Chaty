import 'package:dartz/dartz.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';

abstract class ChatRepo {
  Future<Either<Exception, List<ChatModel>>> fetchAllUserChats();

  /// This function responsible for fetching all the messages of specific chat
   Stream<Either<dynamic, List<MessageModel>>>  fetchAllChatMsgs({
    required String chatId,
  });

  Future<Either<Exception, MessageModel>> sendNewTextMsg({
    required String chatId,
    required MessageModel msg,
  });

  Future<Either<Exception, ChatModel>> createNewChatDoc(
      {required ChatModel chat});
}
