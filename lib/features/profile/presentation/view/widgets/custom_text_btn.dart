import 'package:flutter/material.dart';

class CustomTextBtn extends StatelessWidget {
  const CustomTextBtn({
    super.key,
    required this.text,
    this.onConfirm,
    this.isCancel = false,
  });
  final String text;
  final Function()? onConfirm;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:
            isCancel ? Colors.transparent : theme.colorScheme.primary,
        padding: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
            side: isCancel
                ? BorderSide(width: 2, color: theme.colorScheme.onError)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: theme.textTheme.titleMedium?.copyWith(
            color: isCancel ? theme.colorScheme.error : Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
