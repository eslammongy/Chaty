import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/core/widgets/customized_text_btn.dart';
import 'package:chaty/core/widgets/cache_network_image.dart';
import 'package:chaty/features/users/data/models/user_model.dart';

class UserInfoSheetBody extends StatelessWidget {
  const UserInfoSheetBody({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            CacheNetworkImg(
              imgUrl: user.imageUrl ?? dummyImageUrl,
              radius: 45,
            ),
            const SizedBox(
              height: 30,
            ),
            _buildInfoItem(theme, user.bio ?? dummyBio),
            const SizedBox(
              height: 15,
            ),
            _buildInfoItem(theme, user.name ?? ""),
            const SizedBox(
              height: 15,
            ),
            _buildInfoItem(theme, user.email ?? ""),
            const SizedBox(
              height: 15,
            ),
            _buildInfoItem(theme, user.phone ?? ""),
            const Spacer(),
            CustomizedTextBtn(
                btnText: "Close", bkColor: theme.colorScheme.error),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  get roundedShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
        side: const BorderSide(width: 2, color: Colors.white),
      );

  Widget _buildInfoItem(ThemeData theme, String text) {
    return Card(
      color: theme.colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: text.length >= 50 ? 124.h : 50.h,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
