import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/empty_state_ui.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/view/widgets/chat_list_item.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatCubit = ChatCubit.get(context);
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        final chats = chatCubit.listOFChats;
        if (state is! ChatLoadingState && chats.isEmpty) {
          return const EmptyStateUI(
            imgPath: AppAssetsManager.emptyInbox,
            text:
                "Currently, your inbox is empty and you don't have any messages",
          );
        }

        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 75.h),
            physics: const BouncingScrollPhysics(),
            itemExtent: 90.h,
            itemCount: chats.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  chatCubit.openedChat = chats[index];
                  _setCachedMessages(chatCubit);
                  GoRouter.of(context)
                      .push(AppRouter.chatScreen, extra: chats[index]);
                },
                child: ChatListItem(
                  chat: chats[index],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _setCachedMessages(ChatCubit chatCubit) {
    if (chatCubit.openedChat!.messages != null &&
        chatCubit.openedChat!.messages!.isNotEmpty) {
      chatCubit.listOFMsgs.addAll(chatCubit.openedChat!.messages!);
    }
  }
}
