import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/failure_state_ui.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/chats/view/widgets/send_new_message.dart';
import 'package:chaty/features/chats/view/widgets/messages_listview.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({
    super.key,
  });

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late final ChatCubit chatCubit;
  late ChatModel chat;
  @override
  void initState() {
    super.initState();
    chatCubit = ChatCubit.get(context);
    chat = chatCubit.openedChat!;
    chatCubit.fetchChatMessages(chatId: chat.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        final chatHasMsg = chatCubit.openedChat!.messages ?? [];
        if (state is ChatLoadAllMessagesState) {
          return MessagesListView(
            msgSource: state.messages,
            key: messagesListViewKey,
          );
        } else if (state is ChatFailureState && chatHasMsg.isNotEmpty) {
          return const FailureStateUI(
            imgPath: AppAssetsManager.emptyInbox,
            text:
                "Sorry for the inconvenience. We are working on it, may be your internet connection is poor",
          );
        } else {
          return MessagesListView(
            msgSource: chat.messages ?? [],
            key: messagesListViewKey,
          );
        }
      },
    );
  }
}
