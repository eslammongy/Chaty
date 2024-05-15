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
            hint: "type something...",
            prefix: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(100),
              child: const Icon(FontAwesomeIcons.faceSmile),
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
