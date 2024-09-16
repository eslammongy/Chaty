import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/settings/view/widgets/settings_bottom_sheet.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        _displaySettingSheet(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          FontAwesomeIcons.gear,
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }

  Future<void> _displaySettingSheet(BuildContext context) async {
    const borderRadius = Radius.circular(20.0);
    final theme = Theme.of(context);

    await showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: borderRadius,
          topRight: borderRadius,
        ),
      ),
      builder: (BuildContext context) {
        return const SettingsBottomSheet();
      },
    );
  }
}
