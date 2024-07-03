import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/view/widgets/chats_app_bar.dart';
import 'package:chaty/features/chats/view/widgets/chats_listview.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) async {
        debugPrint("****Current UserCubit State : $state");
        if (state is UserLoadingState) {
          showLoadingDialog(context, text: "loading your info...");
        }
        if (state is UserLoadAllFriendsState) {
          await ChatCubit.get(context).fetchAllUserChats();
        }
        if (state is UserFailureState) {
          Future(() {
            _closeLoadingIndicator(context);
            displayToastMsg(context, state.errorMsg);
          });
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChatsAppBar(
                searchHint: "Search for a chat...",
              ),
              Text(
                "Messages",
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              BlocListener<ChatCubit, ChatStates>(
                listenWhen: (previous, current) {
                  if (isAllChatsLoaded(previous, current)) {
                    _closeLoadingIndicator(context);
                  }
                  return previous != current;
                },
                listener: (context, state) {
                  if (state is ChatLoadingState) {
                    showLoadingDialog(context, text: "loading your chats...");
                  }
                },
                child: const ChatsList(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// close loading dialog
  void _closeLoadingIndicator(BuildContext context) {
    GoRouter.of(context).pop();
  }

  bool isAllChatsLoaded(ChatStates previous, ChatStates current) {
    return previous is ChatLoadingState && current is ChatLoadAllChatsState;
  }
}
