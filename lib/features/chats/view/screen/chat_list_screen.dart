import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/empty_state_ui.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/view/widgets/chats_app_bar.dart';
import 'package:chaty/features/chats/view/widgets/chats_listview.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatCubit = ChatCubit.get(context);
    return Scaffold(
        appBar: const ChatsAppBar(
          searchHint: "Search for a chat...",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Messages",
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              BlocConsumer<ChatCubit, ChatStates>(
                listenWhen: (previous, current) {
                  if (previous is ChatLoadingState &&
                      current is ChatLoadAllChatsState) {
                    //* close loading dialog
                    GoRouter.of(context).pop();
                  }
                  return previous != current;
                },
                listener: (context, state) {
                  if (state is ChatLoadingState) {
                    showLoadingDialog(context);
                  }
                },
                builder: (context, state) {
                  if (chatCubit.listOFChats.isNotEmpty) {
                    return const EmptyStateUI(
                      imgPath: AppAssetsManager.emptyInbox,
                      text:
                          "Currently, your inbox is empty and you don't have any messages",
                    );
                  }
                  return ChatsList(
                    listOFChats: chatCubit.listOFChats,
                  );
                },
              )
            ],
          ),
        ));
  }
}
