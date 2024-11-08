import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/user/data/models/user_model.dart';
import 'package:chaty/core/widgets/cache_network_profile_img.dart';

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
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => GoRouter.of(context).pop(),
                child: Icon(
                  Icons.cancel_outlined,
                  color: theme.colorScheme.error,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CacheNetworkProfileImg(
              imgUrl: user.imageUrl ?? dummyImageUrl,
              radius: 60,
            ),
            const SizedBox(
              height: 30,
            ),
            _buildInfoItem(
                theme, user.bio ?? "none", Icons.info_outline_rounded),
            const SizedBox(
              height: 15,
            ),
            _buildInfoItem(theme, user.name ?? "none", FontAwesomeIcons.user),
            const SizedBox(
              height: 15,
            ),
            _buildInfoItem(
                theme, user.email ?? "none", FontAwesomeIcons.envelope),
            const SizedBox(
              height: 15,
            ),
            _buildInfoItem(theme, user.phone ?? "none", FontAwesomeIcons.phone),
          ],
        ),
      ),
    );
  }

  get roundedShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
        side: const BorderSide(width: 2, color: Colors.white),
      );

  Widget _buildInfoItem(ThemeData theme, String text, IconData icon) {
    return Card(
      color: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: text.length >= 50 ? 124.h : 50.h,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: text.length >= 50
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Icon(icon, color: theme.colorScheme.secondary),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
