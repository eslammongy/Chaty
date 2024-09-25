import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/empty_state_ui.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/chats/view/widgets/chat_list_item.dart';

const String emptyChatsResponseMsg =
    "Currently, your inbox is empty and you don't have any messages";

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
        if (chats.isEmpty && state is! ChatInitialState) {
          return EmptyStateUI(
            imgPath: AppAssetsManager.emptyInbox,
            text: state is ChatSearchState
                ? emptySearchResponseMsg
                : emptyChatsResponseMsg,
          );
        }
        return Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemExtent: 90.h,
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                GoRouter.of(context).push(
                  AppRouter.chatScreen,
                  extra: chats[index],
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
