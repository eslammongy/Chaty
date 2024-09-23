import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/view/widgets/chats_app_bar.dart';
import 'package:chaty/features/user/view/widgets/friends_listview.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: const ChatsAppBar(
          searchHint: searchForFriendHint,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Friends",
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const FriendsListView()
            ],
          ),
        ));
  }
}
