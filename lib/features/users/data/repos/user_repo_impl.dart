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
  Future<Either<AuthExceptionsTypes, UserModel>> createNewUserProfile(
      {required UserModel userModel}) async {
    if (userModel.uId == null) {
      return left(AuthExceptionHandler.handleException(
          AuthExceptionsTypes.notValidUserInput));
    }
    try {
      await databaseReference
          .child(firebaseAuth.currentUser!.uid)
          .set(userModel.toMap());
      return right(userModel);
    } on FirebaseException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(AuthExceptionHandler.handleException(error));
    }
  }

  @override
  Future<Either<AuthExceptionsTypes, UserModel>> fetchUserProfileInfo() async {
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
    } on FirebaseException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(AuthExceptionHandler.handleException(error));
    }
  }

  @override
  Future<Either<AuthExceptionsTypes, UserModel>> updateUserProfile(
      {required UserModel userModel}) async {
    try {
      await databaseReference.ref
          .child(firebaseAuth.currentUser!.uid)
          .update(userModel.toMap());
      debugPrint("Update Profile ${firebaseAuth.currentUser!.uid} info Done");

      return right(userModel);
    } on FirebaseException catch (error) {
      debugPrint("Firebase Error : ${error.message}");
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      debugPrint("Other Error : $error");
      return left(AuthExceptionHandler.handleException(error));
    }
  }

  @override
  Future<Either<AuthExceptionsTypes, String>> uploadProfileImg(
      File imageFile) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('profile_images/$imgFileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return right(imageUrl);
    } on FirebaseException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(AuthExceptionHandler.handleException(error));
    }
  }

  String get imgFileName {
    final deviceId = FirebaseAuth.instance.currentUser?.uid;
    final userName = FirebaseAuth.instance.currentUser?.displayName ?? "NONE";
    return "${userName}_$deviceId";
  }

  @override
  Future<Either<AuthExceptionsTypes, List<UserModel>>> fetchAllFriends(
    Function(UserModel currentUser)? setCurrentUser,
  ) async {
    try {
      final dbEvent = await databaseReference.once();
      Map<dynamic, dynamic>? users =
          dbEvent.snapshot.value as Map<dynamic, dynamic>?;
      if (users == null) {
        return left(AuthExceptionHandler.handleException(
            AuthExceptionsTypes.userNotFound));
      }
      final friends = <UserModel>[];

      users.forEach((key, values) {
        if (key != firebaseAuth.currentUser!.uid) {
          friends.add(UserModel.fromJson(values as Map<String, dynamic>));
        } else {
          setCurrentUser
              ?.call(UserModel.fromJson(values as Map<String, dynamic>));
        }
      });
      return right(friends);
    } on FirebaseException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(AuthExceptionHandler.handleException(error));
    }
  }
}
