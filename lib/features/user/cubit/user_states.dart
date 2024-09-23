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

class UserUploadProfileImgState extends UserStates {
  UserUploadProfileImgState();
}

class UserUpdatedState extends UserStates {
  UserUpdatedState();
}

class UserFetchedState extends UserStates {
  final String? token;
  UserFetchedState({
    super.userModel,
    this.token,
  });
}

class UserLoadAllFriendsState extends UserStates {
  UserLoadAllFriendsState();
}

class UserSearchState extends UserStates {
  UserSearchState();
}

class UserFailureState extends UserStates {
  final String errorMsg;

  UserFailureState({required this.errorMsg});
}
