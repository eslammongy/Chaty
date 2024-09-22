import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/user/data/models/user_model.dart';
import 'package:chaty/core/widgets/cache_network_profile_img.dart';

class FriendsListItem extends StatelessWidget {
  const FriendsListItem({super.key, required this.user, this.onTap});
  final UserModel user;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        child: SizedBox(
          height: 80.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            child: Row(
              children: [
                CacheNetworkProfileImg(
                  imgUrl: user.imageUrl ?? dummyImageUrl,
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
      ),
    );
  }
}
