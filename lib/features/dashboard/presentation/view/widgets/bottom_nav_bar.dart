import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/core/theme/common_palette.dart';

typedef GetCurrentIndex = void Function(int index);

class FloatingBottomNavBar extends StatelessWidget {
  final Function()? onAddBtnTap;
  final GetCurrentIndex getCurrentIndex;
  final int currentIndex;
  const FloatingBottomNavBar({
    super.key,
    this.onAddBtnTap,
    required this.getCurrentIndex,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(20);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      elevation: 4,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBottomNavItem(
              context,
              title: "Chat",
              icon: FontAwesomeIcons.message,
              isActive: currentIndex == 0 ? true : false,
              onTap: () {
                getCurrentIndex(0);
              },
            ),
            _buildBottomNavItem(
              context,
              title: "Profile",
              icon: FontAwesomeIcons.user,
              isActive: currentIndex == 1 ? true : false,
              onTap: () {
                getCurrentIndex(1);
              },
            )
          ],
        ),
      ),
    );
  }

  _buildBottomNavItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isActive,
    Function()? onTap,
  }) {
    final theme = Theme.of(context);
    const activeColor = CommonColorPalette.mainOrangeColor;
    final defColor = theme.colorScheme.surfaceTint;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: isActive ? activeColor.withOpacity(0.3) : Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                size: 20,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(color: isActive ? activeColor : defColor),
          ),
        ],
      ),
    );
  }
}
