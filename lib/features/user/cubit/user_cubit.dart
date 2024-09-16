import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/features/user/data/repos/user_repo.dart';
import 'package:chaty/core/errors/auth_exceptions_handler.dart';
import 'package:chaty/features/user/data/models/user_model.dart';

part 'user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit({required this.userRepo}) : super(UserInitialState());
  final UserRepo userRepo;
  static UserCubit get(context) => BlocProvider.of(context);
  UserModel? user;
  final friendsList = <UserModel>[];

  Future<void> createNewUserProfile({required UserModel user}) async {
    emit(UserLoadingState());
    var result = await userRepo.createNewUserProfile(userModel: user);
    result.fold((errorStatus) {
      var errorMsg = ExceptionHandler.getExpMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (userModel) {
      this.user = user = userModel;
      emit(UserCreatedState(userModel: userModel));
    });
  }

  Future<void> updateUserProfile() async {
    emit(UserLoadingState());
    var result = await userRepo.updateUserProfile(userModel: user!);
    result.fold((errorStatus) {
      var errorMsg = ExceptionHandler.getExpMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (userModel) {
      user = userModel;
      emit(UserUpdatedState());
    });
  }

  Future<void> fetchUserInfo() async {
    emit(UserLoadingState());

    var result = await userRepo.fetchUserProfileInfo();
    result.fold((errorStatus) {
      var errorMsg = ExceptionHandler.getExpMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (userModel) {
      user = userModel;
      emit(UserFetchedState(userModel: userModel));
    });
  }

  Future<void> fetchAllUserFriends() async {
    emit(UserLoadingState());

    var result = await userRepo.fetchAllFriends(
      (currentUser) {
        user = currentUser;
        emit(UserFetchedState(userModel: user));
      },
    );
    result.fold((errorStatus) {
      var errorMsg = ExceptionHandler.getExpMessage(errorStatus);
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
      var errorMsg = ExceptionHandler.getExpMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (downloadUrl) {
      user?.imageUrl = downloadUrl;
      emit(ProfileImgUploadedState());
    });
  }
}
