import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/users/view/widgets/friends_list_item.dart';

class FriendsListView extends StatelessWidget {
  const FriendsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = UserCubit.get(context);
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 75.h),
            physics: const BouncingScrollPhysics(),
            itemExtent: 80.h,
            itemCount: userCubit.friendsList.length,
            itemBuilder: (context, index) {
              final friend = userCubit.friendsList[index];
              return FriendsListItem(
                user: friend,
                onTap: () {
                  final userId = userCubit.userModel?.uId;
                  if (userId == null || friend.uId == null) return;
                  _handleNavToChattingScreen(context, userId, friend.uId!);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _handleNavToChattingScreen(
      BuildContext context, String userId, String friendId) async {
    final chatCubit = ChatCubit.get(context);
    final chatId = generateChatId(userId: userId, participantId: friendId);
    final chatModel = chatCubit.isChatExist(chatId);

    // in this case the chat collection for this friend does'nt created yet...
    if (chatModel.id == null) {
      debugPrint("Chat Model MSG: $chatId");
      chatCubit.openedChat = ChatModel(
        id: chatId,
        participants: [userId, friendId],
      );
      await chatCubit.createNewChat(chat: chatCubit.openedChat!);
    } else {
      chatCubit.openedChat = chatModel;
    }
    Future(() => _navigateChatScreen(context, chatCubit));
  }

  void _navigateChatScreen(BuildContext context, ChatCubit chatCubit) {
    GoRouter.of(context)
        .push(AppRouter.chatScreen, extra: chatCubit.openedChat);
  }
}
