import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';


final class SendNewMessage extends StatelessWidget {
  const SendNewMessage({
    super.key,
    required this.msgController,
  });

  final TextEditingController msgController;

  @override
  Widget build(BuildContext context) {
    final chatCubit = ChatCubit.get(context);
    final userCubit = UserCubit.get(context);
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: CustomTextInputField(
            textEditingController: msgController,
            focusColor: theme.colorScheme.surface,
            fieldRoundedRadius: BorderRadius.circular(20),
            hint: "type something...",
            prefix: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: Card(
                color: theme.colorScheme.primary,
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            suffix: InkWell(
              onTap: () {},
              radius: 8,
              borderRadius: BorderRadius.circular(12),
              child: const Icon(
                FontAwesomeIcons.image,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Card(
            color: theme.colorScheme.primary,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              onTap: () async {
                if (chatCubit.openedChat == null ||
                    chatCubit.openedChat!.participants == null) {
                  return;
                }
                await _sendNewTextMsg(userCubit, chatCubit);
              },
              borderRadius: BorderRadius.circular(100),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _sendNewTextMsg(UserCubit userCubit, ChatCubit chatCubit) async {
    if (chatCubit.openedChat!.id == null) return;

    final chatId = chatCubit.openedChat!.id!;
    final msg = msgModel(userCubit);
    msgController.clear();
    // chatCubit.openedChat?.messages?.add(msg);
    await chatCubit.sendNewTextMsg(chatId: chatId, msg: msg);
  }

  MessageModel msgModel(UserCubit userCubit) {
    return MessageModel(
      text: msgController.text,
      senderId: userCubit.userModel!.uId!,
      dateTime: Timestamp.fromDate(DateTime.now()),
    );
  }
}
