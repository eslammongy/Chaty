import 'package:flutter/material.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';

class ProfileInfoFieldItem extends StatelessWidget {
  const ProfileInfoFieldItem({
    super.key,
    required this.text,
    required this.textController,
    required this.icon,
    this.height = 50.0,
    this.enabled = true,
  });
  final String text;
  final TextEditingController textController;
  final IconData icon;
  final bool enabled;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    textController.text = text;
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.centerLeft,
          child: CustomTextInputField(
            textEditingController: textController,
            // initText: textController.text = text,
            height: height,
            enabled: enabled,
            prefix: Icon(
              icon,
              color: theme.colorScheme.secondary,
            ),
            onSubmitted: (value) {
              onSubmitted(context, value);
            },
          ),
        ),
      ),
    );
  }

  void onSubmitted(BuildContext context, String? value) async {
    final profileCubit = UserCubit.get(context);
    switch (icon) {
      case FontAwesomeIcons.user:
        profileCubit.userModel?.name = value;
        break;
      case FontAwesomeIcons.envelope:
        profileCubit.userModel?.email = value;
        break;
      case FontAwesomeIcons.phone:
        profileCubit.userModel?.phone = value;
        break;
      default:
    }
    await profileCubit.updateUserProfile();
  }
}
