import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chaty/core/errors/exp_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chaty/features/auth/data/repos/auth_repo.dart';
import 'package:chaty/core/errors/auth_exceptions_handler.dart';
import 'package:chaty/features/users/data/models/user_model.dart';

class AuthRepoImplementation implements AuthRepo {
  FirebaseAuth firebaseAuth;
  AuthRepoImplementation({
    required this.firebaseAuth,
  });

  @override
  Future<Either<AuthExceptionsTypes, UserModel>> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? authentication =
          await googleAccount?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication?.idToken,
          accessToken: authentication?.accessToken);
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      if (userCredential.user == null) {
        return left(AuthExceptionsTypes.undefined);
      }
      final userModel = _fillUserModel(userCredential.user!);
      return right(userModel);
    } on PlatformException catch (ex) {
      return left(AuthExceptionHandler.handleException(ex.message));
    } on FirebaseAuthException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    }
  }

  UserModel _fillUserModel(User user) {
    final userModel = UserModel(
        uId: user.uid,
        name: user.displayName,
        email: user.email,
        imageUrl: user.photoURL,
        phone: user.phoneNumber);
    return userModel;
  }

  @override
  Future<Either<AuthExceptionsTypes, UserModel>> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user == null) {
        return left(AuthExceptionsTypes.undefined);
      }
      final userModel = UserModel(
          uId: userCredential.user?.uid, email: email, password: password);
      return right(userModel);
    } on FirebaseAuthException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(AuthExceptionsTypes.undefined);
    }
  }

  @override
  Future<Either<AuthExceptionsTypes, UserModel>> signInWithEmailPass(
      {required String email, required String password}) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user == null) {
        return left(AuthExceptionsTypes.undefined);
      }
      final userModel = _fillUserModel(userCredential.user!);
      return right(userModel);
    } on FirebaseAuthException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(
          AuthExceptionHandler.handleException(AuthExceptionsTypes.undefined));
    }
  }

  @override
  Future<Either<AuthExceptionsTypes, bool>> submitUserPhoneNumber({
    required String phoneNumber,
    required Function(String verifyCode) setVerificationCode,
    required Function(FirebaseAuthException authException) verificationFailed,
  }) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {},
        timeout: const Duration(seconds: 30),
        codeSent: (verificationId, reSendCode) {
          debugPrint("SignIn Repo verification Code: $verificationId");
          setVerificationCode(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setVerificationCode(verificationId);
        },
        verificationFailed: verificationFailed,
      );
      return right(true);
    } on FirebaseAuthException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(AuthExceptionsTypes.undefined);
    }
  }

  @override
  Future<Either<AuthExceptionsTypes, UserModel>> signInWithPhoneNumber({
    required String otpCode,
    required String verificationId,
  }) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpCode);

      final userCredential =
          await firebaseAuth.signInWithCredential(phoneAuthCredential);

      if (userCredential.user == null) {
        return left(AuthExceptionsTypes.undefined);
      }

      final userModel = _fillUserModel(userCredential.user!);
      return right(userModel);
    } on FirebaseAuthException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(AuthExceptionsTypes.undefined);
    }
  }

  @override
  Future<Either<AuthExceptionsTypes, String?>> logout() async {
    try {
      final userId = firebaseAuth.currentUser?.uid;
      await firebaseAuth.signOut();
      return right(userId);
    } on FirebaseAuthException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(AuthExceptionsTypes.undefined);
    }
  }

  @override
  Future<Either<AuthExceptionsTypes, String?>> resetUserPassword(
      {required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return right(email);
    } on FirebaseAuthException catch (error) {
      return left(AuthExceptionHandler.handleException(error.code));
    } catch (error) {
      return left(AuthExceptionsTypes.undefined);
    }
  }
}
