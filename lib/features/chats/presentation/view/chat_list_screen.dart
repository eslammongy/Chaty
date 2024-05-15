import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:flutter_firebase/core/widgets/cache_network_image.dart';
import 'package:flutter_firebase/features/profile/presentation/cubit/profile_info_cubit.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileInfoCubit.get(context);
    final theme = Theme.of(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: SizedBox(
            height: 100.h,
            child: Card(
              color: theme.colorScheme.surface,
              margin: EdgeInsets.zero,
              child: Row(
                children: [
                  CacheNetworkImg(
                      imgUrl: profileCubit.userModel?.imageUrl ?? dummyImageUrl,
                      radius: 20,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)))
                ],
              ),
            ),
          ),
        ),
        body: const Column(
          children: [],
        ));
  }
}
