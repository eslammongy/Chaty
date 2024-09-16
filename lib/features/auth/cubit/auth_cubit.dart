import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/features/auth/data/repos/auth_repo.dart';
import 'package:chaty/core/errors/auth_exceptions_handler.dart';
import 'package:chaty/features/user/data/models/user_model.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit({required this.authRepo}) : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);
  final AuthRepo authRepo;

  Future<void> signInWithGoogleAccount() async {
    emit(AuthLoadingState());
    try {
      var result = await authRepo.signInWithGoogle();
      result.fold((errorCode) {
        var errorMsg = ExceptionHandler.getExpMessage(errorCode);
        emit(AuthGenericFailureState(errorMsg));
      }, (user) async {
        emit(SignInWithGoogleSuccessState(userModel: user));
      });
    } catch (exp) {
      final errorMsg = ExceptionHandler.getExpMessage(exp);
      debugPrint("SignIn CUBIT Error-$errorMsg");
      emit(AuthGenericFailureState(errorMsg));
    }
  }

  Future<void> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    var result =
        await authRepo.signUpWithEmail(email: email, password: password);
    result.fold((errorCode) {
      final errorMsg = ExceptionHandler.getExpMessage(errorCode);
      emit(AuthGenericFailureState(errorMsg));
    }, (userModel) async {
      userModel.name = name;
      emit(SignUpSuccessState(userModel: userModel));
    });
  }

  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    var result =
        await authRepo.signInWithEmailPass(email: email, password: password);
    result.fold((errorCode) {
      final errorMsg = ExceptionHandler.getExpMessage(errorCode);
      emit(AuthGenericFailureState(errorMsg));
    }, (userModel) async {
      emit(SignInSuccessState(userModel: userModel));
    });
  }

  Future resetUserPassword({required String email}) async {
    emit(AuthLoadingState());
    var result = await authRepo.resetUserPassword(email: email);
    result.fold((errorCode) {
      final errorMsg = ExceptionHandler.getExpMessage(errorCode);
      emit(AuthGenericFailureState(errorMsg));
    }, (email) {
      emit(UserResetPasswordState(email: email));
    });
  }

  Future<void> submitUserPhoneNumber(String phoneNumber) async {
    emit(AuthLoadingState());
    await authRepo.submitUserPhoneNumber(
      phoneNumber: phoneNumber,
      setVerificationCode: (verifyCode) {
        emit(PhoneNumberSubmittedState(verificationId: verifyCode));
      },
      verificationFailed: (authException) {
        final errorMsg = ExceptionHandler.getExpMessage(authException);
        emit(AuthGenericFailureState(errorMsg));
      },
    );
  }

  Future<void> signInWithPhoneNumber(
      String otpCode, String verificationId) async {
    emit(AuthLoadingState());

    var result = await authRepo.signInWithPhoneNumber(
      otpCode: otpCode,
      verificationId: verificationId,
    );
    result.fold((errorCode) {
      var errorMsg = ExceptionHandler.getExpMessage(errorCode);
      emit(AuthGenericFailureState(errorMsg));
    }, (userModel) async {
      emit(PhoneOtpCodeVerifiedState(userModel: userModel));
    });
  }

  Future<void> logout() async {
    emit(AuthLoadingState());
    var result = await authRepo.logout();
    result.fold((errorCode) {
      var errorMsg = ExceptionHandler.getExpMessage(errorCode);
      emit(AuthGenericFailureState(errorMsg));
    }, (userId) async {
      emit(UserLogoutState(userId: userId));
    });
  }
}
