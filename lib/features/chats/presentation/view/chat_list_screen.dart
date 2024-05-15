import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: const Card(child: Row(
            
            ))),
        body: const Column(
          children: [],
        ));
  }
}
