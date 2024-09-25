import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/features/user/view/widgets/custom_text_button.dart';

confirmUserLogout(BuildContext context, {required Function() userLogout}) {
  final theme = Theme.of(context);
  return AlertDialog(
      backgroundColor: theme.colorScheme.scrim,
      elevation: 3,
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      title: Row(
        children: [
          Icon(Icons.info, color: theme.colorScheme.inverseSurface),
          const SizedBox(
            width: 6,
          ),
          Text(
            "Sign out",
            style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.inverseSurface,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Text(
        "Are you sure you want to sign out?",
        textAlign: TextAlign.center,
        style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.inverseSurface,
            fontWeight: FontWeight.w500),
      ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 15),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildTextBtnWidget(
              context,
              btnText: "Cancel",
              hasBorderSide: true,
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
            buildTextBtnWidget(
              context,
              btnText: "Sign out",
              bkColor: theme.colorScheme.error,
              onPressed: userLogout,
            ),
          ],
        )
      ]);
}
