import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/view/widgets/chatting_msgs_listview.dart';
import 'package:chaty/features/chats/view/widgets/chatting_msg_placeholder.dart';

const failureMsg =
    "Sorry for the inconvenience. We are working on it, may be your internet connection is poor";

class ChattingStateHandler extends StatelessWidget {
  const ChattingStateHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = ChatCubit.get(context).openedChat;

    return BlocConsumer<ChatCubit, ChatStates>(
      bloc: ChatCubit.get(context)..fetchChatMessages(chatId: chat?.id ?? ''),
      listener: (context, state) {
        if (state is ChatFailureState) {
          displayToastMsg(context, state.errorMsg ?? failureMsg,
              alignment: Alignment.topCenter);
        }
      },
      builder: (context, state) {
        debugPrint('ChattingStateHandler: $state');
        if (state is ChatLoadingState) {
          return const ChatMessagePlaceholder();
        }
        if (state is ChatFetchChatMsgsState) {
          chat?.messages = state.messages;
          return ChattingMsgsListView(msgSource: state.messages);
        } else {
          final messages = ChatCubit.get(context).openedChat?.messages ?? [];
          return ChattingMsgsListView(msgSource: messages);
        }
      },
    );
  }
}
