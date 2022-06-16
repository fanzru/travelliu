import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double? width, height;
  final Decoration? decoration;
  const ShimmerContainer({Key? key, this.height, this.width, this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        decoration: decoration ??
            BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
