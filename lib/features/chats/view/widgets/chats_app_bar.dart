import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/core/widgets/cache_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';

class ChatsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatsAppBar({super.key, required this.searchHint});
  final String searchHint;

  static Size heightOfAppBar = Size.fromHeight(kToolbarHeight + 30.h);
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final theme = Theme.of(context);
    return PreferredSize(
      preferredSize: Size.fromHeight(100.h),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) async {
          if (state is UserLoadingState) {
            showLoadingDialog(context, text: "loading profile info...");
          }
          if (state is UserLoadAllFriendsState) {
            Future(() async {
              _closeLoadingIndicator(context);
              if (ChatCubit.get(context).listOFChats.isEmpty) {
                await ChatCubit.get(context).fetchAllUserChats();
              }
            });
          }
          if (state is UserFailureState) {
            Future(() {
              _closeLoadingIndicator(context);
              displayToastMsg(context, state.errorMsg);
            });
          }
        },
        builder: (context, state) {
          return SizedBox(
              height: 100.h,
              child: Card(
                  color: theme.colorScheme.surface,
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CacheNetworkImg(
                              imgUrl:
                                  UserCubit.get(context).userModel?.imageUrl ??
                                      dummyImageUrl,
                              radius: 26,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextInputField(
                                textEditingController: controller,
                                bkColor: theme.scaffoldBackgroundColor,
                                prefix: const Icon(
                                    FontAwesomeIcons.magnifyingGlass),
                                hint: searchHint,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )));
        },
      ),
    );
  }

  /// close loading dialog
  void _closeLoadingIndicator(BuildContext context) =>
      GoRouter.of(context).pop();

  @override
  Size get preferredSize => heightOfAppBar;
}
