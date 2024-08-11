import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/user_pref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/features/users/view/screens/friends_screen.dart';
import 'package:chaty/features/users/view/screens/profile_screen.dart';
import 'package:chaty/features/chats/view/screen/chat_list_screen.dart';
import 'package:chaty/features/dashboard/view/widgets/bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final listOfScreens = [
    const ChatListScreen(),
    const FriendsScreen(),
    const ProfileScreen(),
  ];
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    getDeviceToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (UserCubit.get(context).friendsList.isEmpty) {
        context.read<UserCubit>().fetchAllUserFriends();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: listOfScreens[_selectedPage],
      bottomNavigationBar: FloatingBottomNavBar(
        currentIndex: _selectedPage,
        getCurrentIndex: (int index) {
          onTapNavClicked(index);
        },
      ),
    );
  }

  onTapNavClicked(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  getDeviceToken() async {
    if (isFirebaseMsgTokenSaved()) return;
    if (Platform.isAndroid) {
      await FirebaseMessaging.instance.getToken().then((value) async {
        await SharedPref.saveFirebaseMsgToken(token: value!);
      });
    }
    if (Platform.isIOS) {
      checkNotificationPermission();
    }
  }

  bool isFirebaseMsgTokenSaved() {
    final token = SharedPref.getFirebaseMsgToken();
    return token != null;
  }

  void checkNotificationPermission() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final status = settings.authorizationStatus;
    if (status != AuthorizationStatus.denied ||
        status != AuthorizationStatus.notDetermined) {
      debugPrint('User declined or has not accepted permission');
      return;
    } else {
      debugPrint('User granted permission');
      final token = await firebaseMessaging.getToken();
      await SharedPref.saveFirebaseMsgToken(token: token!);
    }
  }
}
