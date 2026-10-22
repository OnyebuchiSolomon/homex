import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
 import 'progress_indicator.dart';

class ButtonView extends StatelessWidget {
  final void Function() onPressed;
  final Widget? child;
  final Color? color;
  final Color? borderColor;
  final Color? shadowColor;
  final double borderWidth;
  final double borderRadius;
  final double height;
  final bool disabled;
  final double elevation;
  final bool processing;
  final bool expanded;
  final EdgeInsets padding;
  const ButtonView({
    required this.onPressed,
    required this.child,
    this.color,
    this.borderColor,
    this.shadowColor = AppColors.lightSurfaceContainerLow,
    this.borderWidth = 0.0,
    this.disabled = false,
    this.processing = false,
    this.height = 50,
    this.elevation = 0,
    this.expanded = true,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(8.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (processing) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProgressIndicators.circularProgressBar( )),
      );
    } else {
      if (expanded) {
        return SizedBox(
          width: double.maxFinite,
          height: height,
          child: ElevatedButton(
            onPressed: disabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              elevation: elevation,
              shadowColor: shadowColor,
              backgroundColor: disabled
                  ? Theme.of(context).colorScheme.surface
                  : (color ?? Theme.of(context).colorScheme.secondary),
              padding: padding,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(
                      color: disabled
                          ? Theme.of(context).textTheme.bodySmall!.color!
                          : (borderColor ??
                              Theme.of(context).colorScheme.secondary),
                      width: borderWidth)),
              textStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            child: child,
          ),
        );
      } else {
        return SizedBox(
          height: height,
          child: ElevatedButton(
            onPressed: disabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              elevation: elevation,
              shadowColor: shadowColor,
              backgroundColor: disabled
                  ? Theme.of(context).colorScheme.surface
                  : (color ?? Theme.of(context).colorScheme.secondary),
              padding: padding,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(
                      color: disabled
                          ? Theme.of(context).textTheme.bodySmall!.color!
                          : (borderColor ??
                              Theme.of(context).colorScheme.secondary),
                      width: borderWidth)),
              textStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            child: child,
          ),
        );
      }
    }
  }
}
