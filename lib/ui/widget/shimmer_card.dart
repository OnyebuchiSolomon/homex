import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImage extends StatelessWidget {
  final double height;
  final double width;
  final BoxFit fit;

  const ShimmerImage({
    super.key,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,       // darker
      highlightColor: Colors.grey.shade100,  // much brighter
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(8), // optional (looks much better)
        ),
      ),
    );
  }
}
