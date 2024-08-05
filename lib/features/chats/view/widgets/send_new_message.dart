import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';

final class SendNewMessage extends StatelessWidget {
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
          final chat = chatCubit.openedChat;
          final msg = MessageModel(
            text: state.imageUrl,
            msgType: MsgType.image,
            senderId: userCubit.userModel!.uId!,
            dateTime: Timestamp.now(),
          );
          if (_checkIsChatCreate(chat)) {
            await chatCubit.sendNewTextMsg(
                chatId: chatCubit.openedChat?.id ?? '', msg: msg);
          } else {
            await chatCubit.createNewChat(chat: chat!).then((_) async {
              await chatCubit.sendNewTextMsg(
                  chatId: chatCubit.openedChat?.id ?? '', msg: msg);
            });
          }
        }
      },
      child: Row(
        children: [
          Expanded(
            child: CustomTextInputField(
              textEditingController: msgController,
              focusColor: theme.colorScheme.surface,
              fieldRoundedRadius: BorderRadius.circular(20),
              hint: "type something...",
              prefix: IconButton(
                onPressed: () async {},
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
                onTap: () async {
                  final image = await pickGalleryImage(context);
                  if (image == null) return;
                  await chatCubit.uploadProfileImage(File(image.path));
                },
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
                  final chat = chatCubit.openedChat;
                  if (_checkIsChatCreate(chat)) {
                    await _sendNewTextMsg(userCubit, chatCubit, msgController);
                  } else {
                    await chatCubit.createNewChat(chat: chat!).then((_) async {
                      await _sendNewTextMsg(
                          userCubit, chatCubit, msgController);
                    });
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
      ),
    );
  }

  Future<void> _sendNewTextMsg(
    UserCubit userCubit,
    ChatCubit chatCubit,
    TextEditingController msgController,
  ) async {
    final msg = MessageModel(
        text: msgController.text,
        senderId: userCubit.userModel!.uId!,
        dateTime: Timestamp.now());
    msgController.clear();
    await chatCubit.sendNewTextMsg(
        chatId: chatCubit.openedChat?.id ?? '', msg: msg);
  }

  bool _checkIsChatCreate(ChatModel? chat) {
    if (chat == null) return false;
    // case the chat is not exist in the collection or does'nt created yet...
    if (chat.messages == null || chat.messages!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
