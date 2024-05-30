import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/settings/cubit/settings_cubit.dart';

class ExpendableTextWidget extends StatefulWidget {
  final String expendedText;
  final Color textColor;
  const ExpendableTextWidget(
      {super.key, required this.expendedText, required this.textColor});

  @override
  State<ExpendableTextWidget> createState() => _ExpendableTextWidgetState();
}

class _ExpendableTextWidgetState extends State<ExpendableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textLength = 80.h;

  @override
  Widget build(BuildContext context) {
    final settingsCubit = SettingsCubit.get(context);
    final theme = Theme.of(context);

    setExpandedTestLen();
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              maxLines: 3,
              style: msgTextFont(theme, settingsCubit.msgFont),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hiddenText ? ('$firstHalf...') : (firstHalf + secondHalf),
                  style: msgTextFont(theme, settingsCubit.msgFont),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        hiddenText ? 'Read More..' : 'Show less..',
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: theme.colorScheme.surfaceTint),
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up_outlined,
                        color: theme.colorScheme.surfaceTint,
                        size: 32,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  TextStyle? msgTextFont(ThemeData theme, String font) =>
      theme.textTheme.bodyLarge
          ?.copyWith(color: widget.textColor, fontFamily: font);

  setExpandedTestLen() {
    if (widget.expendedText.length > textLength) {
      firstHalf = widget.expendedText.substring(0, textLength.toInt());
      secondHalf = widget.expendedText
          .substring(textLength.toInt() + 1, widget.expendedText.length);
    } else {
      firstHalf = widget.expendedText;
      secondHalf = '';
    }
  }
}
