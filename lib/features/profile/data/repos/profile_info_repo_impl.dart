import 'dart:io';
import 'profile_info_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase/core/errors/exp_enum.dart';
import 'package:flutter_firebase/core/errors/auth_exceptions_handler.dart';
import 'package:flutter_firebase/features/profile/data/models/user_model.dart';

class ProfileInfoRepoImpl implements ProfileInfoRepo {
  final FirebaseAuth firebaseAuth;
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref("users");

  ProfileInfoRepoImpl({required this.firebaseAuth});

  @override
  Future<Either<AuthExceptionsTypes, UserModel>> createNewUserProfile(
      {required UserModel userModel}) async {
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
      final deviceId = getUniqueDeviceId();
      final userName = FirebaseAuth.instance.currentUser?.displayName ?? "NONE";
      String? fileName = "${userName}_$deviceId";
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('profile_images/$fileName');
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

  Future<String> getUniqueDeviceId() async {
    String uniqueDeviceId = '';

    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId =
          '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}';
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      uniqueDeviceId = '${androidDeviceInfo.model}:${androidDeviceInfo.id}';
    }

    return uniqueDeviceId;
  }
}
