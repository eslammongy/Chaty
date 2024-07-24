import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ChatMessagePlaceholder extends StatelessWidget {
  const ChatMessagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            _shimmerLoading(),
            const SizedBox(height: 15),
            _shimmerLoading(alignment: MainAxisAlignment.end),
            const SizedBox(height: 15),
            _shimmerLoading(),
            const SizedBox(height: 15),
            _shimmerLoading(alignment: MainAxisAlignment.end),
            const SizedBox(height: 15),
            _shimmerLoading(),
            const SizedBox(height: 15),
            _shimmerLoading(alignment: MainAxisAlignment.end),
            const SizedBox(height: 15),
            _shimmerLoading(),
            const SizedBox(height: 15),
            _shimmerLoading(alignment: MainAxisAlignment.end),
            const SizedBox(height: 15),
            _shimmerLoading(),
          ],
        ),
      ),
    );
  }

  Shimmer _shimmerLoading({
    MainAxisAlignment alignment = MainAxisAlignment.start,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[600]!,
      period: const Duration(milliseconds: 1000),
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          alignment == MainAxisAlignment.start
              ? _msgShimmerShape()
              : _avatarShimmerShape(),
          alignment == MainAxisAlignment.start
              ? _avatarShimmerShape()
              : _msgShimmerShape(),
        ],
      ),
    );
  }

  Card _avatarShimmerShape() {
    return Card(
        color: Colors.grey[300]!,
        child: const SizedBox(
          width: 180,
          height: 35,
        ));
  }

  Card _msgShimmerShape() {
    return Card(
      color: Colors.grey[300]!,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: const SizedBox(
        width: 30,
        height: 30,
      ),
    );
  }
}
