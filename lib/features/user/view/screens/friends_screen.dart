import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/core/widgets/empty_state_ui.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:chaty/features/user/data/models/user_model.dart';
import 'package:chaty/features/user/view/widgets/friends_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userCubit = UserCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          final friends = _getFriends(userCubit);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Friends",
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (friends.isEmpty && state is! UserInitialState) ...[
                EmptyStateUI(
                  imgPath: AppAssetsManager.emptyInbox,
                  text: state is UserSearchState
                      ? emptySearchResponseMsg
                      : emptyChatsResponseMsg,
                )
              ],
              if (friends.isNotEmpty || state is UserLoadAllFriendsState) ...[
                FriendsListView(
                  friends: friends,
                )
              ]
            ],
          );
        },
      ),
    );
  }

  List<UserModel> _getFriends(UserCubit userCubit) {
    if (userCubit.state is UserSearchState) {
      return userCubit.resultOfSearch;
    } else {
      return userCubit.friendsList;
    }
  }
}
