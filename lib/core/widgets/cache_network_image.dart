import 'package:flutter/material.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CacheNetworkImg extends StatelessWidget {
  const CacheNetworkImg({super.key, required this.imgUrl, this.radius = 80});
  final String imgUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fadeInCurve: Curves.bounceInOut,
      imageBuilder: (context, imageProvider) => Card(
        shape: shapeBorder(theme.scaffoldBackgroundColor),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        child: CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        ),
      ),
      placeholder: (context, url) => Card(
        shape: shapeBorder(theme.scaffoldBackgroundColor),
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        child: CircleAvatar(
          radius: radius,
          child: Image.asset(AppAssetsManager.placeholderImg),
        ),
      ),
      errorWidget: (context, url, error) => Card(
        shape: shapeBorder(theme.scaffoldBackgroundColor),
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        child: CircleAvatar(
          radius: radius,
          child: Image.asset(AppAssetsManager.appPNGLogo),
        ),
      ),
    );
  }

  shapeBorder(Color color) {
    return RoundedRectangleBorder(
        side: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(radius));
  }
}
