import 'package:flutter/material.dart';
import 'package:chaty/core/theme/common_palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      elevation: 4,
      shadowColor: Colors.indigo.shade800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBottomNavItem(
              context,
              title: "Chat",
              icon: FontAwesomeIcons.commentDots,
              isActive: currentIndex == 0 ? true : false,
              onTap: () {
                getCurrentIndex(0);
              },
            ),
            _buildBottomNavItem(
              context,
              title: "Friends",
              icon: FontAwesomeIcons.userGroup,
              isActive: currentIndex == 1 ? true : false,
              onTap: () {
                getCurrentIndex(1);
              },
            ),
            _buildBottomNavItem(
              context,
              title: "Profile",
              icon: FontAwesomeIcons.user,
              isActive: currentIndex == 2 ? true : false,
              onTap: () {
                getCurrentIndex(2);
              },
            ),
            _buildBottomNavItem(
              context,
              title: "Settings",
              icon: FontAwesomeIcons.gear,
              isActive: currentIndex == 3 ? true : false,
              onTap: () {
                getCurrentIndex(3);
              },
            ),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            color:
                isActive ? activeColor.withOpacity(0.45) : Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Icon(
                icon,
                size: 20,
              ),
            ),
          ),
          isActive
              ? Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                      color: isActive ? activeColor : defColor,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
