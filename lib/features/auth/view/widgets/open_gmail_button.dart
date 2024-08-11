import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:chaty/features/users/view/widgets/custom_text_button.dart';

class OpenGmailButton extends StatelessWidget {
  const OpenGmailButton({super.key, required this.shouldVisible});
  final bool shouldVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: shouldVisible,
      child: buildTextBtnWidget(
        context,
        btnText: "Open Gmail",
        hasBorderSide: true,
        onPressed: () async {
          await openEmail(context);
        },
      ),
    );
  }

  Future<void> openEmail(BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        await _launchAndroidGmail();
      } else if (Platform.isIOS) {
        await _launchIOSMail(context, target: '', url: 'message://');
      }
    } on Exception catch (e) {
      Future(() => displaySnackBar(
            context,
            "something went wrong : ${e.toString()}",
          ));
    }
  }

  Future<void> _launchAndroidGmail() async {
    const AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.APP_EMAIL',
    );
    await intent.launch();
  }

  Future<void> _launchIOSMail(
    BuildContext context, {
    required String target,
    required String url,
  }) async {
    try {
      final Uri uri = Uri.parse('$url:$target');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } on Exception catch (e) {
      Future(() => displaySnackBar(
            context,
            "something went wrong : ${e.toString()}",
          ));
    }
  }
}
