import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/repo/chat_repo.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';

class ChatRepoImpl extends ChatRepo {
  final chats = FirebaseFirestore.instance.collection("chats");
  @override
  Future<Either<String, List<ChatModel>>> fetchAllUserChats() async {
    try {
      final userChats = await chats.get();
      final listOfChats =
          userChats.docs.map((item) => ChatModel.fromMap(item.data())).toList();
      return right(listOfChats);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MessageModel>>> fetchAllChatMsgs({
    required String chatId,
  }) async {
    try {
      final chatRes = await chats.doc(chatId).get();
      final chatModel = chatRes.data() ?? {};
      if (chatModel['messages'] == null) return right([]);
      final listOfMsgs = chatModel['messages']
          .map((item) => MessageModel.fromMap(item.data()))
          .toList();
      return right(listOfMsgs);
    } catch (e) {
      return left(e.toString());
    }
  }
}
