import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
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
      final setOfChatIds = <String>{};
      final userChats = await chatCollection
          .where('participants', arrayContains: userID)
          .orderBy('__name__')
          .get();
      for (var element in userChats.docs) {
        debugPrint("Chat Repo: $element");
        final chat = element.data();
        if (setOfChatIds.contains(chat['id'])) continue;
        if (chat['messages'] != null && chat['messages'].isNotEmpty) {
          setOfChatIds.add(chat['id']);
          listOfChats.add(ChatModel.fromMap(chat));
        } else {
          continue;
        }
      }
      return right(listOfChats);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchAllChatMsgs({
    required String chatId,
  }) {
    return chatCollection.doc(chatId).snapshots();
  }

  @override
  Future<Either<Exception, MessageModel>> sendNewTextMsg({
    required String chatId,
    required MessageModel msg,
  }) async {
    try {
      await chatCollection.doc(chatId).collection('messages').add(msg.toMap());
      return right(msg);
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
      debugPrint("Chat Repo Success: $chat");
      return right(chat);
    } on Exception catch (e) {
      debugPrint("Chat Repo Error: $e");
      return left(e);
    }
  }
}
