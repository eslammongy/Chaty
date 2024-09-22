import 'package:flutter/material.dart';
import 'package:chaty/core/constants/app_assets.dart';
import 'package:chaty/core/widgets/placeholder_img_msg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CacheNetworkMsgImg extends StatelessWidget {
  const CacheNetworkMsgImg({
    super.key,
    required this.imgUrl,
    required this.radius,
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
        color: theme.scaffoldBackgroundColor,
        margin: EdgeInsets.zero,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image(image: imageProvider)),
      ),
      placeholder: (context, url) => Card(
        margin: EdgeInsets.zero,
        color: theme.scaffoldBackgroundColor,
        child: const PlaceholderImgMsg(type: PlaceholderType.asset),
      ),
      errorWidget: (context, url, error) => Card(
        margin: EdgeInsets.zero,
        color: theme.scaffoldBackgroundColor,
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
}
