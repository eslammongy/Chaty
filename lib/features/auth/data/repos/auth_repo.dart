import 'package:dartz/dartz.dart';
import 'package:chaty/core/errors/exp_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chaty/features/users/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<ExceptionsType, UserModel>> signInWithGoogle();

  Future<Either<ExceptionsType, UserModel>> signUpWithEmail(
      {required String email, required String password});

  Future<Either<ExceptionsType, UserModel>> signInWithEmailPass(
      {required String email, required String password});

  Future<Either<ExceptionsType, bool>> submitUserPhoneNumber({
    required String phoneNumber,
    required Function(String verifyCode) setVerificationCode,
    required Function(FirebaseAuthException authException) verificationFailed,
  });

  Future<Either<ExceptionsType, UserModel>> signInWithPhoneNumber({
    required String otpCode,
    required String verificationId,
  });

  Future<Either<ExceptionsType, String?>> logout();
  Future<Either<ExceptionsType, String?>> resetUserPassword(
      {required String email});
}
