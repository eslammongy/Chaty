import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/users/data/models/user_model.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_button.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';
import 'package:chaty/features/auth/view/widgets/login_screen_intro_section.dart';

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
      body: BlocListener<AuthCubit, AuthStates>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) async {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          }
          if (state is SignUpSuccessState) {
            await _createUserProfileInfo(context, state.userModel)
                .then((value) => GoRouter.of(context).pop());
          }
          if (state is AuthGenericFailureState) {
            Future(() {
              GoRouter.of(context).pop();
              displaySnackBar(context, state.errorMsg);
            });
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  const LoginScreenIntroSection(
                    introText: "Welcome",
                    subIntroText: "Sign up to continue",
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Column(
                    children: [
                      CustomTextInputField(
                          textEditingController: userNameTextEditor,
                          hint: "enter your nick name",
                          maxLines: 1,
                          prefix: const Icon(
                            FontAwesomeIcons.userLarge,
                          ),
                          isTextPassword: false,
                          autoFocus: false),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextInputField(
                          textEditingController: emailTextEditor,
                          hint: "enter your email",
                          maxLines: 1,
                          textInputType: TextInputType.emailAddress,
                          prefix: const Icon(
                            Icons.email_rounded,
                          ),
                          isTextPassword: false,
                          autoFocus: false),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextInputField(
                        textEditingController: passwordTextEditor,
                        hint: "enter your password",
                        maxLines: 1,
                        prefix: const Icon(
                          FontAwesomeIcons.lock,
                        ),
                        isTextPassword: true,
                        autoFocus: false,
                        textInputType: TextInputType.visiblePassword,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
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
      ),
    );
  }

  Future<void> _createUserProfileInfo(
      BuildContext context, UserModel userModel) async {
    await UserCubit.get(context)
        .createNewUserProfile(user: userModel)
        .whenComplete(() => GoRouter.of(context).pop());
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
        .then((value) => GoRouter.of(context).pop());
  }
}
