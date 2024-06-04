import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/core/widgets/cache_network_image.dart';
import 'package:chaty/features/users/data/models/user_model.dart';
import 'package:chaty/features/chats/data/models/chat_model.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.chat,
  });
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final receiver = getChatReceiver(context);

    return Card(
      elevation: 0,
      child: SizedBox(
        height: 90.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: Row(
            children: [
              CacheNetworkImg(
                imgUrl: receiver.imageUrl ?? dummyImageUrl,
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
                          receiver.name ?? dummyName,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          getMsgDateOnly(
                              chat.messages?.last.dateTime?.toDate() ??
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
                            chat.messages?.last.text ?? "",
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

  UserModel getChatReceiver(BuildContext context) {
    if (chat.participants?.isEmpty == true) return UserModel();
    final userCubit = UserCubit.get(context);
    final receiver = userCubit.friendsList
        .firstWhere((element) => element.uId == chat.participants?.last);
    return receiver;
  }
}
