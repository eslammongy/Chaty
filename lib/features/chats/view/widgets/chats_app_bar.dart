import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/core/widgets/cache_network_image.dart';
import 'package:flutter_firebase/features/profile/presentation/cubit/profile_info_cubit.dart';
import 'package:flutter_firebase/features/signin/presentation/view/widgets/custom_text_input_filed.dart';

class ChatsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatsAppBar({super.key});

  static Size heightOfAppBar = Size.fromHeight(kToolbarHeight + 45.h);
  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileInfoCubit.get(context);
    final controller = TextEditingController();
    final theme = Theme.of(context);
    return PreferredSize(
      preferredSize: Size.fromHeight(100.h),
      child: SizedBox(
        height: 110.h,
        child: Card(
          color: theme.colorScheme.surface,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CacheNetworkImg(
                  imgUrl: profileCubit.userModel?.imageUrl ?? dummyImageUrl,
                  radius: 30,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextInputField(
                    textEditingController: controller,
                    prefix: const Icon(FontAwesomeIcons.magnifyingGlass),
                    hint: "Search for a chat...",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => heightOfAppBar;
}
