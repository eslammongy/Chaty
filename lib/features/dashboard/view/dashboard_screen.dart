import 'package:chaty/core/services/fcm_services.dart';
import 'package:chaty/features/chats/view/screen/chat_list_screen.dart';
import 'package:chaty/features/chats/view/widgets/chats_app_bar.dart';
import 'package:chaty/features/dashboard/view/widgets/bottom_nav_bar.dart';
import 'package:chaty/features/settings/cubit/settings_cubit.dart';
import 'package:chaty/features/user/view/screens/friends_screen.dart';
import 'package:chaty/features/user/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    FCMService.handleForegroundNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    final settingsCubit = SettingsCubit.get(context);
    return Scaffold(
      extendBody: true,
      appBar: settingsCubit.currentPageIndex == 2
          ? null
          : CustomAppBar(index: settingsCubit.currentPageIndex),
      body: listOfScreens[settingsCubit.currentPageIndex],
      bottomNavigationBar: FloatingBottomNavBar(
        currentIndex: settingsCubit.currentPageIndex,
        getCurrentIndex: (int index) {
          onTapNavClicked(settingsCubit, index);
        },
      ),
    );
  }

  onTapNavClicked(SettingsCubit settingsCubit, int index) {
    setState(() {
      settingsCubit.currentPageIndex = index;
    });
  }
}
