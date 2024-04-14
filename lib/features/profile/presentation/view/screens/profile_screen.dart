import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/core/utils/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/features/profile/presentation/view_model/profile_info_cubit.dart';
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
                  Stack(children: [
                    CachedNetworkImage(
                      imageUrl: userModel?.image ??
                          "http://via.placeholder.com/200x150",
                      imageBuilder: (context, imageProvider) =>
                          const CircleAvatar(
                        radius: 60,
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_a_photo_rounded,
                          size: 28,
                          color: theme.colorScheme.secondary,
                        ),
                        onPressed: () async {
                          pickGalleryImage(context: context);
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Hi Johan, is there a repo anywhere that I can check my code against please. It all worked fine until I extracted the ProfileMenuItem code',
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
                    text: userModel?.name ?? 'John Doe',
                    textController: nameTxtController,
                    icon: FontAwesomeIcons.user,
                  ),
                  const SizedBox(height: 15),
                  ProfileInfoFieldItem(
                    text: userModel?.email ?? "QWk7z@example.com",
                    textController: emailTxtController,
                    icon: FontAwesomeIcons.envelope,
                  ),
                  const SizedBox(height: 15),
                  ProfileInfoFieldItem(
                    text: userModel?.phone ?? '+201234567890',
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
              'Update Info',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickGalleryImage({
    required BuildContext context,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 200,
    );
    try {
      if (context.mounted) {
        if (pickedFile != null) {
          await displayPickImageDialog(
            context,
            pickedFile.path,
            onPressed: () async {
              try {} catch (e) {
                rethrow;
              }
            },
          );
        } else {
          return;
        }
      }
    } on Exception catch (e) {
      Future(() {
        displaySnackBar(context, e.toString());
      });
    }
  }
}
