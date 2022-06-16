import 'package:flutter/material.dart';
import 'package:mobile/screen/_global/components/shimmer/shimmer_container.dart';

class ImageNetworkWShimmer extends StatelessWidget {
  final String link;
  double? width, height;
  BoxFit? fit;
  ImageNetworkWShimmer(
      {Key? key, required this.link, this.width, this.height, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(link, fit: fit, width: width, height: height,
        loadingBuilder: (context, child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return ShimmerContainer(
        width: width,
        height: height ?? 300,
      );
    });
  }
}
