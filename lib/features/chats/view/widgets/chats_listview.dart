import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
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
        final chats = getChats(chatCubit);
        return Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemExtent: 90.h,
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                chatCubit.openedChat = chats[index];
                GoRouter.of(context).push(
                  AppRouter.chatScreen,
                  extra: chatCubit.openedChat,
                );
              },
              child: ChatListItem(
                chat: chats[index],
              ),
            );
          },
        ));
      },
    );
  }

  List<ChatModel> getChats(ChatCubit chatCubit) {
    if (chatCubit.state is ChatSearchState) {
      return chatCubit.resultOfSearch;
    } else {
      return chatCubit.listOfChats;
    }
  }
}
