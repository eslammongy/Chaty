import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/features/profile/presentation/view_model/profile_info_cubit.dart';
import 'package:flutter_firebase/features/profile/presentation/view/widgets/profile_image_section.dart';
import 'package:flutter_firebase/features/profile/presentation/view/widgets/profile_info_field_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameTxtController = TextEditingController();
    final phoneTxtController = TextEditingController();
    final emailTxtController = TextEditingController();

    var userModel = ProfileInfoCubit.get(context).userModel;
    return Scaffold(
      body: BlocConsumer<ProfileInfoCubit, ProfileInfoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  const ProfileImageSection(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          dummyBio,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      Card(
                          color: theme.colorScheme.primary,
                          margin: EdgeInsets.zero,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.edit_note_rounded),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileInfoFieldItem(
                    text: userModel?.name ?? dummyName,
                    textController: nameTxtController,
                    icon: FontAwesomeIcons.user,
                  ),
                  const SizedBox(height: 15),
                  ProfileInfoFieldItem(
                    text: userModel?.email ?? dummyEmail,
                    textController: emailTxtController,
                    icon: FontAwesomeIcons.envelope,
                  ),
                  const SizedBox(height: 15),
                  ProfileInfoFieldItem(
                    text: userModel?.phone ?? dummyPhone,
                    textController: phoneTxtController,
                    icon: FontAwesomeIcons.phone,
                  ),
                  const SizedBox(height: 45),
                  buildUpdateInfoBtn(theme),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Card buildUpdateInfoBtn(ThemeData theme, {Function()? onTap}) {
    return Card(
      color: theme.colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: SizedBox(
          width: 200,
          height: 50,
          child: Center(
            child: Text(
              'Save',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}
