import 'package:flutter/material.dart';
import 'package:chaty/core/theme/common_palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/settings/cubit/settings_cubit.dart';

class AccentColorToggles extends StatelessWidget {
  const AccentColorToggles({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = SettingsCubit.get(context);
    final selectedColor = settingsCubit.msgBkColor;
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Accent Color",
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.2),
        ),
        _buildAccentColorBtn(
          context,
          CommonColorPalette.mainBlue,
          selectedColor.value == CommonColorPalette.mainBlue.value,
        ),
        _buildAccentColorBtn(
          context,
          Colors.purple,
          selectedColor.value == Colors.purple.value,
        ),
        _buildAccentColorBtn(
          context,
          Colors.green,
          selectedColor.value == Colors.green.value,
        ),
        _buildAccentColorBtn(
          context,
          Colors.teal,
          selectedColor.value == Colors.teal.value,
        )
      ],
    );
  }

  _buildAccentColorBtn(BuildContext context, Color color, bool isSelected) {
    final settingsCubit = SettingsCubit.get(context);
    return InkWell(
      onTap: () {
        settingsCubit.msgBkColor = color;
        settingsCubit.switchMsgBKColor(color);
      },
      child: DecoratedBox(
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
      ),
    );
  }
}
