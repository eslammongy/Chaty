import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/view/widgets/chatting_msgs_listview.dart';
import 'package:chaty/features/chats/view/widgets/chatting_msg_placeholder.dart';

class ChattingStateHandler extends StatelessWidget {
  const ChattingStateHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final chatCubit = ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatStates>(
      bloc: ChatCubit.get(context)..handleListenToChatMsgs(),
      listener: (context, state) {
        if (state is ChatFailureState) {
          displayToastMsg(
            context,
            state.errorMsg ?? failureConnectionMsg,
            alignment: Alignment.topCenter,
          );
        }
      },
      builder: (context, state) {
        if (state is ChatLoadingState) {
          return const ChatMessagePlaceholder();
        }
        if (state is ChatFetchChatMsgsState) {
          chatCubit.openedChat?.messages = state.messages;

          return ChattingMsgsListView(msgSource: state.messages);
        } else {
          final messages = ChatCubit.get(context).openedChat?.messages ?? [];
          return ChattingMsgsListView(msgSource: messages);
        }
      },
    );
  }
}
