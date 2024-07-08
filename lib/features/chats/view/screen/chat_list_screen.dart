import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/loading_state_ui.dart';
import 'package:chaty/core/widgets/failure_state_ui.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/view/widgets/chats_app_bar.dart';
import 'package:chaty/features/chats/view/widgets/chats_listview.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const ChatsAppBar(
        searchHint: "Search for a chat...",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: BlocBuilder<ChatCubit, ChatStates>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Messages",
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                _handleStatePresented(theme, state)
              ],
            );
          },
        ),
      ),
    );
  }

  /// close loading dialog
  void _closeLoadingIndicator(BuildContext context) =>
      GoRouter.of(context).pop();

  _handleStatePresented(ThemeData theme, ChatStates state) {
    if (state is ChatFailureState) {
      return const LoadingStateUI(
        text: 'loading chats...',
      );
    } else if (state is ChatFailureState) {
      return const FailureStateUI(
        imgPath: AppAssetsManager.emptyInbox,
        text: "Something went wrong, please try again",
      );
    } else {
      return const ChatsList();
    }
  }

  bool isAllChatsLoaded(ChatStates previous, ChatStates current) {
    return previous is ChatLoadingState && current is ChatLoadAllChatsState;
  }
}
