import '../../cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/features/auth/view/widgets/build_login_option_btn.dart';

class AuthProviders extends StatelessWidget {
  const AuthProviders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authCubit = AuthCubit.get(context);
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: theme.colorScheme.surfaceTint,
                      thickness: 3,
                    ),
                  ),
                  Card(
                    color: theme.scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(
                            width: 2, color: theme.colorScheme.secondary)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "OR",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: theme.colorScheme.surfaceTint,
                      thickness: 3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SignInOptionBtn(
              iconPath: AppAssetsManager.googleIcon,
              btnText: "SignIn With Google",
              signInOption: SignInOption.google,
              onPressed: () async {
               await authCubit.signInWithGoogleAccount();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SignInOptionBtn(
              iconPath: AppAssetsManager.phoneIcon,
              btnText: "SignIn With Phone Number",
              signInOption: SignInOption.phone,
              onPressed: () async {
                GoRouter.of(context).push(AppRouter.phoneAuthScreen);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account",
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.signUpScreen);
                    },
                    child: Text(
                      "Sign up",
                      style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.secondary),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
