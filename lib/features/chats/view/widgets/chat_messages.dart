import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/view/widgets/messages_listview.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key, });

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late final ChatCubit chatCubit;
  @override
  void initState() {
    super.initState();
    // Fetch chat messages when the screen is initialized
    chatCubit = ChatCubit.get(context);
    chatCubit.fetchChatMessages(chatId: chatCubit.openedChat!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        if (state is ChatLoadingMsgState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatLoadAllMessagesState) {
          return MessagesListView(msgSource: state.messages);
        } else if (state is ChatFailureState) {
          return Center(child: Text('Error: ${state.errorMsg.toString()}'));
        }
        return const Center(child: Text('No messages'));
      },
    );
  }
}
