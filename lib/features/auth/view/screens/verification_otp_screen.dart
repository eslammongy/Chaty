import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/user_pref.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationOtpScreen extends StatelessWidget {
  final String verifyId;

  const VerificationOtpScreen({
    Key? key,
    required this.verifyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final focusNode = FocusNode();
    final theme = Theme.of(context);

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) async {
        if (state is UserCreatedState) {
          await SharedPref.keepUserAuthenticated(isLogged: true).then((value) {
             AppRouter.isUserLogin = true;
            GoRouter.of(context).pushReplacement(AppRouter.dashboardScreen);
          });
        }
        if (state is UserFailureState) {
          Future(() {
            GoRouter.of(context).pop();
            displaySnackBar(context, state.errorMsg);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.surface,
            title: Text(
              "Verification Otp",
              style: theme.textTheme.titleLarge,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 25.h),
                  Text(
                    "please enter the otp code sent to your phone",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  SvgPicture.asset(
                    AppAssetsManager.verificationCodeImg,
                    fit: BoxFit.cover,
                    height: 200.h,
                  ),
                  SizedBox(height: 25.h),
                  Pinput(
                    controller: pinController,
                    focusNode: focusNode,
                    length: 6,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme(theme),
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (code) {
                      showLoadingDialog(context);
                      AuthCubit.get(context)
                          .signInWithPhoneNumber(code, verifyId);
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme(theme).copyWith(
                      decoration: defaultPinTheme(theme).decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: theme.colorScheme.primary, width: 2),
                          ),
                    ),
                    submittedPinTheme: defaultPinTheme(theme).copyWith(
                      decoration: defaultPinTheme(theme).decoration!.copyWith(
                            color: theme.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                    ),
                    errorPinTheme: defaultPinTheme(theme).copyBorderWith(
                      border: Border.all(color: theme.colorScheme.error),
                    ),
                  ),
                  BlocListener<AuthCubit, AuthStates>(
                    listenWhen: (previous, current) {
                      return previous != current;
                    },
                    listener: (context, state) async {
                      if (state is PhoneOtpCodeVerifiedState) {
                        await UserCubit.get(context)
                            .createNewUserProfile(user: state.userModel);
                      }
                      if (state is AuthGenericFailureState) {
                        Future(() {
                          GoRouter.of(context).pop();
                          displaySnackBar(context, state.errorMsg);
                        });
                      }
                    },
                    child: const SizedBox(),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PinTheme defaultPinTheme(theme) => PinTheme(
        width: 56,
        height: 56,
        textStyle: TextStyle(
          fontSize: 22,
          color: theme.colorScheme.onSurface,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: theme.colorScheme.surfaceTint, width: 1.5),
        ),
      );
}
