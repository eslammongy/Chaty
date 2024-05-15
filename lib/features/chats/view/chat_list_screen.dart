import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/core/widgets/cache_network_image.dart';
import 'package:flutter_firebase/features/chats/view/widgets/chats_app_bar.dart';
import 'package:flutter_firebase/features/profile/presentation/cubit/profile_info_cubit.dart';
import 'package:flutter_firebase/features/signin/presentation/view/widgets/custom_text_input_filed.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileInfoCubit.get(context);
    final controller = TextEditingController();
    final theme = Theme.of(context);
    return Scaffold(
        appBar: const ChatsAppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Messages",
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemExtent: 90.h,
                  itemBuilder: (context, index) {
                    return Card(
                      child: SizedBox(
                        height: 90.h,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
