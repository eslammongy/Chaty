import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/core/utils/helper.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_firebase/core/constants/app_assets.dart';
import 'package:flutter_firebase/features/profile/presentation/cubit/profile_info_cubit.dart';
import 'package:flutter_firebase/features/profile/presentation/view/widgets/pick_image_sheet.dart';

class ProfileImageSection extends StatefulWidget {
  const ProfileImageSection({super.key, required this.profileImgUrl});
  final String? profileImgUrl;

  @override
  State<ProfileImageSection> createState() => _ProfileImageSectionState();
}

class _ProfileImageSectionState extends State<ProfileImageSection> {
  File? selectedImg;
  @override
  void initState() {
    super.initState();
    fetchProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileCubit = ProfileInfoCubit.get(context);
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
              : _cachedNetworkImg(roundedShape),
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
                    final imgFile = await _pickImageFromCamera();
                    if (imgFile != null) {
                      selectedImg = File(imgFile.path);
                      await _updateProfileInfo(profileCubit);
                    }
                  },
                  onGalleryTap: () async {
                    //* close the bottom sheet
                    GoRouter.of(context).pop();
                    final imgFile = await _pickGalleryImage();
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

  Future<void> _updateProfileInfo(ProfileInfoCubit profileCubit) async {
    await profileCubit.uploadProfileImage(selectedImg!).then((value) async {
      await profileCubit.updateUserProfile();
    });
  }

  Future displayPickGalleryImg(
      XFile imgFile, ProfileInfoCubit profileCubit) async {
    Future(() {
      displayPickImageDialog(
        context,
        imgFile.path,
        onConfirm: () async {
          selectedImg = File(imgFile.path);
          profileCubit.userModel?.imageUrl = selectedImg?.path;
          await _updateProfileInfo(profileCubit);
        },
      );
    });
  }

  CachedNetworkImage _cachedNetworkImg(RoundedRectangleBorder roundedShape) {
    return CachedNetworkImage(
      imageUrl: widget.profileImgUrl ?? dummyImageUrl,
      imageBuilder: (context, imageProvider) => Card(
        shape: roundedShape,
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        child: CircleAvatar(
          radius: 80,
          backgroundImage: imageProvider,
        ),
      ),
      placeholder: (context, url) => Card(
        shape: roundedShape,
        margin: EdgeInsets.zero,
        child: CircleAvatar(
          radius: 80,
          child: Image.asset(AppAssetsManager.firebaseLogo),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  /// pick an image fromGallery
  Future<XFile?> _pickGalleryImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return null;

      return pickedFile;
    } on Exception catch (e) {
      Future(() {
        displaySnackBar(context, e.toString());
      });
    }
    return null;
  }

  /// pick an image from camera
  Future<XFile?> _pickImageFromCamera() async {
    try {
      final pickedImg =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImg == null) return null;
      return pickedImg;
    } on Exception catch (e) {
      Future(() {
        displaySnackBar(context, e.toString());
      });
    }
    Future(() => GoRouter.of(context).pop());
    return null;
  }

  Future fetchProfileInfo() async {
    if (FirebaseAuth.instance.currentUser == null) return;
    await ProfileInfoCubit.get(context).fetchUserProfileInfo();
  }
}
