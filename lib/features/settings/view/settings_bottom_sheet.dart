import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/settings/view/message_font_toggels.dart';
import 'package:chaty/features/settings/view/widgets/accent_color_toggels.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              "Settings",
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.2),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Light Mode",
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600, letterSpacing: 1.2),
                ),
                Switch.adaptive(
                  activeColor: theme.colorScheme.surfaceTint,
                  activeTrackColor: theme.colorScheme.primary,
                  inactiveThumbColor: Colors.blueGrey.shade600,
                  inactiveTrackColor: Colors.grey.shade400,
                  splashRadius: 20.0,
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            const AccentColorToggles(),
            SizedBox(
              height: 20.h,
            ),
            const MessageFontToggles()
          ],
        ),
      ),
    );
  }
}
