import 'package:dartz/dartz.dart';
import 'package:flutter_firebase/errors/errors_enum.dart';
import 'package:flutter_firebase/signin/data/models/user_model.dart';

abstract class UserPhoneAuthRepo {
  Future<Either<AuthResultStatus, UserModel?>> userSignInWithPhoneNumber({required String otpCode, required String verificationId, required UserModel userModel});
}
