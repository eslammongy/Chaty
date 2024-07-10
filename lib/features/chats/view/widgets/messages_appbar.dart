import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/core/widgets/cache_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/users/data/models/user_model.dart';
import 'package:chaty/features/users/view/widgets/user_info_sheet_body.dart';

class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessagesAppBar({super.key, required this.receiver});
  final UserModel receiver;
  static Size heightOfAppBar = Size.fromHeight(kToolbarHeight + 20.h);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      toolbarHeight: 90.h,
      elevation: 3,
      leadingWidth: double.infinity,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      leading: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  ChatCubit.get(context).openedChat = null;
                  GoRouter.of(context).pop();
                },
                icon: const Icon(FontAwesomeIcons.chevronLeft),
              ),
              const SizedBox(
                width: 20,
              ),
              CacheNetworkImg(
                imgUrl: receiver.imageUrl ?? dummyImageUrl,
                radius: 28,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                receiver.name ?? "",
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  await _displayUserInfoSheet(context);
                },
                icon: const Icon(FontAwesomeIcons.circleInfo),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => heightOfAppBar;

  Future<void> _displayUserInfoSheet(BuildContext context) async {
    const borderRadius = Radius.circular(20.0);
    final theme = Theme.of(context);

    await showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: borderRadius,
          topRight: borderRadius,
        ),
      ),
      builder: (BuildContext context) {
        return UserInfoSheetBody(
          user: receiver,
        );
      },
    );
  }
}
