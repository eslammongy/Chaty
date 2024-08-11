import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/user_pref.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/core/widgets/customized_text_btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/users/view/widgets/profile_bio.dart';
import 'package:chaty/features/users/view/widgets/profile_settings.dart';
import 'package:chaty/features/users/view/widgets/confirm_user_logout.dart';
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
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            actions: const [
              ProfileSettings(),
              SizedBox(width: 10),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is UserLoadingState) displayLinearIndicator(theme),
                  const SizedBox(height: 20),
                  ProfileImageSection(
                    profileImgUrl:
                        profileCubit.user?.imageUrl ?? dummyImageUrl,
                  ),
                  const SizedBox(height: 20),
                  ProfileBio(pioTxtController: pioTxtController),
                  const SizedBox(height: 10),
                  ProfileInfoFieldItem(
                    text: profileCubit.user?.name ?? dummyName,
                    textController: nameTxtController,
                    icon: FontAwesomeIcons.user,
                  ),
                  const SizedBox(height: 10),
                  ProfileInfoFieldItem(
                    text: profileCubit.user?.email ?? dummyEmail,
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
                    text: profileCubit.user?.phone ?? dummyPhone,
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
          ),
        );
      },
    );
  }

  void _userSignOut(BuildContext context) {
    UserCubit.get(context).user = null;
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
