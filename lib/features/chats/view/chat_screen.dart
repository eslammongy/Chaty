import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/core/widgets/cache_network_image.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        leadingWidth: double.infinity,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        leading: PreferredSize(
          preferredSize: Size.fromHeight(90.h),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(FontAwesomeIcons.chevronLeft),
                ),
                const SizedBox(
                  width: 20,
                ),
                CacheNetworkImg(
                  imgUrl: dummyImageUrl,
                  radius: 28,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Eslam Mongy",
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.circleInfo),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
