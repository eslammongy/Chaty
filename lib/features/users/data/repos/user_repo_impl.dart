import 'dart:io';
import 'user_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:chaty/core/errors/exp_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:chaty/core/errors/auth_exceptions_handler.dart';
import 'package:chaty/features/users/data/models/user_model.dart';

class UserRepoImpl implements UserRepo {
  final FirebaseAuth firebaseAuth;
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref("users");

  UserRepoImpl({required this.firebaseAuth});

  @override
  Future<Either<ExceptionsType, UserModel>> createNewUserProfile(
      {required UserModel userModel}) async {
    if (userModel.uId == null) {
      return left(
          ExceptionHandler.handleException(ExceptionsType.notValidUserInput));
    }
    try {
      await databaseReference
          .child(firebaseAuth.currentUser!.uid)
          .set(userModel.toMap());
      return right(userModel);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ExceptionHandler.handleException(error.code));
      }
      return left(ExceptionHandler.handleException(error));
    }
  }

  @override
  Future<Either<ExceptionsType, UserModel>> fetchUserProfileInfo() async {
    try {
      final userModel = await databaseReference
          .child(firebaseAuth.currentUser!.uid)
          .once()
          .then((event) {
        debugPrint("User Model : ${event.snapshot.value}");
        return UserModel.fromJson(
            event.snapshot.value as Map<Object?, Object?>);
      });
      return right(userModel);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ExceptionHandler.handleException(error.code));
      }
      return left(ExceptionHandler.handleException(error));
    }
  }

  @override
  Future<Either<ExceptionsType, UserModel>> updateUserProfile(
      {required UserModel userModel}) async {
    try {
      await databaseReference.ref
          .child(firebaseAuth.currentUser!.uid)
          .update(userModel.toMap());
      debugPrint("Update Profile ${firebaseAuth.currentUser!.uid} info Done");

      return right(userModel);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ExceptionHandler.handleException(error.code));
      }
      return left(ExceptionHandler.handleException(error));
    }
  }

  @override
  Future<Either<ExceptionsType, String>> uploadProfileImg(
      File imageFile) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('profile_images/$imgFileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return right(imageUrl);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ExceptionHandler.handleException(error.code));
      }
      return left(ExceptionHandler.handleException(error));
    }
  }

  String get imgFileName {
    final deviceId = FirebaseAuth.instance.currentUser?.uid;
    final userName = FirebaseAuth.instance.currentUser?.displayName ?? "NONE";
    return "${userName}_$deviceId";
  }

  @override
  Future<Either<ExceptionsType, List<UserModel>>> fetchAllFriends(
    Function(UserModel currentUser)? setCurrentUser,
  ) async {
    try {
      final dbEvent = await databaseReference.once();
      final usersMap = dbEvent.snapshot.value as Map<dynamic, dynamic>?;

      if (usersMap == null) {
        return left(
            ExceptionHandler.handleException(ExceptionsType.userNotFound));
      }
      final friends = <UserModel>[];
      for (var entry in usersMap.entries) {
        if (entry.key != firebaseAuth.currentUser?.uid) {
          friends.add(UserModel.fromJson(entry.value as Map<Object?, Object?>));
        } else {
          setCurrentUser
              ?.call(UserModel.fromJson(entry.value as Map<Object?, Object?>));
        }
      }

      return right(friends);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ExceptionHandler.handleException(error.code));
      }
      return left(ExceptionHandler.handleException(error));
    }
  }
}
