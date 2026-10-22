import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/animation/app_animations.dart';
  import '../../../../core/extensions/custom_context_extension.dart';
import '../../../../core/routes/app_routes.dart';
 import '../../../../core/routes/navigator/page_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.splash,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.splashCurve,
    );

    _scaleAnimation = Tween<double>(
      begin: AppAnimations.scaleStart,
      end: AppAnimations.scaleNormal,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppAnimations.splashCurve,
      ),
    );

    _controller.forward();

    _startSplashTimer();
  }

  Future<void> _startSplashTimer() async {
    await Future.delayed(AppAnimations.splashScreen);

    if (!mounted) return;

    AppNavigator.pushAndReplaceNamed(
      AppRoutes.onboardingScreen,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _SplashBackground(),

          _SplashGlow(
            alignment: Alignment.topLeft,
            color: context.colors.primary,
            opacity: 0.20,
          ),

          _SplashGlow(
            alignment: Alignment.bottomRight,
            color: context.colors.secondary,
            opacity: 0.10,
          ),

          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: const _SplashContent(),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: context.heightOf(6),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _controller,
                curve: const Interval(
                  0.5,
                  1.0,
                  curve: Curves.easeOut,
                ),
              ),
              child: const _LoadingDots(),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BACKGROUND
// ============================================================

class _SplashBackground extends StatefulWidget {
  const _SplashBackground();

  @override
  State<_SplashBackground> createState() => _SplashBackgroundState();
}

class _SplashBackgroundState extends State<_SplashBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.colors.primary,
                context.colors.secondary,
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// BACKGROUND GLOW
// ============================================================

class _SplashGlow extends StatelessWidget {
  final Alignment alignment;
  final Color color;
  final double opacity;

  const _SplashGlow({
    required this.alignment,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 100,
            sigmaY: 100,
          ),
          child: Container(
            width: context.widthOf(40),
            height: context.widthOf(40),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(
                alpha: opacity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CONTENT
// ============================================================

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthOf(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.home_work_outlined,
            size: context.widthOf(18),
            color: context.colors.onPrimary,
          ),

          SizedBox(
            height: context.heightOf(2),
          ),

          Text(
            'HomeX',
            textAlign: TextAlign.center,
            style: context.textTheme.displayLarge?.copyWith(
              color: context.colors.onPrimary,
            ),
          ),

          SizedBox(
            height: context.heightOf(1),
          ),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 280,
            ),
            child: Text(
              'Find. Verify. Deal With Confidence.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colors.onPrimary.withValues(
                  alpha: 0.80,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LOADING DOTS
// ============================================================

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.loadingDots,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
                (index) {
              final delayedValue =
                  (_controller.value - (index * 0.16)) % 1.0;

              final scale = _calculateDotScale(
                delayedValue,
              );

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: context.colors.onPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  double _calculateDotScale(double progress) {
    if (progress < 0.28) {
      return 0.3 + (progress / 0.28) * 0.7;
    }

    if (progress < 0.56) {
      return 1 - ((progress - 0.28) / 0.28) * 0.7;
    }

    return 0.3;
  }
}