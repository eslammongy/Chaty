import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Accent Color",
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600, letterSpacing: 1.2),
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
                      false,
                    ],
                    children: [
                      _buildAccentColorBtn(Colors.orange, true),
                      _buildAccentColorBtn(Colors.indigo, false),
                      _buildAccentColorBtn(Colors.purple, false),
                      _buildAccentColorBtn(Colors.cyan, true),
                      _buildAccentColorBtn(Colors.teal, false),
                    ])
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildAccentColorBtn(Color color, bool isSelected) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.fromBorderSide(
            isSelected
                ? const BorderSide(width: 2, color: Colors.grey)
                : BorderSide.none,
          )),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: SizedBox(
            height: 22.w,
            width: 22.w,
          ),
        ),
      ),
    );
  }
}
