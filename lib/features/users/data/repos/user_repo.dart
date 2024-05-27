import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:chaty/core/errors/exp_enum.dart';
import 'package:chaty/features/users/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<AuthExceptionsTypes, UserModel>> createNewUserProfile(
      {required UserModel userModel});
  Future<Either<AuthExceptionsTypes, UserModel>> updateUserProfile(
      {required UserModel userModel});
  Future<Either<AuthExceptionsTypes, UserModel>> fetchUserProfileInfo();
  Future<Either<AuthExceptionsTypes, List<UserModel>>> fetchAllFriends(
    Function(UserModel currentUser)? setCurrentUser,
  );
  Future<Either<AuthExceptionsTypes, String>> uploadProfileImg(File imageFile);
}
