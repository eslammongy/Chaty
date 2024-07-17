import 'package:flutter/material.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/users/data/models/user_model.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/chats/view/widgets/messages_appbar.dart';
import 'package:chaty/features/chats/view/widgets/send_new_message.dart';
import 'package:chaty/features/chats/view/widgets/chatting_state_handler.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key, required this.chat});
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final chatCubit = ChatCubit.get(context);
    final msgController = TextEditingController();
    return Scaffold(
      appBar: MessagesAppBar(
        receiver: chatCubit.getChatParticipant(context, chat) ?? UserModel(),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ChattingStateHandler(),
            SendNewMessage(
              msgController: msgController,
            )
          ],
        ),
      ),
    );
  }
}
