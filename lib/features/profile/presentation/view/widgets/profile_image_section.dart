import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_firebase/core/utils/helper.dart';
import 'package:flutter_firebase/core/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _image != null
              ? CircleAvatar(radius: 80, backgroundImage: MemoryImage(_image!))
              : CachedNetworkImage(
                  imageUrl: userModel?.imageUrl ?? dummyImageUrl,
                  imageBuilder: (context, imageProvider) => const CircleAvatar(
                    radius: 80,
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
          Positioned(
            bottom: 5,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo_rounded,
                size: 28,
                color: theme.colorScheme.secondary,
              ),
              onPressed: () {
                showImagePickerOption(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
        backgroundColor: theme.colorScheme.surface,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickGalleryImage(context);
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
    //  Future(() => GoRouter.of(context).pop());
  }
}
