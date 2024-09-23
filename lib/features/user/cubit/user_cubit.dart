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
  UserModel currentUser = UserModel();
  final friendsList = <UserModel>[];
  List<UserModel> resultOfSearch = [];

  Future<void> setNewUserProfile({required UserModel user}) async {
    emit(UserLoadingState());
    var result = await userRepo.createNewUserProfile(userModel: user);
    result.fold((errorStatus) {
      var errorMsg = ExceptionHandler.getExpMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (userModel) {
      currentUser = user = userModel;
      emit(UserCreatedState(userModel: userModel));
    });
  }

  Future<void> updateUserProfile() async {
    emit(UserLoadingState());
    var result = await userRepo.updateUserProfile(userModel: currentUser);
    result.fold((errorStatus) {
      var errorMsg = ExceptionHandler.getExpMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (userModel) {
      currentUser = userModel;
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
      currentUser = userModel;
      emit(UserFetchedState(userModel: userModel));
    });
  }

  Future<void> fetchAllUserFriends() async {
    emit(UserLoadingState());

    var result = await userRepo.fetchAllFriends(
      (currentUser) {
        this.currentUser = currentUser;
        emit(UserFetchedState(userModel: currentUser));
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
      currentUser.imageUrl = downloadUrl;
      emit(UserUploadProfileImgState());
    });
  }

  Future<void> setUserDeviceToken({required String token}) async {
    var result = await userRepo.setUserDeviceToken(token);
    result.fold((errorStatus) {
      var errorMsg = ExceptionHandler.getExpMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (msg) {
      emit(UserUpdatedState());
    });
  }

  Future<String?> getRecipientDeviceToken({required String recipientId}) async {
    String? recipientToken;
    var result = await userRepo.getRecipientDeviceToken(recipientId);
    result.fold((errorStatus) {
      var errorMsg = ExceptionHandler.getExpMessage(errorStatus);
      emit(UserFailureState(errorMsg: errorMsg));
    }, (token) {
      return recipientToken = token;
    });
    return recipientToken;
  }

  void searchForFriend(String text) {
    final lowerCaseText = text.toLowerCase();

    if (lowerCaseText.isEmpty) {
      resultOfSearch.clear();
      emit(UserLoadAllFriendsState());
      return;
    }

    resultOfSearch = friendsList.where((element) {
      final name = element.name?.toLowerCase();
      return name != null && name.contains(lowerCaseText);
    }).toList();

    emit(UserSearchState());
  }
}
