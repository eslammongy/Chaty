import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.isSender,
  });

  final bool isSender;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 260,
          minWidth: 100,
        ),
        child: TextButton(
          onPressed: () {},
          child: Card(
            color: isSender
                ? theme.colorScheme.primary
                : theme.colorScheme.surface,
            margin: EdgeInsets.zero,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "message message message message message message message"),
            ),
          ),
        ),
      ),
    );
  }
}
