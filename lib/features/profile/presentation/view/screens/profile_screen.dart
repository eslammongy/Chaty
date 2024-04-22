import 'package:sizer/sizer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/core/utils/helper.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/features/profile/presentation/view_model/profile_info_cubit.dart';
import 'package:flutter_firebase/features/signin/presentation/view/widgets/custom_text_button.dart';
import 'package:flutter_firebase/features/profile/presentation/view/widgets/profile_image_section.dart';
import 'package:flutter_firebase/features/signin/presentation/view/widgets/custom_text_input_filed.dart';
import 'package:flutter_firebase/features/profile/presentation/view/widgets/profile_info_field_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileInfoCubit.get(context);
    final theme = Theme.of(context);
    final pioTxtController = TextEditingController();
    final nameTxtController = TextEditingController();
    final phoneTxtController = TextEditingController();
    final emailTxtController = TextEditingController();

    return BlocConsumer<ProfileInfoCubit, ProfileInfoStates>(
      listener: (context, state) {
        if (state is ProfileInfoLoadingState) {
          showLoadingDialog(context);
        }
        if (state is ProfileInfoFetchedState ||
            state is ProfileInfoUpdatedState ||
            state is ProfileInfoCreatedState) {
          //* dismiss the loading dialog
          GoRouter.of(context).pop();
        }
        if (state is ProfileInfoFailureState) {
          //* dismiss the loading dialog
          GoRouter.of(context).pop();
          displaySnackBar(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        return BlocBuilder<ProfileInfoCubit, ProfileInfoStates>(
          builder: (context, state) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      ProfileImageSection(
                        profileImgUrl: profileCubit.userModel?.imageUrl,
                      ),
                      const SizedBox(height: 20),
                      _buildBioSection(theme, pioTxtController),
                      const SizedBox(height: 20),
                      ProfileInfoFieldItem(
                        text: profileCubit.userModel?.name ?? dummyName,
                        textController: nameTxtController,
                        icon: FontAwesomeIcons.user,
                      ),
                      const SizedBox(height: 15),
                      ProfileInfoFieldItem(
                        text: profileCubit.userModel?.email ?? dummyEmail,
                        textController: emailTxtController,
                        icon: FontAwesomeIcons.envelope,
                      ),
                      const SizedBox(height: 15),
                      ProfileInfoFieldItem(
                        text: profileCubit.userModel?.phone ?? dummyPhone,
                        textController: phoneTxtController,
                        icon: FontAwesomeIcons.phone,
                      ),
                      const SizedBox(height: 45),
                      CustomTextButton(
                        backgroundColor: theme.colorScheme.primary,
                        text: "Save",
                        onPressed: () async {
                          profileCubit.userModel?.name = nameTxtController.text;
                          profileCubit.userModel?.bio = pioTxtController.text;
                          profileCubit.userModel?.email =
                              emailTxtController.text;
                          profileCubit.userModel?.phone =
                              phoneTxtController.text;
                          await profileCubit.updateUserProfile();
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Card _buildBioSection(
      ThemeData theme, TextEditingController pioTxtController) {
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
              initText: dummyBio,
              maxLines: 5,
              height: 130,
            ),
          ),
        ],
      ),
    );
  }
}
