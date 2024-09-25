import 'package:flutter/material.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CacheNetworkProfileImg extends StatelessWidget {
  const CacheNetworkProfileImg({
    super.key,
    required this.imgUrl,
    this.radius = 80,
  });
  final String imgUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fadeInCurve: Curves.bounceInOut,
      imageBuilder: (context, imageProvider) => Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: theme.colorScheme.surfaceTint, width: 2)),
        color: theme.scaffoldBackgroundColor,
        margin: EdgeInsets.zero,
        child: CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        ),
      ),
      placeholder: (context, url) => Card(
        shape: shapeBorder(theme.scaffoldBackgroundColor),
        margin: EdgeInsets.zero,
        color: theme.scaffoldBackgroundColor,
        child: CircleAvatar(
          radius: radius,
          child: Image.asset(
            AppAssetsManager.loading,
            width: 40,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Card(
        shape: shapeBorder(theme.scaffoldBackgroundColor),
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: radius,
            child: Image.asset(AppAssetsManager.appPNGLogo),
          ),
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
