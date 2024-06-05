import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
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
      debugPrint("List of Chats : $listOfChats");
      return right(listOfChats);
    } on FirebaseException catch (ex) {
      return left(ex);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<MessageModel>>> fetchAllChatMsgs({
    required String chatId,
  }) async {
    try {
      final messages = <MessageModel>[];
      final chatRes = await chats.doc(chatId).get();
      final chatModel = chatRes.data() ?? {};
      if (chatModel['messages'] == null) return right([]);
      final List chatMessages = chatModel['messages'];
      for (var element in chatMessages) {
        messages.add(MessageModel.fromMap(element));
      }

      return right(messages);
    } on FirebaseException catch (ex) {
      return left(ex);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, MessageModel>> sendNewTextMsg({
    required String chatId,
    required MessageModel msg,
  }) async {
    try {
      await chats.doc(chatId).update({
        'messages': FieldValue.arrayUnion([msg.toMap()])
      });
      return right(msg);
    } on FirebaseException catch (ex) {
      return left(ex);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, ChatModel>> createNewChatDoc({
    required ChatModel chat,
  }) async {
    try {
      await chats.doc(chat.id).set(chat.toMap());
      return right(chat);
    } on FirebaseException catch (ex) {
      return left(ex);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
