import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/auth/view/widgets/open_gmail_button.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_button.dart';
import 'package:chaty/features/users/view/widgets/custom_text_button.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eTextEmailController = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocConsumer<AuthCubit, AuthStates>(
            listenWhen: (previous, current) {
              return previous != current;
            },
            listener: (context, state) {
              if (state is AuthLoadingState) {
                showLoadingDialog(context);
              }

              if (state is UserResetPasswordState) {
                GoRouter.of(context).pop();
                displaySnackBar(context,
                    "the rest password link sent to your email please check your email",
                    isFailState: false);
              }
              if (state is AuthGenericFailureState) {
                displaySnackBar(context, state.errorMsg);
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SvgPicture.asset(
                    AppAssetsManager.forgetPasswordImg,
                    height: 220.h,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Enter the email associated with your account and we well send an email with instructions to reset your password.",
                      style: theme.textTheme.bodyLarge),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomTextInputField(
                      textEditingController: eTextEmailController,
                      hint: "enter your email",
                      isTextPassword: false,
                      prefix: const Icon(
                        Icons.email_rounded,
                      ),
                      textInputType: TextInputType.emailAddress,
                      autoFocus: false,
                      maxLines: 1),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: CustomTextButton(
                      backgroundColor: theme.colorScheme.primary,
                      text: "Send Email",
                      onPressed: () async {
                        await AuthCubit.get(context)
                            .resetUserPassword(
                              email: eTextEmailController.text,
                            )
                            .whenComplete(() => GoRouter.of(context).pop());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OpenGmailButton(
                      shouldVisible: state is UserResetPasswordState)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
