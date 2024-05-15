import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:flutter_firebase/core/widgets/cache_network_image.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemExtent: 90.h,
        itemBuilder: (context, index) {
          return Card(
            child: SizedBox(
              height: 90.h,
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
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.surfaceTint),
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
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.surfaceTint),
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
        },
      ),
    );
  }
}
