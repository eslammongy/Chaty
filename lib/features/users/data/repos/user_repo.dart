import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:chaty/core/errors/exp_enum.dart';
import 'package:chaty/features/users/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<FirebaseExpTypes, UserModel>> createNewUserProfile(
      {required UserModel userModel});
  Future<Either<FirebaseExpTypes, UserModel>> updateUserProfile(
      {required UserModel userModel});
  Future<Either<FirebaseExpTypes, UserModel>> fetchUserProfileInfo();
  Future<Either<FirebaseExpTypes, List<UserModel>>> fetchAllFriends(
    Function(UserModel currentUser)? setCurrentUser,
  );
  Future<Either<FirebaseExpTypes, String>> uploadProfileImg(File imageFile);
}
