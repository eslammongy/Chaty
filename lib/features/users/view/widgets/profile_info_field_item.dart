import 'package:flutter/material.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';

class ProfileInfoFieldItem extends StatelessWidget {
  const ProfileInfoFieldItem({
    super.key,
    required this.text,
    required this.textController,
    required this.icon,
    this.height = 50.0,
    this.onSubmitted,
  });
  final String text;
  final TextEditingController textController;
  final IconData icon;
  final double height;
  final Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            initText: text,
            height: height,
            prefix: Icon(
              icon,
              color: theme.colorScheme.secondary,
            ),
            onSubmitted: onSubmitted,
          ),
        ),
      ),
    );
  }
}