import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/core/widgets/cache_network_image.dart';
import 'package:chaty/features/users/view/widgets/pick_image_sheet.dart';

class ProfileImageSection extends StatefulWidget {
  const ProfileImageSection({super.key, required this.profileImgUrl});
  final String profileImgUrl;

  @override
  State<ProfileImageSection> createState() => _ProfileImageSectionState();
}

class _ProfileImageSectionState extends State<ProfileImageSection> {
  File? selectedImg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileCubit = UserCubit.get(context);
    final roundedShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
        side: const BorderSide(width: 2, color: Colors.white));
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          selectedImg != null
              ? Card(
                  margin: EdgeInsets.zero,
                  shape: roundedShape,
                  child: CircleAvatar(
                      radius: 80, backgroundImage: FileImage(selectedImg!)))
              : CacheNetworkImg(
                  imgUrl: widget.profileImgUrl,
                ),
          Positioned(
            bottom: 5,
            right: 0,
            child: IconButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white, elevation: 0),
              icon: Icon(
                Icons.add_a_photo_rounded,
                color: theme.colorScheme.secondary,
              ),
              onPressed: () {
                showImagePickerOption(
                  context,
                  onCameraTap: () async {
                    //* close the bottom sheet
                    GoRouter.of(context).pop();
                    final imgFile = await pickImageFromCamera(context);
                    if (imgFile != null) {
                      selectedImg = File(imgFile.path);
                      await _updateProfileInfo(profileCubit);
                    }
                  },
                  onGalleryTap: () async {
                    //* close the bottom sheet
                    GoRouter.of(context).pop();
                    final imgFile = await pickGalleryImage(context);
                    if (imgFile != null) {
                      await displayPickGalleryImg(imgFile, profileCubit);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfileInfo(UserCubit profileCubit) async {
    await profileCubit.uploadProfileImage(selectedImg!).then((value) async {
      await profileCubit.updateUserProfile();
    });
  }

  Future displayPickGalleryImg(XFile imgFile, UserCubit profileCubit) async {
    Future(() {
      displayPickImageDialog(
        context,
        imgFile.path,
        onConfirm: () async {
          selectedImg = File(imgFile.path);
          profileCubit.userModel?.imageUrl = selectedImg?.path;
          GoRouter.of(context).pop();
          await _updateProfileInfo(profileCubit);
        },
      );
    });
  }
}
