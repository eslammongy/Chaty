import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/repo/chat_repo.dart';
import 'package:chaty/core/errors/auth_exceptions_handler.dart';
import 'package:chaty/features/user/data/models/user_model.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';

part 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit({required this.chatRepo}) : super(ChatInitialState());
  final ChatRepo chatRepo;
  static ChatCubit get(context) => BlocProvider.of(context);

  ChatModel? openedChat;
  final List<ChatModel> listOFChats = [];

  /// Use this function to fetch all the user chats so, user can select and open any chat from the list
  Future<void> fetchAllUserChats() async {
    emit(ChatLoadingState());
    listOFChats.clear();
    final fetchingResult = await chatRepo.fetchAllUserChats();
    fetchingResult.fold((exp) {
      final msg = ExceptionHandler.getExpMessage(exp);
      emit(ChatFailureState(errorMsg: msg));
    }, (chats) {
      listOFChats.addAll(chats);
      emit(ChatFetchAllChatsState());
    });
  }

  Future<void> createNewChat({required ChatModel chat}) async {
    final result = await chatRepo.createNewChatDoc(chat: chat);
    result.fold((exp) {
      final msg = ExceptionHandler.getExpMessage(exp);
      emit(ChatFailureState(errorMsg: msg));
    }, (chat) {
      emit(ChatCreatedNewState(chat: chat));
    });
  }

  Future<void> sendNewTextMsg({
    required String chatId,
    required MessageModel msg,
  }) async {
    emit(ChatLoadingMsgState());
    final result = await chatRepo.sendNewTextMsg(chatId: chatId, msg: msg);
    result.fold((exp) {
      final msg = ExceptionHandler.getExpMessage(exp);
      emit(ChatFailureState(errorMsg: msg));
    }, (msg) {
      _handleAddingChatToList(msg);
      emit(ChatSendingMsgState(msg: msg));
    });
  }

  /// Add the new message to the list of messages of the current chat if the chat has no messages yet.
  /// This is used to handle the case when the user sends a new message to a chat that does not contain any messages yet.
  /// If the chat already contains messages, this function does nothing.
  void _handleAddingChatToList(MessageModel msg) {
    if (openedChat!.messages!.isEmpty) {
      openedChat!.messages!.add(msg);
      listOFChats.add(openedChat!);
    }
  }

  Future<void> fetchChatMessages({required String chatId}) async {
    if (isChatExist(chatId) == null) {
      await createNewChat(chat: openedChat!);
    }
    emit(ChatLoadingMsgState());
    List<MessageModel> messages = [];
    chatRepo.fetchAllChatMsgs(chatId: chatId).listen(
      (event) {
        if (event.data() != null && event['messages'] != null) {
          final chatMsgs = event['messages'] as List;

          messages = chatMsgs.reversed.map(
            (e) {
              return MessageModel.fromMap(e);
            },
          ).toList();
        }

        emit(ChatFetchChatMsgsState(messages: messages));
      },
    ).onError((error) {
      final msg = ExceptionHandler.getExpMessage(error);
      emit(ChatFailureState(errorMsg: msg));
    });
  }

  /// check if the generated chatId exist in the list of chats fetched from the cloud firestore or not
  /// if exist return it so we don't have to fetch the again
  /// else return null, in this case may be the chat need to created
  ChatModel? isChatExist(String chatId) {
    try {
      final chat = listOFChats.firstWhere(
        (element) => element.id == chatId,
      );

      return chat;
    } catch (_) {
      return null;
    }
  }

  UserModel? getChatParticipant(BuildContext context, ChatModel chat) {
    final userCubit = UserCubit.get(context);
    if (userCubit.friendsList.isEmpty || chat.participants == null) {
      return null;
    }

    try {
      final participant = userCubit.friendsList.firstWhere(
        (element) {
          if (element.uId == chat.participants?.first) {
            return element.uId == chat.participants?.first;
          } else {
            return element.uId == chat.participants!.last;
          }
        },
      );
      return participant;
    } catch (_) {
      return null;
    }
  }

  Future<void> uploadProfileImage(File imageFile, MessageModel msg) async {
    emit(ChatLoadingMsgState());
    openedChat!.messages?.insert(0, msg);
    final result =
        await chatRepo.uploadChattingImgMsg(imageFile, openedChat?.id ?? '');
    result.fold((error) {
      final msg = ExceptionHandler.getExpMessage(error);
      emit(ChatFailureState(errorMsg: msg));
    }, (downloadUrl) {
      emit(ChatImageMsgUploadedState(imageUrl: downloadUrl));
    });
  }
}
