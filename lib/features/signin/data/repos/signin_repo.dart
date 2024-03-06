import 'package:dartz/dartz.dart';
import 'package:flutter_firebase/core/errors/exp_enum.dart';
import 'package:flutter_firebase/features/profile/data/models/user_model.dart';

abstract class SignInRepo {
  Future<Either<AuthExceptionsTypes, UserModel?>> signInWithGoogle(
      {required UserModel userModel});

  Future<Either<AuthExceptionsTypes, UserModel>> signUpWithEmail(
      {required String email, required String password});

  Future<Either<AuthExceptionsTypes, UserModel?>> signInWithEmailPass(
      {required String email, required String password});

  Future<Either<AuthExceptionsTypes, bool>> resetUserPassword(
      {required String email});

  Future<Either<AuthExceptionsTypes, bool>> submitUserPhoneNumber(
      {required String phoneNumber,
      required Function(String verifyCode) setVerificationCode,
      required Function() verificationFailed});

  Future<Either<AuthExceptionsTypes, UserModel?>> signInWithPhoneNumber(
      {required String otpCode,
      required String verificationId,
      required UserModel userModel});
}