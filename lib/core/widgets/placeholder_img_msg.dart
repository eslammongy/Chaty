import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';

enum PlaceholderType { asset, file }

class PlaceholderImgMsg extends StatelessWidget {
  const PlaceholderImgMsg({super.key, required this.type});
  final PlaceholderType type;

  @override
  Widget build(BuildContext context) {
    final chatCubit = ChatCubit.get(context);
    final messages = chatCubit.openedChat?.messages ?? [];
    final lastMsg = messages.isNotEmpty ? messages.first : null;
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: type == PlaceholderType.asset
                ? Image.asset(
                    AppAssetsManager.landscapePlaceholder,
                  )
                : Image.file(
                    File(lastMsg!.text!),
                  )),
        Positioned(
          bottom: 0,
          top: 0,
          child: Image.asset(
            AppAssetsManager.loading,
            width: 40,
          ),
        ),
      ],
    );
  }
}
