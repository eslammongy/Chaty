import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final settingsCubit = SettingsCubit.get(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            getDateTime(msg.dateTime ?? DateTime.now()),
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.surfaceTint),
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
            child: TextButton(
              onPressed: () {},
              child: Card(
                color: isCurUserMsgSender(msg.senderId)
                    ? settingsCubit.msgBkColor
                    : theme.colorScheme.surface,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpendableTextWidget(
                    expendedText: msg.text ?? "",
                    textColor: settingsCubit.isLight &&
                            !isCurUserMsgSender(msg.senderId)
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getDateTime(DateTime dateTime) {
    final formattedDate = DateFormat.yMMMEd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);
    return "$formattedDate  $formattedTime";
  }

  bool isCurUserMsgSender(String? userId) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == userId) return true;
    return false;
  }
}
