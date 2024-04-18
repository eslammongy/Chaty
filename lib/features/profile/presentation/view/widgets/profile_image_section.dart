import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_firebase/core/utils/helper.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_firebase/core/constants/app_assets.dart';
import 'package:flutter_firebase/features/profile/presentation/view/widgets/pick_image_sheet.dart';
import 'package:flutter_firebase/features/profile/presentation/view_model/profile_info_cubit.dart';

class ProfileImageSection extends StatefulWidget {
  const ProfileImageSection({super.key});

  @override
  State<ProfileImageSection> createState() => _ProfileImageSectionState();
}

class _ProfileImageSectionState extends State<ProfileImageSection> {
  Uint8List? _image;
  File? selectedIMage;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userModel = ProfileInfoCubit.get(context).userModel;
    final roundedShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
        side: const BorderSide(width: 2, color: Colors.white));
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _image != null
              ? Card(
                  margin: EdgeInsets.zero,
                  shape: roundedShape,
                  child: CircleAvatar(
                      radius: 80, backgroundImage: MemoryImage(_image!)))
              : CachedNetworkImage(
                  imageUrl: userModel?.imageUrl ?? dummyImageUrl,
                  imageBuilder: (context, imageProvider) => Card(
                    shape: roundedShape,
                    margin: EdgeInsets.zero,
                    child: const CircleAvatar(
                      radius: 80,
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
                  onCameraTap: () async => await _pickImageFromCamera(),
                  onGalleryTap: () async => await _pickGalleryImage(
                    context,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// pick an image fromGallery
  Future<void> _pickGalleryImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 250,
        maxHeight: 250,
      );
      if (context.mounted) {
        if (pickedFile == null) return;
        await displayPickImageDialog(
          context,
          pickedFile.path,
          onPressed: () async {
            setState(() {
              selectedIMage = File(pickedFile.path);
              _image = File(pickedFile.path).readAsBytesSync();
            });
          },
        );
      }
    } on Exception catch (e) {
      Future(() {
        displaySnackBar(context, e.toString());
      });
    }
    Future(() => GoRouter.of(context).pop());
  }

  /// pick an image from camera
  Future _pickImageFromCamera() async {
    try {
      final returnImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (returnImage == null) return;
      setState(() {
        selectedIMage = File(returnImage.path);
        _image = File(returnImage.path).readAsBytesSync();
      });
    } on Exception catch (e) {
      Future(() {
        displaySnackBar(context, e.toString());
      });
    }
    Future(() => GoRouter.of(context).pop());
  }
}
