import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/users/data/models/user_model.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';

class SendNewMessage extends StatelessWidget {
  const SendNewMessage({
    super.key,
    required this.msgController,
    required this.receiver,
  });

  final TextEditingController msgController;
  final UserModel receiver;

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
                if (userCubit.userModel?.uId != null && receiver.uId != null) {
                  final chatId = generateChatId(
                      id1: userCubit.userModel!.uId!, id2: receiver.uId!);
                  final msg = MessageModel(
                    text: msgController.text,
                    senderId: userCubit.userModel!.uId!,
                    dateTime: Timestamp.fromDate(DateTime.now()),
                  );
                  if (chatCubit.isChatExist(chatId) == null) {
                    await chatCubit.createNewChat(
                        chat: ChatModel(id: chatId, participants: [
                      userCubit.userModel!.uId!,
                      receiver.uId!
                    ], messages: []));
                  }
                  await chatCubit.sendNewTextMsg(chatId: chatId, msg: msg);
                }
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
}
