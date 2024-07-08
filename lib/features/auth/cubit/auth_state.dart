part of 'auth_cubit.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class SignInSuccessState extends AuthStates {
  final UserModel userModel;

  SignInSuccessState({required this.userModel});
}

class SignUpSuccessState extends AuthStates {
  final UserModel userModel;

  SignUpSuccessState({required this.userModel});
}

class SignInWithGoogleSuccessState extends AuthStates {
  final UserModel userModel;

  SignInWithGoogleSuccessState({required this.userModel});
}

class ResetPasswordSuccessState extends AuthStates {}

class PhoneNumberSubmittedState extends AuthStates {
  final String verificationId;

  PhoneNumberSubmittedState({required this.verificationId});
}

class PhoneOtpCodeVerifiedState extends AuthStates {
  final UserModel userModel;

  PhoneOtpCodeVerifiedState({required this.userModel});
}

class AuthGenericFailureState extends AuthStates {
  final String errorMsg;

  AuthGenericFailureState(this.errorMsg);
}

class UserLogoutState extends AuthStates {
  final String? userId;
  UserLogoutState({this.userId});
}
