import 'package:go_router/go_router.dart';
import 'package:flutter_firebase/core/utils/user_pref.dart';
import 'package:flutter_firebase/features/chats/view/chat_screen.dart';
import 'package:flutter_firebase/features/chats/view/chat_list_screen.dart';
import 'package:flutter_firebase/features/dashboard/view/dashboard_screen.dart';
import 'package:flutter_firebase/features/signin/view/screens/signup_screen.dart';
import 'package:flutter_firebase/features/signin/view/screens/sign_in_screen.dart';
import 'package:flutter_firebase/features/profile/view/screens/profile_screen.dart';
import 'package:flutter_firebase/features/signin/view/widgets/forget_password.dart';
import 'package:flutter_firebase/features/signin/view/screens/phone_auth_screen.dart';
import 'package:flutter_firebase/features/signin/view/screens/verification_otp_screen.dart';

abstract class AppRouter {
  static String dashboardScreen = '/dashboard';
  static String loginScreen = '/loginScreen';
  static String signUpScreen = '/signUpScreen';
  static String forgetPasswordScreen = '/forgetPasswordScreen';
  static String phoneAuthScreen = '/phoneAuthScreen';
  static String verifyingPhoneScreen = '/verifyingPhoneScreen';
  static String profileScreen = '/profileScreen';
  static String chatsListScreen = '/chatsListScreen';
  static String chatScreen = '/chatScreen';

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
            return const ChatScreen();
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
      GoRoute(
        path: chatsListScreen,
        builder: (context, state) => const ChatListScreen(),
      ),
      GoRoute(
        path: chatScreen,
        builder: (context, state) => const ChatScreen(),
      ),
    ]);
  }
}
