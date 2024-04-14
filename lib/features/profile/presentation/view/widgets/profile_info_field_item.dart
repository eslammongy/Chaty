import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/signin/presentation/view/widgets/custom_text_input_filed.dart';

class ProfileInfoFieldItem extends StatelessWidget {
  const ProfileInfoFieldItem({
    super.key,
    required this.text,
    required this.textController,
    required this.icon,
  });
  final String text;
  final TextEditingController textController;
  final IconData icon;

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
            text: text,
            prefix: Icon(
              icon,
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
