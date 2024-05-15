import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemExtent: 90.h,
        itemBuilder: (context, index) {
          return Card(
            child: SizedBox(
              height: 90.h,
            ),
          );
        },
      ),
    );
  }
}
