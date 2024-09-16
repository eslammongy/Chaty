import 'package:flutter/material.dart';

void showImagePickerOption(
  BuildContext context, {
  required Function() onGalleryTap,
  required Function() onCameraTap,
}) {
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
                _pickImageOption(
                  theme,
                  title: "Gallery",
                  icon: Icons.image_rounded,
                  onTap: onGalleryTap,
                ),
                _pickImageOption(
                  theme,
                  title: "Camera",
                  icon: Icons.camera_rounded,
                  onTap: onCameraTap,
                ),
              ],
            ),
          ),
        );
      });
}

_pickImageOption(
  ThemeData theme, {
  required String title,
  required Function() onTap,
  required IconData icon,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            color: theme.colorScheme.primary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                size: 50,
              ),
            ),
          ),
          Text(
            title,
            style: theme.textTheme.titleMedium,
          )
        ],
      ),
    ),
  );
}
