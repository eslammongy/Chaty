import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/core/widgets/customized_text_btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/users/view/widgets/profile_bio.dart';
import 'package:chaty/features/users/view/widgets/profile_image_section.dart';
import 'package:chaty/features/users/view/widgets/profile_info_field_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = UserCubit.get(context);
    final theme = Theme.of(context);
    final pioTxtController = TextEditingController();
    final nameTxtController = TextEditingController();
    final phoneTxtController = TextEditingController();
    final emailTxtController = TextEditingController();

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is ProfileImgUploadedState || state is UserCreatedState) {
          Future(() => displaySnackBar(context, "Profile Info Uploaded",
              isFailState: false));
        }
        if (state is UserFailureState) {
          //* dismiss the loading dialog
          GoRouter.of(context).pop();
          Future(() => displaySnackBar(context, state.errorMsg));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: kToolbarHeight - 10),
                  if (state is UserLoadingState)
                    LinearProgressIndicator(
                      color: theme.colorScheme.primary,
                      backgroundColor: theme.colorScheme.surface,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  SizedBox(height: 6.h),
                  ProfileImageSection(
                    profileImgUrl:
                        profileCubit.userModel?.imageUrl ?? dummyImageUrl,
                  ),
                  const SizedBox(height: 20),
                  ProfileBio(pioTxtController: pioTxtController),
                  const SizedBox(height: 20),
                  ProfileInfoFieldItem(
                    text: profileCubit.userModel?.name ?? dummyName,
                    textController: nameTxtController,
                    icon: FontAwesomeIcons.user,
                    onSubmitted: (value) async {
                      profileCubit.userModel?.name = value;
                      await profileCubit.updateUserProfile();
                    },
                  ),
                  const SizedBox(height: 15),
                  ProfileInfoFieldItem(
                    text: profileCubit.userModel?.email ?? dummyEmail,
                    textController: emailTxtController,
                    icon: FontAwesomeIcons.envelope,
                    onSubmitted: (value) async {
                      profileCubit.userModel?.email = value;
                      await profileCubit.updateUserProfile();
                    },
                  ),
                  const SizedBox(height: 15),
                  ProfileInfoFieldItem(
                    text: profileCubit.userModel?.phone ?? dummyPhone,
                    textController: phoneTxtController,
                    icon: FontAwesomeIcons.phone,
                    onSubmitted: (value) async {
                      profileCubit.userModel?.phone = value;
                      await profileCubit.updateUserProfile();
                    },
                  ),
                  const SizedBox(height: 45),
                  CustomizedTextBtn(
                    btnText: "Sign out",
                    bkColor: theme.colorScheme.error,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
