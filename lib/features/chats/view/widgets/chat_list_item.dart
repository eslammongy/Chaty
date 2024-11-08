import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';
import 'package:chaty/core/widgets/cache_network_profile_img.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.chat,
  });
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recipient = chat.currentRecipient;

    return Card(
      elevation: 1,
      child: SizedBox(
        height: 90.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: Row(
            children: [
              CacheNetworkProfileImg(
                imgUrl: recipient!.imageUrl ?? dummyImageUrl,
                radius: 28,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipient.name ?? dummyName,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          getMsgDateOnly(
                              chat.messages?.first.dateTime?.toDate() ??
                                  DateTime.now()),
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: theme.colorScheme.surfaceTint),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.done_all_outlined,
                          color: theme.colorScheme.surfaceTint,
                        ),
                        Expanded(
                          child: Text(
                            lastMsgText(chat),
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.surfaceTint),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String lastMsgText(ChatModel chat) {
    if (chat.messages?.first.msgType == MsgType.image) return 'image';
    return chat.messages?.first.text ?? '';
  }
}
