import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';

class MsgTypeBuilder extends StatelessWidget {
  const MsgTypeBuilder({super.key, required this.msgController});
  final TextEditingController msgController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatCubit = ChatCubit.get(context);
    final userCubit = UserCubit.get(context);
    return Expanded(
      child: CustomTextInputField(
        textEditingController: msgController,
        focusColor: theme.colorScheme.surface,
        fieldRoundedRadius: BorderRadius.circular(20),
        hint: "type something...",
        prefix: _buildPickIngBtn(
          theme,
          onPressed: () async {
            final image = await pickImageFromCamera(context);
            if (image == null) return;
            final msg = MessageModel.buildMsg(image.path, userCubit.currentUser.uId!,
                type: MsgType.file);
            await chatCubit.uploadProfileImage(File(image.path), msg);
          },
        ),
        suffix: _buildPickIngBtn(
          theme,
          icon: FontAwesomeIcons.image,
          onPressed: () async {
            final image = await pickGalleryImage(context);
            if (image == null) return;
            final msg = MessageModel.buildMsg(image.path, userCubit.currentUser.uId!,
                type: MsgType.file);
            await chatCubit.uploadProfileImage(File(image.path), msg);
          },
        ),
      ),
    );
  }

  IconButton _buildPickIngBtn(ThemeData theme,
      {Function()? onPressed, IconData icon = Icons.camera_alt_rounded}) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      icon: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
