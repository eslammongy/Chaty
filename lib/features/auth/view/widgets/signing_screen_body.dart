import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/user_pref.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/auth/view/widgets/signin_from.dart';
import 'package:chaty/features/auth/view/widgets/auth_providers.dart';
import 'package:chaty/features/auth/view/widgets/login_screen_intro_section.dart';

class SignInScreenBody extends StatelessWidget {
  const SignInScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordTxtController = TextEditingController();
    final emailTxtController = TextEditingController();
    return BlocListener<UserCubit, UserStates>(
      listener: (context, state) async {
        if (state is UserFetchedState && state.token == null) {
          _keepUserLoggedIn(context);
        }
        if (state is UserCreatedState) {
          _keepUserLoggedIn(context);
        }
        if (state is UserFailureState) {
          displaySnackBar(context, state.errorMsg);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 60.h,
          ),
          const LoginScreenIntroSection(
            introText: "Welcome Back",
            subIntroText: "Sign in to continue",
          ),
          const SizedBox(
            height: 15,
          ),
          SingInFrom(
            emailTxtController: emailTxtController,
            passTxtController: passwordTxtController,
            onPressed: () async {
              await userSignInWithEmail(
                context,
                emailTxtController,
                passwordTxtController,
              );
            },
          ),
          const SizedBox(height: 20),
          const AuthProviders()
        ]),
      ),
    );
  }

  userSignInWithEmail(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    final authCubit = AuthCubit.get(context);
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      displaySnackBar(context, "please make sure you entered all info!");
      return;
    }
    if (!isValidEmail(emailController.text)) {
      displaySnackBar(context, "please make sure you entered a valid email!");
      return;
    }
    await authCubit.signInWithEmailPassword(
        email: emailController.text, password: passwordController.text);
  }

  Future<void> _keepUserLoggedIn(BuildContext context) async {
    AppRouter.isUserLogin = true;
    debugPrint("****User Created & try to save user logged..");
    await SharedPref.keepUserAuthenticated(isLogged: true).then((value) {
      if (!context.mounted) return;
      GoRouter.of(context).pushReplacement(AppRouter.dashboardScreen);
    });
  }
}
