import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/core/widgets/placeholder_img_msg.dart';
import 'package:chaty/core/widgets/cache_network_msg_img.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/settings/cubit/settings_cubit.dart';
import 'package:chaty/features/chats/view/widgets/expandable_text.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.msg,
  });

  final MessageModel msg;

  @override
  Widget build(BuildContext context) {
    final state = ChatCubit.get(context).state;
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            getDateTime(msg.dateTime!.toDate()),
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.surfaceTint),
          ),
        ),
        Row(
          mainAxisAlignment: isCurUserMsgSender(msg.senderId)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: state is ChatFailureState,
              child: Icon(
                Icons.info,
                color: theme.colorScheme.error,
              ),
            ),
            Align(
              alignment: isCurUserMsgSender(msg.senderId)
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 260,
                  minWidth: 100,
                ),
                child: buildMsgLayout(msg.msgType, context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _networkImgMsg() {
    return CacheNetworkMsgImg(
      imgUrl: msg.text ?? "",
      radius: 12,
    );
  }

  Widget _textMsgLayout(BuildContext context) {
    final settingsCubit = SettingsCubit.get(context);
    final theme = Theme.of(context);

    return Card(
      color: isCurUserMsgSender(msg.senderId)
          ? settingsCubit.msgBkColor
          : theme.colorScheme.surface,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpendableTextWidget(
          expendedText: msg.text ?? "",
          textColor: settingsCubit.isLight && !isCurUserMsgSender(msg.senderId)
              ? Colors.black
              : Colors.white,
        ),
      ),
    );
  }

  Widget _buildFileMsgLayout() {
    return const Opacity(
      opacity: 0.4,
      child: PlaceholderImgMsg(
        type: PlaceholderType.file,
      ),
    );
  }

  buildMsgLayout(
    MsgType type,
    BuildContext context,
  ) {
    switch (type) {
      case MsgType.image:
        return _networkImgMsg();
      case MsgType.file:
        return _buildFileMsgLayout();
      default:
        return _textMsgLayout(context);
    }
  }

  bool isCurUserMsgSender(String? senderId) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == senderId) return true;
    return false;
  }
}
