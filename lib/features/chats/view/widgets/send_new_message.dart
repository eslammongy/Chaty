import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/features/signin/view/widgets/custom_text_input_filed.dart';

class SendNewMessage extends StatelessWidget {
  const SendNewMessage({
    super.key,
    required this.msgController,
    required this.theme,
  });

  final TextEditingController msgController;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextInputField(
            textEditingController: msgController,
            focusColor: theme.colorScheme.surface,
            fieldRoundedRadius: BorderRadius.circular(20),
            hint: "type something...",
            prefix: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: Card(
                color: theme.colorScheme.primary,
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            suffix: InkWell(
              onTap: () {},
              radius: 8,
              borderRadius: BorderRadius.circular(12),
              child: const Icon(
                FontAwesomeIcons.image,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Card(
            color: theme.colorScheme.primary,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(100),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
