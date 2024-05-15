import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/core/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/core/utils/user_pref.dart';
import 'package:flutter_firebase/core/utils/app_routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/features/signin/cubit/signin_cubit.dart';
import 'package:flutter_firebase/features/profile/cubit/profile_info_cubit.dart';
import 'package:flutter_firebase/features/signin/view/widgets/custom_text_button.dart';
import 'package:flutter_firebase/features/signin/view/widgets/custom_text_input_filed.dart';
import 'package:flutter_firebase/features/signin/view/widgets/login_screen_intro_section.dart';

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
        backgroundColor: theme.colorScheme.background,
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 4.h,
            ),
            const LoginScreenIntroSection(
              introText: "Welcome",
              subIntroText: "Sign up to continue",
            ),
            SizedBox(
              height: 4.h,
            ),
            Column(
              children: [
                CustomTextInputField(
                    textEditingController: userNameTextEditor,
                    hint: "enter your nick name",
                    maxLines: 1,
                    prefix: Icon(
                      FontAwesomeIcons.userLarge,
                      size: 5.w,
                    ),
                    isTextPassword: false,
                    autoFocus: false),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextInputField(
                    textEditingController: emailTextEditor,
                    hint: "enter your email",
                    maxLines: 1,
                    textInputType: TextInputType.emailAddress,
                    prefix: Icon(
                      Icons.email_rounded,
                      size: 5.w,
                    ),
                    isTextPassword: false,
                    autoFocus: false),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextInputField(
                  textEditingController: passwordTextEditor,
                  hint: "enter your password",
                  maxLines: 1,
                  prefix: Icon(
                    FontAwesomeIcons.lock,
                    size: 5.w,
                  ),
                  isTextPassword: true,
                  autoFocus: false,
                  textInputType: TextInputType.visiblePassword,
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomTextButton(
              backgroundColor: theme.colorScheme.primary,
              text: "Sign up",
              onPressed: () async {
                await userSignUp(
                  context,
                  userNameTextEditor,
                  passwordTextEditor,
                  emailTextEditor,
                );
              },
            ),
            SizedBox(
              height: 3.h,
            ),
            BlocListener<SignInCubit, SignInStates>(
              listenWhen: (previous, current) {
                return previous != current;
              },
              listener: (context, state) async {
                if (state is SignInLoadingState) {
                  showLoadingDialog(context);
                }
                if (state is SignUpSuccessState) {
                  await ProfileInfoCubit.get(context)
                      .createNewUserProfile(user: state.userModel)
                      .then((value) async {
                    await _keepUserLoggedIn(context);
                  });
                }
                if (state is SignInGenericFailureState) {
                  Future(() {
                    GoRouter.of(context).pop();
                    displaySnackBar(context, state.errorMsg);
                  });
                }
              },
              child: const SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Already have an account",
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(
                  width: 1.w,
                ),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.loginScreen);
                  },
                  child: Text(
                    "Sign In",
                    style: theme.textTheme.titleLarge!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
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
    }

    await SignInCubit.get(context).signUpWithEmailPassword(
        name: userNTextController.text,
        email: emailTextController.text,
        password: passwordTextController.text);
  }

  Future<void> _keepUserLoggedIn(BuildContext context) async {
    await UserPref.keepUserAuthenticated(isLogged: true).then((value) {
      GoRouter.of(context).pushReplacement(AppRouter.dashboardScreen);
    });
  }
}
