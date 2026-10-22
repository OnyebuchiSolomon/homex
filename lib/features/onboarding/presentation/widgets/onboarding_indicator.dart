import 'package:flutter/material.dart';

import '../../../../core/animation/app_animations.dart';
import '../../../../core/extensions/custom_context_extension.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final bool active = index == currentIndex;

        return AnimatedContainer(
          duration: AppAnimations.normal,
          curve: AppAnimations.standard,
          margin: const EdgeInsets.only(right: 8),
          width: active ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? colors.secondary : colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}
