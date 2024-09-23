import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/empty_state_ui.dart';
import 'package:chaty/core/widgets/failure_state_ui.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/view/widgets/chats_app_bar.dart';
import 'package:chaty/features/chats/view/widgets/chats_listview.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatList = ChatCubit.get(context).listOfChats;
    return Scaffold(
      appBar: const ChatsAppBar(
        searchHint: "Search for a chat...",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: BlocBuilder<ChatCubit, ChatStates>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Messages",
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                _handleStateResponse(state, chatList),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _displayLinearLoadingBar() {
    return SizedBox(
      height: 10,
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(12),
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        backgroundColor: Colors.grey,
        minHeight: 10,
      ),
    );
  }

  Widget _handleStateResponse(ChatStates state, List chats) {
    if (state is ChatLoadingState) {
      return _displayLinearLoadingBar();
    } else if (state is ChatFailureState) {
      return const FailureStateUI(
        imgPath: AppAssetsManager.emptyInbox,
        text: "Something went wrong, please try again",
      );
    } else if (state is ChatFetchAllChatsState && chats.isEmpty) {
      return const EmptyStateUI(
        imgPath: AppAssetsManager.emptyInbox,
        text: "Currently, your inbox is empty and you don't have any messages",
      );
    } else {
      debugPrint("IS Search Enabled:${state is ChatSearchState}");
      return const ChatsList();
    }
  }
}
