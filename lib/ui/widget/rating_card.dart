import 'package:homex/ui/global.dart';
import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  final double rating;
  const RatingCard({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final int fullStars = rating.floor();
    final bool hasHalfStar = rating - fullStars >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
            (index) {
          IconData icon;

          if (index < fullStars) {
            icon = Icons.star_rounded;
          } else if (index == fullStars && hasHalfStar) {
            icon = Icons.star_half_rounded;
          } else {
            icon = Icons.star_border_rounded;
          }

          return Icon(
            icon,
            size: 17,
            color: context.colors.secondaryContainer,
          );
        },
      ),
    );
  }
}
