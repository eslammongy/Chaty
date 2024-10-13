import 'dart:io';

import 'package:chaty/core/errors/exp_enum.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepo {
  Future<Either<ExceptionsType, List<ChatModel>>> fetchAllUserChats();

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchAllChatMessages({
    required String chatId,
  });

  Future<Either<ExceptionsType, MessageModel>> sendNewTextMsg({
    required String chatId,
    required MessageModel msg,
  });

  Future<Either<ExceptionsType, ChatModel>> createNewChatDoc(
      {required ChatModel chat});

  Future<Either<ExceptionsType, String>> uploadChattingImgMsg(
    File imageFile,
    String chatId,
  );
}
