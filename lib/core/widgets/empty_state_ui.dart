import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyStateUI extends StatelessWidget {
  const EmptyStateUI({
    super.key,
    required this.imgPath,
    required this.text,
  });

  final String imgPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
        child: Center(
            child: Column(
      children: [
        SvgPicture.asset(
          imgPath,
          width: 300.w,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    )));
  }
}
