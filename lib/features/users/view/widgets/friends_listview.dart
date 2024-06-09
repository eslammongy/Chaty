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
    final chatCubit = ChatCubit.get(context);
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 75.h),
            physics: const BouncingScrollPhysics(),
            itemExtent: 80.h,
            itemCount: userCubit.friendsList.length,
            itemBuilder: (context, index) {
              final myFriend = userCubit.friendsList[index];
              return InkWell(
                onTap: () {
                  final userId = userCubit.userModel?.uId;
                  if (userId == null || myFriend.uId == null) return;
                  final chatId =
                      generateChatId(id1: userId, id2: myFriend.uId!);
                  final chatModel = chatCubit.isChatExist(chatId);
                  if (chatModel == null) {
                    chatCubit.listOFMsgs.clear();
                    final chatModel = ChatModel(
                        id: chatId, participants: [userId, myFriend.uId]);
                    GoRouter.of(context)
                        .push(AppRouter.chatScreen, extra: chatModel);
                  } else {
                    GoRouter.of(context).push(AppRouter.chatScreen,
                        extra: chatCubit.openedChat);
                  }
                },
                child: FriendsListItem(
                  user: myFriend,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
