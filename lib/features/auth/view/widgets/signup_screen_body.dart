import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_button.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';
import 'package:chaty/features/auth/view/widgets/login_screen_intro_section.dart';

class SignUpScreenBody extends StatelessWidget {
  const SignUpScreenBody({
    super.key,
    required this.userNameTextEditor,
    required this.passwordTextEditor,
    required this.emailTextEditor,
    this.onSignup,
  });
  final TextEditingController userNameTextEditor;
  final TextEditingController passwordTextEditor;
  final TextEditingController emailTextEditor;
  final Function()? onSignup;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
              onPressed: onSignup),
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
    );
  }
}
