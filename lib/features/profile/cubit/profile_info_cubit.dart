import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/errors/auth_exceptions_handler.dart';
import 'package:chaty/features/profile/data/models/user_model.dart';
import 'package:chaty/features/profile/data/repos/profile_info_repo.dart';

part 'profile_info_states.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoStates> {
  ProfileInfoCubit({required this.profileInfoRepo})
      : super(ProfileInfoInitialState());
  final ProfileInfoRepo profileInfoRepo;
  static ProfileInfoCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  bool isShouldPopLoading = false;

  Future<void> createNewUserProfile({required UserModel user}) async {
    emit(ProfileInfoLoadingState());
    var result = await profileInfoRepo.createNewUserProfile(userModel: user);
    result.fold((errorStatus) {
      var errorMsg = AuthExceptionHandler.generateExceptionMessage(errorStatus);
      emit(ProfileInfoFailureState(errorMsg: errorMsg));
    }, (userModel) {
      this.userModel = user = userModel;
      emit(ProfileInfoCreatedState(userModel: userModel));
    });
  }

  Future<void> updateUserProfile() async {
    emit(ProfileInfoLoadingState());
    var result = await profileInfoRepo.updateUserProfile(userModel: userModel!);
    result.fold((errorStatus) {
      var errorMsg = AuthExceptionHandler.generateExceptionMessage(errorStatus);
      emit(ProfileInfoFailureState(errorMsg: errorMsg));
    }, (userModel) {
      this.userModel = userModel;
      emit(ProfileInfoUpdatedState());
    });
  }

  Future<void> fetchUserProfileInfo() async {
    emit(ProfileInfoLoadingState());

    var result = await profileInfoRepo.fetchUserProfileInfo();
    result.fold((errorStatus) {
      var errorMsg = AuthExceptionHandler.generateExceptionMessage(errorStatus);
      emit(ProfileInfoFailureState(errorMsg: errorMsg));
    }, (userModel) {
      this.userModel = userModel;
      emit(ProfileInfoFetchedState(userModel: userModel));
    });
  }

  Future<void> uploadProfileImage(File imageFile) async {
    emit(ProfileInfoLoadingState());

    final result = await profileInfoRepo.uploadProfileImg(imageFile);
    result.fold((errorStatus) {
      var errorMsg = AuthExceptionHandler.generateExceptionMessage(errorStatus);
      emit(ProfileInfoFailureState(errorMsg: errorMsg));
    }, (downloadUrl) {
      userModel?.imageUrl = downloadUrl;
      emit(ProfileImgUploadedState());
    });
  }
}
