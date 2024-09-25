import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/theme/theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/settings/cubit/settings_cubit.dart';
import 'package:chaty/features/settings/view/widgets/message_font_toggles.dart';
import 'package:chaty/features/settings/view/widgets/accent_color_toggles.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final settingCubit = SettingsCubit.get(context);
    final theme = Theme.of(context);
    return BlocBuilder<SettingsCubit, SettingsStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Settings",
                    style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w600, letterSpacing: 1.2),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () => GoRouter.of(context).pop(),
                      child: const Icon(
                        FontAwesomeIcons.x,
                        color: Colors.red,
                      )),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Light Mode",
                    style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600, letterSpacing: 1.2),
                  ),
                  _buildThemeSwitcher(theme, settingCubit),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              const AccentColorToggles(),
              SizedBox(
                height: 30.h,
              ),
              const MessageFontToggles()
            ],
          ),
        );
      },
    );
  }

  Switch _buildThemeSwitcher(ThemeData theme, SettingsCubit settingCubit) {
    return Switch.adaptive(
      activeColor: theme.colorScheme.surfaceTint,
      activeTrackColor: theme.colorScheme.primary,
      inactiveThumbColor: Colors.blueGrey.shade600,
      inactiveTrackColor: Colors.grey.shade400,
      splashRadius: 20.0,
      value: settingCubit.isLight,
      onChanged: (value) {
        settingCubit.isLight = value;
        Future.delayed(const Duration(milliseconds: 100), () {
          debugPrint("Theme Switcher:: ${settingCubit.isLight}");
          if (value) {
            settingCubit.switchAppTheme(lightThemeData());
          } else {
            settingCubit.switchAppTheme(darkThemeData());
          }
        });
      },
    );
  }
}
