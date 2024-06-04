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
                  chatCubit.extractChatMsgs(chatId: chats[index].id ?? "");
                  GoRouter.of(context).push(AppRouter.chatScreen,
                      extra: chatCubit.listOFChats[index]);
                },
                child: ChatListItem(
                  chat: chatCubit.listOFChats[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
