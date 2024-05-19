import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageFontToggles extends StatelessWidget {
  const MessageFontToggles({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Msg Font",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        ToggleButtons(
            borderColor: Colors.transparent,
            borderWidth: 0,
            disabledBorderColor: Colors.transparent,
            isSelected: const [
              true,
              false,
              false,
              false,
            ],
            children: [
              _buildMsgFontBtn(theme, true, cairoFM),
              _buildMsgFontBtn(theme, false, ubuntuSans),
              _buildMsgFontBtn(theme, false, dancingScript),
              _buildMsgFontBtn(theme, false, chakraPetch),
            ])
      ],
    );
  }

  _buildMsgFontBtn(ThemeData theme, bool isSelected, String fontFamily) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.fromBorderSide(
            isSelected
                ? const BorderSide(width: 2, color: Colors.grey)
                : BorderSide.none,
          )),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: 25.w,
          width: 25.w,
          child: Text("Aa",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                  fontFamily: fontFamily,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? theme.colorScheme.secondary : null)),
        ),
      ),
    );
  }
}
