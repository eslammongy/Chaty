import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.backgroundColor,
      this.textColor,
      required this.text,
      this.width,
      this.onPressed});
  final Color backgroundColor;
  final Color? textColor;
  final String text;
  final void Function()? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 60,
      width: width ?? double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
            boxShadow: defBoxShadows, borderRadius: publicRoundedRadius),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: publicRoundedRadius)),
          child: Text(
            text,
            style: theme.textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
