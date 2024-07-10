import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/chats/view/widgets/messages_listview.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({
    super.key,
  });

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late final ChatCubit chatCubit;
  late ChatModel chat;
  @override
  void initState() {
    super.initState();
    chatCubit = ChatCubit.get(context);
    chat = chatCubit.openedChat!;
    chatCubit.fetchChatMessages(chatId: chat.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        debugPrint("ChatCubit: $state");

        if (state is ChatLoadingMsgState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatLoadAllMessagesState ||
            state is ChatMsgSendedState) {
          return MessagesListView(msgSource: chat.messages ?? []);
        } else if (state is ChatFailureState) {
          return Center(child: Text('Error: ${state.errorMsg.toString()}'));
        }
        return const Center(child: Text('No messages'));
      },
    );
  }
}
