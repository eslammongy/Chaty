import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/repo/chat_repo.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';

class ChatRepoImpl extends ChatRepo {
  final chats = FirebaseFirestore.instance.collection("chats");
  @override
  Future<Either<Exception, List<ChatModel>>> fetchAllUserChats() async {
    try {
      final userChats = await chats.get();
      final listOfChats =
          userChats.docs.map((item) => ChatModel.fromMap(item.data())).toList();
      return right(listOfChats);
    } on FirebaseException catch (ex) {
      return left(ex);
    } catch (e) {
      return left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, List<MessageModel>>> fetchAllChatMsgs({
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
    } on FirebaseException catch (ex) {
      return left(ex);
    } catch (e) {
      return left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, MessageModel>> sendNewTextMsg({
    required String chatId,
    required MessageModel msg,
  }) async {
    try {
      await chats.doc(chatId).set(msg.toMap());
      return right(msg);
    } on FirebaseException catch (ex) {
      return left(ex);
    } catch (e) {
      return left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, ChatModel>> createNewChatDoc(
      {required ChatModel chat}) async {
    try {
      await chats.add(chat.toMap());
      return right(chat);
    } on FirebaseException catch (ex) {
      return left(ex);
    } catch (e) {
      return left(e as Exception);
    }
  }
}
