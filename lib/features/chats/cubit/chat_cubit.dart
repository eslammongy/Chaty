import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/repo/chat_repo.dart';
import 'package:chaty/features/users/data/models/user_model.dart';
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
    final fetchingResult = await chatRepo.fetchAllUserChats();
    fetchingResult.fold((exp) {
      if (exp is FirebaseException) {
        emit(ChatFailureState(errorMsg: exp.message));
      }
      emit(ChatFailureState(errorMsg: exp.toString()));
    }, (chats) {
      listOFChats.clear();
      listOFChats.addAll(chats);
      emit(ChatLoadAllChatsState());
    });
  }

  Future<void> createNewChat({required ChatModel chat}) async {
    emit(ChatLoadingState());
    final result = await chatRepo.createNewChatDoc(chat: chat);
    result.fold((exp) {
      if (exp is FirebaseException) {
        emit(ChatFailureState(errorMsg: exp.message));
      }
      emit(ChatFailureState(errorMsg: exp.toString()));
    }, (chat) {
      emit(ChatCreatedState(chat: chat));
    });
  }

  Future<void> sendNewTextMsg({
    required String chatId,
    required MessageModel msg,
  }) async {
    emit(ChatLoadingMsgState());
    final result = await chatRepo.sendNewTextMsg(chatId: chatId, msg: msg);
    result.fold((exp) {
      if (exp is FirebaseException) {
        emit(ChatFailureState(errorMsg: exp.message));
      }
      emit(ChatFailureState(errorMsg: exp.toString()));
    }, (msg) {
      debugPrint("sendNewTextMsg: $msg");
      emit(ChatMsgSendedState(msg: msg));
    });
  }

  Future<void> fetchChatMessages({required String chatId}) async {
    emit(ChatLoadingMsgState());

    chatRepo.fetchAllChatMsgs(chatId: chatId).listen(
      (event) {
        event.fold(
          (error) => emit(ChatFailureState(errorMsg: error.toString(error))),
          (messages) => emit(ChatLoadAllMessagesState(messages: messages)),
        );
      },
    );
  }

  /// check if the generated chatId exist in the list of chats fetched from the cloud firestore or not
  /// if exist return it so we don't have to fetch the again
  /// else return null, in this case may be the chat need to created
  ChatModel isChatExist(String chatId) {
    return listOFChats.firstWhere(
      (element) => element.id == chatId,
      orElse: () => ChatModel(),
    );
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
}
