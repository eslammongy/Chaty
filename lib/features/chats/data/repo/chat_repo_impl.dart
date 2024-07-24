import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/repo/chat_repo.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';

class ChatRepoImpl extends ChatRepo {
  final chatCollection = FirebaseFirestore.instance.collection("chats");

  @override
  Future<Either<Exception, ChatModel>> createNewChatDoc({
    required ChatModel chat,
  }) async {
    try {
      await chatCollection.doc(chat.id).set(chat.toMap());
      return right(chat);
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }

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
          final messages = chat['messages'] as List;
          chat['messages'] = messages.reversed.toList();
          listOfChats.add(ChatModel.fromMap(chat));
        } else {
          continue;
        }
      }
      return right(listOfChats);
    } catch (e) {
      return left(Exception(e.toString()));
    }
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
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchAllChatMsgs({
    required String chatId,
  }) {
    return chatCollection.doc(chatId).snapshots();
  }
}
