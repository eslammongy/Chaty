import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/core/widgets/cache_network_image.dart';

class FriendsListItem extends StatelessWidget {
  const FriendsListItem({super.key});

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Eslam Mongy",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "user email or bio",
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
