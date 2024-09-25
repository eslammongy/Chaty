import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/empty_state_ui.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/user/data/models/user_model.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/user/view/widgets/friends_list_item.dart';

const String emptyChatsResponseMsg =
    "Currently, your friends list is empty and you don't have any friend yet..";

class FriendsListView extends StatelessWidget {
  const FriendsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = UserCubit.get(context);
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
        final friends = getFriends(userCubit);
        if (friends.isEmpty && state is! UserInitialState) {
          return EmptyStateUI(
            imgPath: AppAssetsManager.emptyInbox,
            text: state is UserSearchState
                ? emptySearchResponseMsg
                : emptyChatsResponseMsg, 
          );
        }
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 75.h),
            physics: const BouncingScrollPhysics(),
            itemExtent: 80.h,
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friend = friends[index];
              return FriendsListItem(
                user: friend,
                onTap: () {
                  final userId = userCubit.currentUser.uId;
                  if (userId == null || friend.uId == null) return;
                  _handleNavToChattingScreen(context, userId, friend);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _handleNavToChattingScreen(
    BuildContext context,
    String userId,
    UserModel friend,
  ) {
    final chatId = generateChatId(userId: userId, participantId: friend.uId!);
    final chat = ChatModel(
      id: chatId,
      participants: [userId, friend.uId!],
      messages: [],
      currentRecipient: friend,
    );
    if (context.mounted) _navigateChatScreen(context, chat);
  }

  void _navigateChatScreen(BuildContext context, ChatModel chat) {
    GoRouter.of(context).push(AppRouter.chatScreen, extra: chat);
  }

  List<UserModel> getFriends(UserCubit userCubit) {
    if (userCubit.state is UserSearchState) {
      return userCubit.resultOfSearch;
    } else {
      return userCubit.friendsList;
    }
  }
}
