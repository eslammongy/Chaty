import 'package:go_router/go_router.dart';
import 'package:flutter_firebase/core/utils/user_pref.dart';
import 'package:flutter_firebase/features/dashboard/presentation/view/dashboard_screen.dart';
import 'package:flutter_firebase/features/signin/presentation/view/screens/signup_screen.dart';
import 'package:flutter_firebase/features/signin/presentation/view/screens/sign_in_screen.dart';
import 'package:flutter_firebase/features/signin/presentation/view/widgets/forget_password.dart';
import 'package:flutter_firebase/features/profile/presentation/view/screens/profile_screen.dart';
import 'package:flutter_firebase/features/signin/presentation/view/screens/phone_auth_screen.dart';
import 'package:flutter_firebase/features/signin/presentation/view/screens/verification_otp_screen.dart';

abstract class AppRouter {
  static String dashboardScreen = '/dashboard';
  static String loginScreen = '/loginScreen';
  static String signUpScreen = '/signUpScreen';
  static String forgetPasswordScreen = '/forgetPasswordScreen';
  static String phoneAuthScreen = '/phoneAuthScreen';
  static String verifyingPhoneScreen = '/verifyingPhoneScreen';
  static String profileScreen = '/profileScreen';

  static bool isUserLogin = false;
  static setInitialRoute() async {
    await UserPref.init();
    await UserPref.checkIsUserAuthenticated().then((isLogged) {
      isUserLogin = isLogged;
    });
  }

  static GoRouter appRoutes() {
    return GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          if (!isUserLogin) {
            return const SignInScreen();
          } else {
            return const DashboardScreen();
          }
        },
      ),
      GoRoute(
        path: dashboardScreen,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: loginScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
          path: forgetPasswordScreen,
          builder: (context, state) => const ForgetPasswordScreen()),
      GoRoute(
          path: phoneAuthScreen,
          builder: (context, state) => const PhoneAuthScreen()),
      GoRoute(
        path: verifyingPhoneScreen,
        builder: (context, state) => VerificationOtpScreen(
          verifyId: state.extra.toString(),
        ),
      ),
      GoRoute(
        path: signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
    ]);
  }
}
