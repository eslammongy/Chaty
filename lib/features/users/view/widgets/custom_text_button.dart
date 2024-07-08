import 'package:flutter/material.dart';

Widget buildTextBtnWidget(BuildContext context,
    {required Function() onPressed,
    required String btnText,
    bool isBtnCancel = false,
    Color? textColor,
    Color? bkColor}) {
  /// define default style for button
  final theme = Theme.of(context);
  final textBtnStyle = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
        side: isBtnCancel
            ? BorderSide(width: 2, color: theme.colorScheme.error)
            : BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(12))),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    backgroundColor: bkColor ?? Colors.transparent,
  );
  return TextButton(
    style: textBtnStyle,
    onPressed: onPressed,
    child: Text(
      btnText,
      style: theme.textTheme.titleSmall?.copyWith(
          color: textColor ?? theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600),
    ),
  );
}
