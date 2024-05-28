import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedTextBtn extends StatelessWidget {
  const CustomizedTextBtn({
    super.key,
    this.onPressed,
    required this.btnText,
    required this.bkColor,
    this.hasBorderSide = false,
  });
  final Function()? onPressed;
  final String btnText;
  final Color bkColor;
  final bool hasBorderSide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: bkColor,
          elevation: 1,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: hasBorderSide
                  ? BorderSide(width: 2, color: theme.colorScheme.surfaceTint)
                  : BorderSide.none),
        ),
        child: Text(
          btnText,
          style: theme.textTheme.titleMedium,
        ));
  }
}
