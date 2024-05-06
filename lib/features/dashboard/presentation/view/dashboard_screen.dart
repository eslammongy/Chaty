import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/chats/presentation/view/chat_list_screen.dart';
import 'package:flutter_firebase/features/profile/presentation/view/screens/profile_screen.dart';
import 'package:flutter_firebase/features/dashboard/presentation/view/widgets/bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final listOfScreens = [
    const ProfileScreen(),
    const ChatListScreen(),
  ];
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
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
}
