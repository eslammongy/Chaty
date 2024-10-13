import 'dart:convert';
import 'dart:io';

import 'package:chaty/core/constants/fcm_constants.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:chaty/core/utils/user_pref.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class FCMService {
  static String userDeviceToken = "";
  static Future<void> getDeviceToken(BuildContext context) async {
    if (Platform.isAndroid) {
      userDeviceToken = await FirebaseMessaging.instance.getToken() ?? '';
      await SharedPref.saveFCMToken(token: userDeviceToken);
    }
    if (Platform.isIOS && context.mounted) {
      requestNotificationPermission(context);
    }
  }

  static bool get isDeviceHasToken {
    userDeviceToken = SharedPref.getFCMToken() ?? "";
    return userDeviceToken.isNotEmpty;
  }

  static Future<void> requestNotificationPermission(
    BuildContext context,
  ) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    final status = settings.authorizationStatus;

    if (status == AuthorizationStatus.authorized && context.mounted) {
      displaySnackBar(
        context,
        'User granted Notification permission',
        isFailState: false,
      );
      final token = await messaging.getToken();
      await SharedPref.saveFCMToken(token: token!);
    } else if (status == AuthorizationStatus.provisional && context.mounted) {
      displaySnackBar(
        context,
        'User granted provisional Notification permission',
        isFailState: false,
      );
      return;
    } else {
      if (context.mounted) {
        displaySnackBar(
          context,
          'User declined or has not accepted Notification permission',
        );
      }

      return;
    }
  }

// Handle foreground messages (when the app is open and running)
  static handleForegroundNotifications(BuildContext context) async {
    // Handle messages when the app is opened from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        if (context.mounted) {
          displaySnackBar(
            context,
            "New Message From ${message.notification!.title}",
            isFailState: false,
          );
        }
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      if (context.mounted) {
        displayToastMsg(
          context,
          "New Message From ${message.notification!.title}",
          alignment: Alignment.topCenter,
          type: ToastificationType.success,
        );
        handleForegroundMessage(context, message);
      }
    });
  }

  // Custom handler for foreground messages
  static void handleForegroundMessage(
    BuildContext context,
    RemoteMessage message,
  ) {
    final chatCubit = ChatCubit.get(context);
    final friends = UserCubit.get(context).friendsList;
    chatCubit.fetchAllUserChats(friends: friends);
  }

  static Future<String?> _getServerKey() async {
    try {
      http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(servicesAccountJson),
        scopes,
      );

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(servicesAccountJson),
        scopes,
        client,
      );

      client.close();
      debugPrint(
          "Access Token: ${credentials.accessToken.data}"); // debugPrint Access Token
      return credentials.accessToken.data;
    } catch (e) {
      debugPrint("Error getting access token: $e");
      return null;
    }
  }

  static Map<String, dynamic> _getBody({
    required recipientToken,
    required String sender,
    required String msg,
  }) {
    return {
      "message": {
        "token": recipientToken,
        "notification": {
          "title": sender,
          "body": msg,
        },
        "apns": {
          "payload": {
            "aps": {"category": "NEW_MESSAGE_CATEGORY"}
          }
        }
      }
    };
  }

  static Future<void> sendNotifications({
    required String sender,
    required String msg,
    required String recipientToken,
  }) async {
    try {
      var serverKeyAuthorization = await _getServerKey();
      final endPoint = Uri.parse(fcmEndPoint);
      final headers = {
        "'Content-Type": 'application/json',
        "Authorization": "Bearer $serverKeyAuthorization"
      };

      final http.Response response = await http.post(
        endPoint,
        headers: headers,
        body: jsonEncode(
          _getBody(
            recipientToken: recipientToken,
            sender: sender,
            msg: msg,
          ),
        ),
      );

      debugPrint('Response Data: ${response.body}');
    } catch (e) {
      debugPrint("Error sending notification: $e");
    }
  }

  static Future<void> handleSendingMsgNotification(
    ChatCubit chatCubit,
    UserCubit userCubit,
    MessageModel msg,
  ) async {
    final chat = chatCubit.openedChat;
    final userName = userCubit.currentUser.name ?? '';
    if (chat == null || chat.participants == null) {
      return;
    }
    final recipientId = chat.participants!.firstWhere(
      (element) => element != userCubit.currentUser.uId,
    );
    await userCubit
        .getRecipientDeviceToken(recipientId: recipientId)
        .then((token) async {
      debugPrint("recipient Token: $token");
      if (token == null) return;
      await sendingNewMsgNotification(userName, msg, token);
    });
  }

  static Future<void> sendingNewMsgNotification(
    String userName,
    MessageModel msg,
    String token,
  ) async {
    await FCMService.sendNotifications(
      sender: userName,
      msg: msg.msgType == MsgType.text ? msg.text! : "sent an image",
      recipientToken: token,
    );
  }
}
