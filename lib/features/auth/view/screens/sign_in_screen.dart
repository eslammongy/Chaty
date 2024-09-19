import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/services/fcm_services.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:chaty/features/user/data/models/user_model.dart';
import 'package:chaty/features/auth/view/widgets/signing_screen_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) async {
        if (state is AuthLoadingState) {
          showLoadingDialog(context, text: "please wait...");
        }
        if (state is SignInWithGoogleSuccessState) {
          await _handleCreateNewUserDoc(context, state.userModel);
        }
        if (state is SignInSuccessState) {
          if (!context.mounted) return;
          await UserCubit.get(context).fetchUserInfo();
        }
        if (state is AuthGenericFailureState) {
          if (!context.mounted) return;
          GoRouter.of(context).pop();
          displaySnackBar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(), child: SignInScreenBody()),
        );
      },
    );
  }

  Future<void> _handleCreateNewUserDoc(
      BuildContext context, UserModel user) async {
    final userCubit = UserCubit.get(context);
    await FCMService.checkDeviceToken().then((_) async {
      user.token = FCMService.userDeviceToken;
      await userCubit.createNewUserProfile(user: user);
    });
  }
}
