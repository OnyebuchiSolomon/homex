import 'package:flutter/cupertino.dart';
import 'package:homex/ui/global.dart';
import 'package:homex/ui/widget/rating_card.dart';
class ReviewCard extends StatelessWidget {
  final String initials;
  final String name;
  final String role;
  final String date;
  final double rating;
  final String review;
  const ReviewCard({super.key, required this.initials, required this.name, required this.role, required this.date, required this.rating, required this.review});

  @override
  Widget build(BuildContext context) {
    var colors = context.colors;
    var textTheme = context.textTheme;
    return    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colors.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.onSurface,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    '$role • $date',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            RatingCard(
             rating:  rating,

            ),
          ],
        ),

        const SizedBox(height: 12),

        Text(
          '"$review"',
          style: textTheme.bodyMedium?.copyWith(
            height: 1.5,
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
