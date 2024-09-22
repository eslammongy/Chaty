import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/user_pref.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/core/widgets/customized_text_btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/user/view/widgets/profile_bio.dart';
import 'package:chaty/features/user/view/widgets/app_settings.dart';
import 'package:chaty/features/user/view/widgets/confirm_user_logout.dart';
import 'package:chaty/features/user/view/widgets/profile_image_section.dart';
import 'package:chaty/features/user/view/widgets/profile_info_field_item.dart';

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
        if (state is UserUploadProfileImgState || state is UserCreatedState) {
          if (!context.mounted) return;
          displaySnackBar(context, "Profile Info Uploaded", isFailState: false);
        }
        if (state is UserFailureState && context.mounted) {
          //* dismiss the loading dialog
          GoRouter.of(context).pop();
          displaySnackBar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: kToolbarHeight, horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.topRight,
                  child: AppSettings(),
                ),
                const SizedBox(height: 20),
                if (state is UserLoadingState) displayLinearIndicator(theme),
                const SizedBox(height: 20),
                ProfileImageSection(
                  profileImgUrl:
                      profileCubit.currentUser.imageUrl ?? dummyImageUrl,
                ),
                const SizedBox(height: 20),
                ProfileBio(pioTxtController: pioTxtController),
                const SizedBox(height: 10),
                ProfileInfoFieldItem(
                  text: profileCubit.currentUser.name ?? dummyName,
                  textController: nameTxtController,
                  icon: FontAwesomeIcons.user,
                ),
                const SizedBox(height: 10),
                ProfileInfoFieldItem(
                  text: profileCubit.currentUser.email ?? dummyEmail,
                  textController: emailTxtController,
                  icon: FontAwesomeIcons.envelope,
                  enabled: false,
                ),
                BlocListener<AuthCubit, AuthStates>(
                  listener: (context, state) {
                    if (state is AuthLoadingState) {
                      showLoadingDialog(context);
                    }
                    if (state is UserLogoutState) {
                      _userSignOut(context);
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
                const SizedBox(height: 10),
                ProfileInfoFieldItem(
                  text: profileCubit.currentUser.phone ?? dummyPhone,
                  textController: phoneTxtController,
                  icon: FontAwesomeIcons.phone,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 35),
                CustomizedTextBtn(
                  btnText: "Sign out",
                  bkColor: theme.colorScheme.error,
                  textColor: Colors.white,
                  onPressed: () {
                    _showLogoutAlertDialog(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _userSignOut(BuildContext context) {
    SharedPref.saveFCMToken(token: '');
    ChatCubit.get(context).openedChat = null;
    ChatCubit.get(context).listOFChats.clear();
    UserCubit.get(context).friendsList.clear();
    GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
  }

  Future<void> _showLogoutAlertDialog(
    BuildContext context,
  ) async {
    final authCubit = AuthCubit.get(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Theme.of(context).colorScheme.surface.withOpacity(0.6),
      builder: (context) {
        return confirmUserLogout(context, userLogout: () async {
          await authCubit.logout().whenComplete(() {
            SharedPref.keepUserAuthenticated(isLogged: false);
          });
        });
      },
    );
  }
}
