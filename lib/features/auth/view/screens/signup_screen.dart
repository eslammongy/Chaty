import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/services/fcm_services.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:chaty/features/user/data/models/user_model.dart';
import 'package:chaty/features/auth/view/widgets/signup_screen_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userNameTextEditor = TextEditingController();
    final passwordTextEditor = TextEditingController();
    final emailTextEditor = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text("Sign Up"),
      ),
      body: BlocListener<AuthCubit, AuthStates>(
          listenWhen: (previous, current) {
            return previous != current;
          },
          listener: (context, state) async {
            if (state is AuthLoadingState) {
              showLoadingDialog(context);
            }
            if (state is SignUpSuccessState) {
              await _handleCreateNewUserDoc(context, state.userModel).then((_) {
                if (context.mounted) GoRouter.of(context).pop();
              });
            }
            if (state is AuthGenericFailureState) {
              if (context.mounted) {
                GoRouter.of(context).pop();
                displaySnackBar(context, state.errorMsg);
              }
            }
          },
          child: SignUpScreenBody(
            userNameTextEditor: userNameTextEditor,
            passwordTextEditor: passwordTextEditor,
            emailTextEditor: emailTextEditor,
            onSignup: () async {
              await userSignUp(
                context,
                userNameTextEditor,
                passwordTextEditor,
                emailTextEditor,
              );
            },
          )),
    );
  }

  Future<void> _handleCreateNewUserDoc(
    BuildContext context,
    UserModel user,
  ) async {
    final userCubit = UserCubit.get(context);
    await FCMService.getDeviceToken(context).then((_) async {
      user.token = FCMService.userDeviceToken;
      debugPrint("User Device Token:${user.token}");
      await userCubit.setNewUserProfile(user: user);
    });
  }

  Future<void> userSignUp(
    BuildContext context,
    TextEditingController userNTextController,
    TextEditingController passwordTextController,
    TextEditingController emailTextController,
  ) async {
    if (emailTextController.text.isEmpty ||
        passwordTextController.text.isEmpty ||
        userNTextController.text.isEmpty) {
      displaySnackBar(context, "please make sure you entered all info!");
      return;
    }

    await AuthCubit.get(context)
        .signUpWithEmailPassword(
            name: userNTextController.text,
            email: emailTextController.text,
            password: passwordTextController.text)
        .then((value) {
      if (context.mounted) GoRouter.of(context).pop();
    });
  }
}
