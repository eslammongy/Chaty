import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccentColorToggles extends StatelessWidget {
  const AccentColorToggles({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Accent Color",
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.2),
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
