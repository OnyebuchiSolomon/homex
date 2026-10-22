import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late double scaleFactor; // for width/font
  static late double scaleHeightFactor; // for height

  static const double baseWidth = 375.0; // e.g., iPhone X width
  static const double baseHeight = 812.0; // e.g., iPhone X height

  static double defaultScreenPadding = 16;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    _blockSizeHorizontal = screenWidth / 100;
    _blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    scaleFactor = (screenWidth / baseWidth).clamp(0.9, 1.2);
    scaleHeightFactor = (screenHeight / baseHeight).clamp(0.9, 1.2);
  }

  static double widthOf(double val) => val * _blockSizeHorizontal;
  static double heightOf(double val) => val * _blockSizeVertical;
}


