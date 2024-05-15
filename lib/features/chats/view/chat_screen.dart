import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/core/widgets/cache_network_image.dart';
import 'package:flutter_firebase/features/chats/view/widgets/chats_listview.dart';
import 'package:flutter_firebase/features/signin/view/widgets/custom_text_input_filed.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final msgController = TextEditingController();
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
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        child: Column(
          children: [
            const ChatsList(),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextInputField(
                    textEditingController: msgController,
                    hint: "type something...",
                    prefix: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(100),
                      child: const Icon(FontAwesomeIcons.faceSmile),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Card(
                    color: theme.colorScheme.primary,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(100),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          FontAwesomeIcons.paperPlane,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
