import 'package:flutter/material.dart';
import 'package:homex/core/extensions/custom_context_extension.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    this.onTap,
    this.height,
    this.width,
    this.margin,
    this.padding = const EdgeInsets.symmetric(
      vertical: 24,
      horizontal: 16,
    ),
    this.borderRadius = 20,
    this.child,
    super.key,
  });
  final void Function()? onTap;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final double borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color:context. colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: context.colors.outlineVariant,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colors.onSurface.withValues(alpha: 0.04),
              blurRadius: 8,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
