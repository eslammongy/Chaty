import 'package:flutter/material.dart';
import 'package:chaty/features/chats/view/screen/friends_screen.dart';
import 'package:chaty/features/profile/cubit/profile_info_cubit.dart';
import 'package:chaty/features/chats/view/screen/chat_list_screen.dart';
import 'package:chaty/features/profile/view/screens/profile_screen.dart';
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
    loadProfileInfo();
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

  loadProfileInfo() async {
    final profileCubit = ProfileInfoCubit.get(context);
    await profileCubit.fetchUserProfileInfo();
  }
}
