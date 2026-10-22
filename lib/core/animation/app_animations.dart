import 'package:flutter/animation.dart';

class AppAnimations {
  AppAnimations._();

  // ---------------------------------------------------------------------------
  // DURATIONS
  // ---------------------------------------------------------------------------

  static const Duration instant = Duration(milliseconds: 100);

  static const Duration fast = Duration(milliseconds: 200);

  static const Duration normal = Duration(milliseconds: 350);

  static const Duration medium = Duration(milliseconds: 500);

  static const Duration slow = Duration(milliseconds: 700);

  static const Duration splash = Duration(milliseconds: 1200);

  static const Duration splashScreen = Duration(milliseconds: 3500);

  static const Duration loadingDots = Duration(milliseconds: 1400);

  static const Duration pageTransition = Duration(milliseconds: 350);

  static const Duration modal = Duration(milliseconds: 350);


  // ---------------------------------------------------------------------------
  // CURVES
  // ---------------------------------------------------------------------------

  /// Default animation curve.
  static const Curve standard = Curves.easeOutCubic;

  /// Curve used when elements enter the screen.
  static const Curve enter = Curves.easeOutCubic;

  /// Curve used when elements leave the screen.
  static const Curve exit = Curves.easeInCubic;

  /// Smooth animation for general UI changes.
  static const Curve smooth = Curves.easeInOutCubic;

  /// Fast/simple animation curve.
  static const Curve fastCurve = Curves.easeOut;

  /// HomeX splash entrance curve.
  static const Curve splashCurve = Cubic(
    0.16,
    1.0,
    0.3,
    1.0,
  );

  /// Used for small playful/bouncy elements.
  static const Curve bounce = Curves.easeOutBack;


  // ---------------------------------------------------------------------------
  // DELAYS
  // ---------------------------------------------------------------------------

  static const Duration noDelay = Duration.zero;

  static const Duration shortDelay = Duration(milliseconds: 100);

  static const Duration mediumDelay = Duration(milliseconds: 200);

  static const Duration longDelay = Duration(milliseconds: 400);


  // ---------------------------------------------------------------------------
  // STAGGER
  // ---------------------------------------------------------------------------

  static const Duration stagger = Duration(milliseconds: 80);

  static const Duration staggerFast = Duration(milliseconds: 50);

  static const Duration staggerSlow = Duration(milliseconds: 120);


  // ---------------------------------------------------------------------------
  // SCALE
  // ---------------------------------------------------------------------------

  static const double scaleNormal = 1.0;

  static const double scaleStart = 0.95;

  static const double scaleSmall = 0.90;

  static const double scalePressed = 0.97;

  static const double scaleLarge = 1.05;


  // ---------------------------------------------------------------------------
  // SLIDE
  // ---------------------------------------------------------------------------

  static const double slideSmall = 0.05;

  static const double slideMedium = 0.15;

  static const double slideLarge = 0.30;


  // ---------------------------------------------------------------------------
  // FADE
  // ---------------------------------------------------------------------------

  static const double fadeHidden = 0.0;

  static const double fadeVisible = 1.0;


  // ---------------------------------------------------------------------------
  // ROTATION
  // ---------------------------------------------------------------------------

  static const double rotationNone = 0.0;

  static const double rotationQuarter = 0.25;

  static const double rotationHalf = 0.5;
}