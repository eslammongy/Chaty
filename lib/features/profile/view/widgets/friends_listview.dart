import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/profile/view/widgets/friends_list_item.dart';

class FriendsListView extends StatelessWidget {
  const FriendsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 75.h),
        physics: const BouncingScrollPhysics(),
        itemExtent: 80.h,
        itemCount: 15,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              GoRouter.of(context).push(AppRouter.chatScreen);
            },
            child: const FriendsListItem(),
          );
        },
      ),
    );
  }
}
