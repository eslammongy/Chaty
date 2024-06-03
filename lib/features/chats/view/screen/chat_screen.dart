import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/users/data/models/user_model.dart';
import 'package:chaty/features/chats/view/widgets/messages_appbar.dart';
import 'package:chaty/features/chats/view/widgets/send_new_message.dart';
import 'package:chaty/features/chats/view/widgets/messages_listview.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.receiver});
  final UserModel receiver;

  @override
  Widget build(BuildContext context) {
    final msgController = TextEditingController();
    return Scaffold(
      appBar: MessagesAppBar(
        receiver: receiver,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
        child: Column(
          children: [
            const MessagesListView(),
            const SizedBox(
              height: 5,
            ),
            SendNewMessage(msgController: msgController, receiver: receiver)
          ],
        ),
      ),
    );
  }
}
