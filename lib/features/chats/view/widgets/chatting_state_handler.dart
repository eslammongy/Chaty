import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/failure_state_ui.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/view/widgets/chatting_msgs_listview.dart';
import 'package:chaty/features/chats/view/widgets/chatting_msg_placeholder.dart';

class ChattingStateHandler extends StatelessWidget {
  const ChattingStateHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      bloc: ChatCubit.get(context)..initializeChatting(),
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ChatLoadingState) {
          return const ChatMessagePlaceholder();
        } else if (state is ChatFailureState) {
          return const FailureStateUI(
            imgPath: AppAssetsManager.emptyInbox,
            text:
                "Sorry for the inconvenience. We are working on it, may be your internet connection is poor",
          );
        } else {
          return const ChatMessagePlaceholder();
        }
      },
    );
  }
}
