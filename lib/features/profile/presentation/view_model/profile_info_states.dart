// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_info_cubit.dart';

abstract class ProfileInfoStates {
  final UserModel? userModel;

  ProfileInfoStates({this.userModel});
}

class ProfileInfoInitialState extends ProfileInfoStates {
  ProfileInfoInitialState();
}

class ProfileInfoLoadingState extends ProfileInfoStates {}

class ProfileInfoCreatedState extends ProfileInfoStates {
  ProfileInfoCreatedState({super.userModel});
}

class ProfileImgUploadedState extends ProfileInfoStates {
  ProfileImgUploadedState();
}

class ProfileInfoUpdatedState extends ProfileInfoStates {
  ProfileInfoUpdatedState();
}

class ProfileInfoFetchedState extends ProfileInfoStates {
  ProfileInfoFetchedState({
    super.userModel,
  });
}

class ProfileInfoFailureState extends ProfileInfoStates {
  final String errorMsg;

  ProfileInfoFailureState({required this.errorMsg});
}
