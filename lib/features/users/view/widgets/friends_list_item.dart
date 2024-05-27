import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/core/widgets/cache_network_image.dart';
import 'package:chaty/features/users/data/models/user_model.dart';

class FriendsListItem extends StatelessWidget {
  const FriendsListItem({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: SizedBox(
        height: 80.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: Row(
            children: [
              CacheNetworkImg(
                imgUrl: dummyImageUrl,
                shapeBorder: RoundedRectangleBorder(
                    side: BorderSide(
                        color: theme.scaffoldBackgroundColor, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                radius: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? dummyName,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      user.email ?? dummyEmail,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.surfaceTint),
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
}
