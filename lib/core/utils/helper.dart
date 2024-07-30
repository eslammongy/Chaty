import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:chaty/core/widgets/loading_state_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/users/view/widgets/custom_text_btn.dart';

/// this is the default box shadow for the card items
get defBoxShadows => [
      BoxShadow(
        color: const Color(0xFF000000).withOpacity(0.8),
        blurRadius: 1,
        spreadRadius: 0,
        offset: const Offset(2, 2), // vertical shadow distance
      ),
    ];

/// define the public rounded radius in all project
get publicRoundedRadius => BorderRadius.circular(14);

/// displaying a customized snackbar
void displaySnackBar(BuildContext context, String msg,
    {bool isFailState = true}) {
  final theme = Theme.of(context);
  final snackBar = SnackBar(
    content: Text(
      msg,
      style: theme.textTheme.bodyMedium,
    ),
    margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor:
        isFailState ? theme.colorScheme.error : theme.colorScheme.primary,
    duration: const Duration(milliseconds: 2000),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// Shows a loading dialog in the given [BuildContext].
///
/// The [context] parameter is the [BuildContext] in which the dialog is shown.
// This function does not return anything./*
showLoadingDialog(BuildContext context, {String text = "please wait..."}) {
  return showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      barrierColor: Colors.grey.withOpacity(0.3),
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 85.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: LoadingStateUI(
            text: text,
          ),
        );
      });
}

/// Checks if the given [value] is a valid email address.
/// The [value] parameter should be a string representing the email address to validate.
/// Returns `true` if the [value] is a valid email address, `false` otherwise.
bool isValidEmail(String value) {
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

Future<void> displayPickImageDialog(
  BuildContext context,
  String imgPath, {
  Function()? onConfirm,
}) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.info_outlined),
              SizedBox(
                width: 6,
              ),
              Text('Select Image'),
            ],
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          content: SizedBox(
            height: 280,
            width: 320,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(imgPath),
                width: 200,
                height: 200,
              ),
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: <Widget>[
            CustomTextBtn(
              text: "Cancel",
              isCancel: true,
              onPresses: () {
                Navigator.of(context).pop();
              },
            ),
            CustomTextBtn(
              text: "Select",
              onPresses: onConfirm,
            ),
          ],
        );
      });
}

void displayToastMsg(
  BuildContext context,
  String msg, {
  ToastificationType? type,
  Alignment alignment = Alignment.bottomCenter,
}) {
  final theme = Theme.of(context);
  toastification.show(
    context: context,
    title: Text(
      msg,
      style: theme.textTheme.titleMedium,
    ),
    type: type ?? ToastificationType.info,
    style: ToastificationStyle.simple,
    borderSide: BorderSide.none,
    alignment: alignment,
    backgroundColor: type != null ? Colors.red : theme.colorScheme.secondary,
    autoCloseDuration: const Duration(seconds: 2),
  );
}

/// Generates a chat ID by Ensure the order is consistent by comparing the user IDs
/// Returns the generated chat ID as a string.
String generateChatId({required String userId, required String participantId}) {
  final listOfIds = [userId, participantId]..sort();
  final String chatId =
      listOfIds.fold("", (userId, participantId) => "$userId$participantId");
  return chatId;
}

String getDateTime(DateTime dateTime) {
  // final formattedDate = DateFormat.yMMMEd().format(dateTime);
  final formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}

String getMsgDateOnly(DateTime dateTime) {
  final formattedDate = DateFormat.yMd().format(dateTime);
  return formattedDate;
}

LinearProgressIndicator displayLinearIndicator(ThemeData theme) {
  return LinearProgressIndicator(
    color: theme.colorScheme.primary,
    backgroundColor: theme.colorScheme.surface,
    minHeight: 8,
    borderRadius: BorderRadius.circular(10),
  );
}
