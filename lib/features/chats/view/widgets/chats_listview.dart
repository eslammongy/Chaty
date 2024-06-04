import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/chats/view/widgets/chat_list_item.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({
    super.key, required this.listOFChats,
  });
  final List<ChatModel> listOFChats;

  @override
  Widget build(BuildContext context) {
    final chatCubit = ChatCubit.get(context);
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 75.h),
        physics: const BouncingScrollPhysics(),
        itemExtent: 90.h,
        itemCount: chatCubit.listOFChats.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              GoRouter.of(context).push(AppRouter.chatScreen);
            },
            child: const ChatListItem(),
          );
        },
      ),
    );
  }
}
