import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';

class ProfileBio extends StatelessWidget {
  const ProfileBio({super.key, required this.pioTxtController});
  final TextEditingController pioTxtController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileCubit = UserCubit.get(context);
    return Card(
      color: theme.colorScheme.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16),
            child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.secondary,
                )),
          ),
          Expanded(
            child: CustomTextInputField(
              textEditingController: pioTxtController,
              initText: profileCubit.userModel?.bio ?? dummyBio,
              maxLines: 5,
              height:
                  setProfileBioHight(profileCubit.userModel?.bio ?? dummyBio),
              onSubmitted: (value) async {
                profileCubit.userModel?.bio = value;
                await profileCubit.updateUserProfile();
              },
            ),
          ),
        ],
      ),
    );
  }

  double setProfileBioHight(String bio) {
    if (bio.length > 60) {
      return 125;
    }
    return 60;
  }
}
