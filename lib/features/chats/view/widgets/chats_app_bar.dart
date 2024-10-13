import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/core/utils/debouncer.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:chaty/core/widgets/cache_network_profile_img.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.index});
  final int index;

  static Size heightOfAppBar = Size.fromHeight(kToolbarHeight + 30.h);
  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();
    final debounce = Debounce(delay: const Duration(milliseconds: 150));
    final chatCubit = ChatCubit.get(context);
    final userCubit = UserCubit.get(context);
    final theme = Theme.of(context);
    return PreferredSize(
      preferredSize: Size.fromHeight(100.h),
      child: BlocConsumer<UserCubit, UserStates>(
        bloc: userCubit..fetchAllUserFriends(),
        listener: (context, state) async {
          if (state is UserLoadAllFriendsState) {
            if (ChatCubit.get(context).listOfChats.isEmpty) {
              final friends = UserCubit.get(context).friendsList;
              await ChatCubit.get(context).fetchAllUserChats(friends: friends);
            }
          }
          if (state is UserFailureState) {
            if (context.mounted) displayToastMsg(context, state.errorMsg);
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
                            CacheNetworkProfileImg(
                              imgUrl:
                                  UserCubit.get(context).currentUser.imageUrl ??
                                      dummyImageUrl,
                              radius: 22,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextInputField(
                                textEditingController: searchTextController,
                                bkColor: theme.scaffoldBackgroundColor,
                                prefix: const Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                ),
                                hint: index == 0
                                    ? searchForChatHint
                                    : searchForFriendHint,
                                onChange: (text) {
                                  debounce.call(
                                    () {
                                      if (index == 0) {
                                        chatCubit.searchForChat(text!);
                                      } else {
                                        userCubit.searchForFriend(text!);
                                      }
                                    },
                                  );
                                },
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

  @override
  Size get preferredSize => heightOfAppBar;
}
