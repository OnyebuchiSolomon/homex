import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

   import 'package:homex/ui/global.dart';
class ProgressIndicators {

  static Widget spinningLinesProgressBar(BuildContext context, {Color? color}) {
    return SpinKitSpinningLines(
      color: color ?? Theme.of(context).colorScheme.surface,
      size: 40,
    );
  }

  static Widget doubleBounceProgressBar(BuildContext context) {
    return SpinKitDoubleBounce(
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  static Widget circularProgressBar(
      {BuildContext? context,double? value, double strokeWidth = 2.5}) {
    final ctx = context ?? AppNavigator.currentContext;

    return CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(ctx).colorScheme.secondary),
        backgroundColor: Theme.of(ctx).shadowColor);
  }

  static Widget linearProgressBar(BuildContext context,
      {double? value, double? minHeight}) {
    return LinearProgressIndicator(
        value: value,
        minHeight: minHeight,
        valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.secondary),
        backgroundColor: Theme.of(context).shadowColor);
  }
}
