import 'package:dartz/dartz.dart';
import 'package:chaty/core/errors/exp_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chaty/features/users/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<FirebaseExpTypes, UserModel>> signInWithGoogle();

  Future<Either<FirebaseExpTypes, UserModel>> signUpWithEmail(
      {required String email, required String password});

  Future<Either<FirebaseExpTypes, UserModel>> signInWithEmailPass(
      {required String email, required String password});

  Future<Either<FirebaseExpTypes, bool>> submitUserPhoneNumber({
    required String phoneNumber,
    required Function(String verifyCode) setVerificationCode,
    required Function(FirebaseAuthException authException) verificationFailed,
  });

  Future<Either<FirebaseExpTypes, UserModel>> signInWithPhoneNumber({
    required String otpCode,
    required String verificationId,
  });

  Future<Either<FirebaseExpTypes, String?>> logout();
  Future<Either<FirebaseExpTypes, String?>> resetUserPassword(
      {required String email});
}
