import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_images.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({Key? key, required this.imageUrl})
      : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      placeholder: (c, v) => Image.asset(
        AppImages.appLogo,
        fit: BoxFit.fill,
      ),
      errorWidget: (c, v, d) => Image.asset(
        AppImages.appLogo,
        fit: BoxFit.fill,
      ),
    );
  }
}
