import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chaty/core/utils/user_pref.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:chaty/core/constants/fcm_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static String userDeviceToken = "";
  static Future<void> checkDeviceToken() async {
    if (isDeviceHasToken) return;
    if (Platform.isAndroid) {
      final token = await FirebaseMessaging.instance.getToken();
      await SharedPref.saveFCMToken(token: token!);
    }
    if (Platform.isIOS) {
      requestNotificationPermission();
    }
  }

  static bool get isDeviceHasToken {
    userDeviceToken = SharedPref.getFCMToken() ?? "";
    return userDeviceToken.isNotEmpty;
  }

  static Future<void> requestNotificationPermission() async {
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

    if (status == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      final token = await messaging.getToken();
      await SharedPref.saveFCMToken(token: token!);
    } else if (status == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
      return;
    } else {
      debugPrint('User declined or has not accepted permission');
      return;
    }
  }

  /// handle notifications when received
  void handleMessages(RemoteMessage? message) {
    if (message != null) {
      // navigatorKey.currentState?.pushNamed(NotificationsScreen.routeName, arguments: message);
      /*    displayToastMsg(
          'on Background Message notification',
          state: ToastStates.SUCCESS); */
    }
  }

  /// handel notifications in case app is terminated
  void handleBackgroundNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
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

      // debugPrint response status code and body for debugging
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.body}');
    } catch (e) {
      debugPrint("Error sending notification: $e");
    }
  }
}
