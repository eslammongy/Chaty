import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/core/widgets/customized_text_btn.dart';
import 'package:chaty/core/widgets/cache_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              radius: 60,
            ),
            const SizedBox(
              height: 30,
            ),
            _buildInfoItem(
                theme, user.bio ?? dummyBio, Icons.info_outline_rounded),
            const SizedBox(
              height: 15,
            ),
            _buildInfoItem(theme, user.name ?? "", FontAwesomeIcons.user),
            const SizedBox(
              height: 15,
            ),
            _buildInfoItem(theme, user.email ?? "", FontAwesomeIcons.envelope),
            const SizedBox(
              height: 15,
            ),
            _buildInfoItem(
                theme, user.phone ?? dummyPhone, FontAwesomeIcons.phone),
            const Spacer(),
            CustomizedTextBtn(
                btnText: "Close",
                bkColor: theme.colorScheme.error,
                textColor: Colors.white,
                onPressed: () => Navigator.pop(context)),
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

  Widget _buildInfoItem(ThemeData theme, String text, IconData icon) {
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
            child: Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  text,
                  textAlign: TextAlign.start,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
