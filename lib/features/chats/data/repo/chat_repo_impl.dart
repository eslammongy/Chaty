import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:chaty/core/errors/exp_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/repo/chat_repo.dart';
import 'package:chaty/core/errors/auth_exceptions_handler.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';

class ChatRepoImpl extends ChatRepo {
  final chatCollection = FirebaseFirestore.instance.collection("chats");

  @override
  Future<Either<ExceptionsType, ChatModel>> createNewChatDoc({
    required ChatModel chat,
  }) async {
    try {
      await chatCollection.doc(chat.id).set(chat.toMap());
      return right(chat);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ExceptionHandler.handleException(error.code));
      }
      return left(ExceptionHandler.handleException(error));
    }
  }

  @override
  Future<Either<ExceptionsType, List<ChatModel>>> fetchAllUserChats() async {
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
          chat['messages'] = messages.reversed;
          listOfChats.add(ChatModel.fromMap(chat));
        } else {
          continue;
        }
      }

      return right(listOfChats);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ExceptionHandler.handleException(error.code));
      }
      return left(ExceptionHandler.handleException(error));
    }
  }

  @override
  Future<Either<ExceptionsType, MessageModel>> sendNewTextMsg({
    required String chatId,
    required MessageModel msg,
  }) async {
    try {
      await chatCollection.doc(chatId).update({
        'messages': FieldValue.arrayUnion([msg.toMap()])
      });
      return right(msg);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ExceptionHandler.handleException(error.code));
      }
      return left(ExceptionHandler.handleException(error));
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchAllChatMsgs({
    required String chatId,
  }) {
    return chatCollection.doc(chatId).snapshots();
  }

  @override
  Future<Either<ExceptionsType, String>> uploadChattingImgMsg(
    File imageFile,
    String chatId,
  ) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('chats/$chatId/$imageFile');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return right(imageUrl);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ExceptionHandler.handleException(error.code));
      }
      return left(ExceptionHandler.handleException(error));
    }
  }
}
