import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/core/widgets/cache_network_image.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: SizedBox(
        height: 90.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: Row(
            children: [
              const CacheNetworkImg(
                imgUrl: dummyImageUrl,
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
                          "Eslam Mongy",
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "12:00 PM",
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
                        Text(
                          "what are you doing",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: theme.colorScheme.surfaceTint),
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
}
