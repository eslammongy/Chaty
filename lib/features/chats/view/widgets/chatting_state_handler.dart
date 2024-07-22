import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/loading_state_ui.dart';
import 'package:chaty/core/widgets/failure_state_ui.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/view/widgets/send_new_message.dart';
import 'package:chaty/features/chats/view/widgets/messages_listview.dart';

class ChattingStateHandler extends StatelessWidget {
  const ChattingStateHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        final chatMsg = [];
        if (state is ChatLoadingState) {
          return const LoadingStateUI(
            text: "fetching messages...",
          );
        } else if (state is ChatFailureState && chatMsg.isNotEmpty) {
          return const FailureStateUI(
            imgPath: AppAssetsManager.emptyInbox,
            text:
                "Sorry for the inconvenience. We are working on it, may be your internet connection is poor",
          );
        } else {
          return MessagesListView(
            key: messagesListViewKey,
          );
        }
      },
    );
  }
}
