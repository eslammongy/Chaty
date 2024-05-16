import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_firebase/core/constants/app_assets.dart';

class CacheNetworkImg extends StatelessWidget {
  const CacheNetworkImg(
      {super.key,
      required this.imgUrl,
      required this.shapeBorder,
      this.radius = 80});
  final String imgUrl;
  final ShapeBorder shapeBorder;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fadeInCurve: Curves.bounceInOut,
      imageBuilder: (context, imageProvider) => Card(
        shape: shapeBorder,
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        child: CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        ),
      ),
      placeholder: (context, url) => Card(
        shape: shapeBorder,
        margin: EdgeInsets.zero,
        child: CircleAvatar(
          radius: radius,
          child: Image.asset(AppAssetsManager.firebaseLogo),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}