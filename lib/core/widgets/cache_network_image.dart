import 'package:flutter/material.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CacheNetworkImg extends StatelessWidget {
  const CacheNetworkImg({
    super.key,
    required this.imgUrl,
    this.radius = 80,
    this.isChatMsg = false,
  });
  final String imgUrl;
  final double radius;
  final bool isChatMsg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fadeInCurve: Curves.bounceInOut,
      imageBuilder: (context, imageProvider) => Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        child: isChatMsg
            ? ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Image(image: imageProvider))
            : CircleAvatar(
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
