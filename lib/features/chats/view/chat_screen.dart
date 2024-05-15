import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/features/chats/view/widgets/messages_appbar.dart';
import 'package:flutter_firebase/features/chats/view/widgets/send_new_message.dart';
import 'package:flutter_firebase/features/chats/view/widgets/messages_listview.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final msgController = TextEditingController();
    return Scaffold(
      appBar: const MessagesAppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
        child: Column(
          children: [
            const MessagesListView(),
            const SizedBox(
              height: 5,
            ),
            SendNewMessage(msgController: msgController, theme: theme)
          ],
        ),
      ),
    );
  }
}
