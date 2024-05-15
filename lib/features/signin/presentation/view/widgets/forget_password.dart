import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/core/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/core/utils/app_routes.dart';
import 'package:flutter_firebase/core/constants/app_assets.dart';
import 'package:flutter_firebase/features/signin/presentation/cubit/signin_cubit.dart';
import 'package:flutter_firebase/features/signin/presentation/view/widgets/custom_text_button.dart';
import 'package:flutter_firebase/features/signin/presentation/view/widgets/custom_text_input_filed.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eTextEmailController = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
        backgroundColor: theme.colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                AppAssetsManager.forgetPasswordImg,
                width: 65.w,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  "Enter the email associated with your account and we well send an email with instructions to reset your password.",
                  style: theme.textTheme.bodyLarge),
              const SizedBox(
                height: 15,
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
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: CustomTextButton(
                  backgroundColor: theme.colorScheme.primary,
                  text: "Send Email",
                  onPressed: () async {
                    await SignInCubit.get(context)
                        .resetUserPassword(eTextEmailController.text);
                  },
                ),
              ),
              BlocListener<SignInCubit, SignInStates>(
                listenWhen: (previous, current) {
                  return previous != current;
                },
                listener: (context, state) {
                  if (state is SignInLoadingState) {
                    showLoadingDialog(context);
                  }
                  if (state is ResetPasswordSuccessState) {
                    GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
                  }
                  if (state is SignInGenericFailureState) {
                    // pop the loading dialog
                    GoRouter.of(context).pop();
                    displaySnackBar(context, state.errorMsg);
                  }
                },
                child: const SizedBox(),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
