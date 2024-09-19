import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:chaty/core/errors/exp_enum.dart';
import 'package:chaty/features/user/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<ExceptionsType, UserModel>> createNewUserProfile({
    required UserModel userModel,
  });
  Future<Either<ExceptionsType, UserModel>> updateUserProfile({
    required UserModel userModel,
  });
  Future<Either<ExceptionsType, UserModel>> fetchUserProfileInfo();
  Future<Either<ExceptionsType, List<UserModel>>> fetchAllFriends(
    Function(UserModel currentUser)? setCurrentUser,
  );
  Future<Either<ExceptionsType, String>> uploadProfileImg(File imageFile);
  Future<Either<ExceptionsType, String>> setUserDeviceToken(String token);
}
