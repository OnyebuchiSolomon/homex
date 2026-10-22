import 'package:flutter/material.dart';

extension SizedContext on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  Size get sizePx => mq.size;

  double get widthPx => sizePx.width;

  double get heightPx => sizePx.height;

  double get statusBarHeight {
    return MediaQueryData.fromView(
      View.of(this),
    ).padding.top;
  }

  double get bottomPadding {
    return MediaQueryData.fromView(
      View.of(this),
    ).padding.bottom;
  }

  double widthOf(double val) {
    return val * (widthPx / 100);
  }

  double heightOf(double val) {
    return val * (heightPx / 100);
  }

  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
  bool get isDarkTheme =>   theme.brightness==Brightness.dark;

}