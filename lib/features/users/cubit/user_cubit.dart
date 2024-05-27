import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/features/users/data/repos/user_repo.dart';
import 'package:chaty/core/errors/auth_exceptions_handler.dart';
import 'package:chaty/features/users/data/models/user_model.dart';

part 'user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit({required this.userRepo}) : super(UserInitialState());
  final UserRepo userRepo;
  static UserCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  final friendsList = <UserModel>[];
  bool isShouldPopLoading = false;

  Future<void> createNewUserProfile({required UserModel user}) async {
    emit(UserLoadingState());
    var result = await userRepo.createNewUserProfile(userModel: user);
    result.fold((errorStatus) {
      var errorMsg = AuthExceptionHandler.generateExceptionMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (userModel) {
      this.userModel = user = userModel;
      emit(UserCreatedState(userModel: userModel));
    });
  }

  Future<void> updateUserProfile() async {
    emit(UserLoadingState());
    var result = await userRepo.updateUserProfile(userModel: userModel!);
    result.fold((errorStatus) {
      var errorMsg = AuthExceptionHandler.generateExceptionMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (userModel) {
      this.userModel = userModel;
      emit(UserUpdatedState());
    });
  }

  Future<void> fetchUserInfo() async {
    emit(UserLoadingState());

    var result = await userRepo.fetchUserProfileInfo();
    result.fold((errorStatus) {
      var errorMsg = AuthExceptionHandler.generateExceptionMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (userModel) {
      this.userModel = userModel;
      emit(UserFetchedState(userModel: userModel));
    });
  }

  Future<void> fetchAllFriends() async {
    emit(UserLoadingState());

    var result = await userRepo.fetchAllFriends(
      (currentUser) {
        userModel = currentUser;
        debugPrint("Current User : ${userModel?.name}");
        emit(UserFetchedState(userModel: userModel));
      },
    );
    result.fold((errorStatus) {
      var errorMsg = AuthExceptionHandler.generateExceptionMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (friends) {
      friendsList.addAll(friends);
      emit(UserLoadAllFriendsState());
    });
  }

  Future<void> uploadProfileImage(File imageFile) async {
    emit(UserLoadingState());

    final result = await userRepo.uploadProfileImg(imageFile);
    result.fold((errorStatus) {
      var errorMsg = AuthExceptionHandler.generateExceptionMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (downloadUrl) {
      userModel?.imageUrl = downloadUrl;
      emit(ProfileImgUploadedState());
    });
  }
}
