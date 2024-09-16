import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chaty/core/utils/user_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  
  final servicesAccountJson = {
    "type": "service_account",
    "project_id": "chatty-dev990",
    "private_key_id": "3e4c575c53d4a04b4d5faf78036481acf5d3a6af",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDgTiyTwmfQ9XzQ\nbDiKmM3hLdmZPwacs5vEdsnjI4cz/rzxYYmvNg/vRZZXkVkCMJjn18bwRr/uAd+l\nJDBnncY1kl/qHjeM/1518qR49hS0iyanaSyGsgCXfimfGgBZUYlnQ74S0nkKNL+u\n+b53KYJcOqHHKXmwWMcIaVMwO6pWXZPCFKPM67jWwZVZu8SHVklE9Pd4uQ5PFqG1\nO3QqVpTpUkcpsOV+0NfIC3/UjtPwA79bC8SjmK9EmuXmXds+6QL6743vCvC99uX9\nU3RisTvYd5sfVYzOHYs1lXklk44s2BDPIA6ex0hMqeih6461RAp9/rHwhRb+FKkx\nRnzdnTlrAgMBAAECggEASC1PkdJmNqqv2Z9hSFPoN9PZp8LMnWL8NillSHY3vOb1\nJJUWyW8TjJJvUMlAA4DgywW3ibyyaONodErjWow96iIqQ/sqM/A+lKSaASRqQDhg\nnVEuFz+zCgx6Vyx2PUeL99MoGAVrFnonziWmANE2Ffh181Doy/KdRRsjPiuM4dIL\njlOheisOqdKW2AmNsahD+MQq1PgeRjy3fqP6fNt/Xb6L12rriUOQKSYWBi9r8jjg\nlEbjNu2FruWiVwongtaON+zE+PgLTJMfMAZGwsa3rpJ+P4ko/0dqPRvireEQUr3S\nnZD6l5njxQ5qOqFsVN3KXrGFTCAnax2x50VhAl91RQKBgQDyIvG8uh4sxZhRHPhl\nhRGTK8rqgqJ9wuS26vKQl03Ew4dpXFqLF1ElBdPjY2AlZbu1PJMkhoEZJcS1QMBE\nlBNoDbH4p/qmmfB8XunXVmdHNrMhTyACYnNRb3qmfWEe2i5iCaTnK7zVcOKR+55x\nFmaZk7g0zyl+KmdoZj9EonXUTQKBgQDtJd/aflUjqIFMgj5plfGV9YWDXEcLzlLz\nlK2FuKFMY/7QyghBYgdi6/9toS6PDhq50lcBdgi24q0rG/rllDx6qSCCvOsBquTR\n5M2FzPI5qijh3wa7KSFij8kwRCK/lyatSrDTf7uRpooZJSxoIl5mdqAZ8blE/U0V\nzuQiNREAlwKBgQCAgAMCQVOaNxLqmRFJ7yCwleEOK13ImBGA8ZbhHSrsbUgDpjt2\n7Vzm5PzaA/cWYbMIL6l3DNqeWejWuBJRUrQp2HrGl37xw2hY2JYI7ZXJuUG/P5qh\nKVZBtYPFr2xHT0qmRK/67r88Frhm+L3RDi5M+pQbkoVWq3JNeVXCOuWFUQKBgFjq\nJnBJhaqE91W0T6pO6fGLyK9j3c9zYG6rhBPrEa8Onu+xkD7Tfml8ipyUHlzMsQCS\n+MQ3eTT48GyFZSDG35Yt616ZbpOFe52m59gO65LrVcC6Wk+6MCZAOvK52T10cq/u\nnTXvYmhNxOGAqpGwsSxBte2EUC6pukk+9RJOSz2pAoGAFyrn3pQu0rXGrZfgYhfK\nl2c3+eMbQyNwS6EnFx3JuQ5QRePIam+4d76VbCldsBwv3W7HfWRs1ctIZv3YGm+5\n7eQWksiTI/+DgiNMmGP0nndUJAQU4wz5sPd8Ge9VKidnjUvjCZHOX59RIPlXA3PG\nnc7mowZ1VYhf5a3ij5ClpmE=\n-----END PRIVATE KEY-----\n",
    "client_email":
        "chatty-dev-eslammongy@chatty-dev990.iam.gserviceaccount.com",
    "client_id": "101384942834602942988",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/chatty-dev-eslammongy%40chatty-dev990.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };

  List<String> scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/firebase.database",
    "https://www.googleapis.com/auth/firebase.messaging"
  ];

  static Future<void> getDeviceToken() async {
    if (isFCMTokenSaved != null) return;
    if (Platform.isAndroid) {
      final token = await FirebaseMessaging.instance.getToken();
      await SharedPref.saveFCMToken(token: token!);
    }
    if (Platform.isIOS) {
      _checkNotificationPermission();
    }
  }

  static String? get isFCMTokenSaved {
    final token = SharedPref.getFCMToken();
    return token;
  }

  static Future<void> _checkNotificationPermission() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission();
    final status = settings.authorizationStatus;

    if (isPermissionDenied(status)) {
      debugPrint('User declined or has not accepted permission');
      return;
    } else {
      debugPrint('User granted permission');
      final token = await firebaseMessaging.getToken();
      await SharedPref.saveFCMToken(token: token!);
    }
  }

  static bool isPermissionDenied(AuthorizationStatus status) {
    return status == AuthorizationStatus.denied ||
        status == AuthorizationStatus.notDetermined;
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

  Future<String?> getAccessToken() async {
    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(servicesAccountJson), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(servicesAccountJson),
              scopes,
              client);

      client.close();
      debugPrint(
          "Access Token: ${credentials.accessToken.data}"); // debugPrint Access Token
      return credentials.accessToken.data;
    } catch (e) {
      debugPrint("Error getting access token: $e");
      return null;
    }
  }

  Map<String, dynamic> getBody({
    required String fcmToken,
    required String sender,
    required String msg,
    required String userId,
    String? type,
  }) {
    return {
      "message": {
        "token": fcmToken,
        "notification": {
          "sender": sender,
          "msg": msg,
          "datetime": Timestamp.now()
        },
        "android": {
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default"
          }
        },
        "apns": {
          "payload": {
            "aps": {"content_available": true}
          }
        },
        "data": {
          "type": type,
          "id": userId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      }
    };
  }

  Future<void> sendNotifications({
    required String fcmToken,
    required String sender,
    required String msg,
    required String userId,
    String? type,
  }) async {
    try {
      var serverKeyAuthorization = await getAccessToken();

      // change your project id
      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/chatty-dev990/messages:send";

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

      var response = await dio.post(
        urlEndPoint,
        data: getBody(
          userId: userId,
          fcmToken: fcmToken,
          sender: sender,
          msg: msg,
          type: type ?? "message",
        ),
      );

      // debugPrint response status code and body for debugging
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');
    } catch (e) {
      debugPrint("Error sending notification: $e");
    }
  }
}
