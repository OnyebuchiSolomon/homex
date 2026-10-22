import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';


class TitleView extends StatelessWidget {
  final String title;
  final GestureTapCallback? onSeeAll;
  final String actionText;
  final double fontSize;
  final FontWeight fontWeight;
  final FontWeight seeAllFontWeight;
  const TitleView(this.title,
      {this.onSeeAll,
      this.actionText = 'See All',
      this.fontSize = 18.0,
      this.fontWeight = FontWeight.w700,
      this.seeAllFontWeight = FontWeight.w400,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600)
          ),
        ),
        if (onSeeAll != null) ...[
          const SizedBox(width: 8),
          InkWell(
            onTap: onSeeAll,
            child: Text(
              actionText,
              style: AppTextStyles.labelMedium,
            ),
          ),
        ]
      ],
    );
  }
}
