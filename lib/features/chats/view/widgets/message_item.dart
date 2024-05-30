import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:chaty/features/chats/data/message.dart';
import 'package:chaty/features/chats/view/widgets/expandable_text.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.msg,
  });

  final MessageModel msg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            getDateTime(msg.dateTime),
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.surfaceTint),
          ),
        ),
        Align(
          alignment: msg.isSenderMsg ? Alignment.topRight : Alignment.topLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 260,
              minWidth: 100,
            ),
            child: TextButton(
              onPressed: () {},
              child: Card(
                color: msg.isSenderMsg
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpendableTextWidget(
                    expendedText: msg.text,
                    textColor: msg.isSenderMsg ? Colors.white : Colors.black,
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
}
