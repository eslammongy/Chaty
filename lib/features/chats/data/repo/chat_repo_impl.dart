import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/repo/chat_repo.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';

class ChatRepoImpl extends ChatRepo {
  final chatCollection = FirebaseFirestore.instance.collection("chats");
  @override
  Future<Either<Exception, List<ChatModel>>> fetchAllUserChats() async {
    try {
      final userID = FirebaseAuth.instance.currentUser?.uid;
      final listOfChats = <ChatModel>[];
      final userChats = await chatCollection
          .where('participants', arrayContains: userID)
          .orderBy('__name__')
          .get();
      for (var element in userChats.docs) {
        final chat = element.data();
        if (chat['messages'] != null && chat['messages'].isNotEmpty) {
          listOfChats.add(ChatModel.fromMap(chat));
        } else {
          continue;
        }
      }
      return right(listOfChats);
    } on FirebaseException catch (ex) {
      return left(ex);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Stream<Either<dynamic, List<MessageModel>>> fetchAllChatMsgs({
    required String chatId,
  }) {
    List<MessageModel> messages = [];
    return chatCollection.doc(chatId).snapshots().map(
      (event) {
        debugPrint("Receive an event happened : ${event['messages'].last}");
        if (event.data() != null && event['messages'] != null) {
          final List chatMessages = event['messages'];
          for (var element in chatMessages) {
            messages.add(MessageModel.fromMap(element));
          }
          return right(messages);
        }
        return right(messages);
      },
    ).handleError((error) {
      if (error is FirebaseException) {
        return left(error);
      } else {
        return left(error);
      }
    });
  }

  @override
  Future<Either<Exception, MessageModel>> sendNewTextMsg({
    required String chatId,
    required MessageModel msg,
  }) async {
    try {
      await chatCollection.doc(chatId).update({
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
      await chatCollection.doc(chat.id).set(chat.toMap());
      return right(chat);
    } on FirebaseException catch (ex) {
      return left(ex);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
