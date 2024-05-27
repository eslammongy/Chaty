part of 'user_cubit.dart';

abstract class UserStates {
  final UserModel? userModel;

  UserStates({this.userModel});
}

class UserInitialState extends UserStates {
  UserInitialState();
}

class UserLoadingState extends UserStates {}

class UserCreatedState extends UserStates {
  UserCreatedState({super.userModel});
}

class ProfileImgUploadedState extends UserStates {
  ProfileImgUploadedState();
}

class UserUpdatedState extends UserStates {
  UserUpdatedState();
}

class UserFetchedState extends UserStates {
  UserFetchedState({
    super.userModel,
  });
}

class UserLoadAllFriendsState extends UserStates {
  UserLoadAllFriendsState();
}

class UserFailureState extends UserStates {
  final String errorMsg;

  UserFailureState({required this.errorMsg});
}
