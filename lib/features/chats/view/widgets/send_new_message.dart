import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/services/fcm_services.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/chats/view/widgets/msg_type_builder.dart';

class SendNewMessage extends StatelessWidget {
  const SendNewMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final msgController = TextEditingController();
    final chatCubit = ChatCubit.get(context);
    final userCubit = UserCubit.get(context);
    final theme = Theme.of(context);

    return BlocListener<ChatCubit, ChatStates>(
      listener: (context, state) async {
        if (state is ChatImageMsgUploadedState) {
          await _sendImageMsg(chatCubit, state, userCubit);
        }
        if (state is ChatSendingMsgState) {
          await _sendMsgNotification(chatCubit, userCubit, state.msg);
        }
      },
      child: Row(
        children: [
          MsgTypeBuilder(msgController: msgController),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Card(
              color: theme.colorScheme.primary,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: InkWell(
                onTap: () async {
                  await _sendNewTextMsg(userCubit, chatCubit, msgController);
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
      ),
    );
  }

  Future<void> _sendImageMsg(
    ChatCubit chatCubit,
    ChatImageMsgUploadedState state,
    UserCubit userCubit,
  ) async {
    final msg = MessageModel.buildMsg(
      state.imageUrl,
      userCubit.user!.uId!,
      type: MsgType.image,
    );
    await chatCubit.sendNewTextMsg(chatId: chatCubit.openedChat!.id!, msg: msg);
  }

  Future<void> _sendNewTextMsg(
    UserCubit userCubit,
    ChatCubit chatCubit,
    TextEditingController msgController,
  ) async {
    final msg = MessageModel.buildMsg(
      msgController.text,
      userCubit.user!.uId!,
    );
    msgController.clear();
    await chatCubit.sendNewTextMsg(chatId: chatCubit.openedChat!.id!, msg: msg);
  }

  Future<void> _sendMsgNotification(
      ChatCubit chatCubit, UserCubit userCubit, MessageModel msg) async {
    final chat = chatCubit.openedChat;
    final userName = userCubit.user!.name ?? '';
    if (chat == null || chat.participants == null) {
      return;
    }
    final recipient = chat.participants!.last;
    await FCMService.sendNotifications(
      sender: userName,
      msg: msg.text!,
      recipientToken: recipient,
    );
  }
}
