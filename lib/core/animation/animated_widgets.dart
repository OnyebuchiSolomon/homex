import 'package:flutter/material.dart';
import 'app_animations.dart';

enum SlideDirection {
  left,
  right,
  top,
  bottom,
}

class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Duration? delay;
  final Curve? curve;

  const FadeIn({
    super.key,
    required this.child,
    this.duration,
    this.delay,
    this.curve,
  });

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? AppAnimations.normal,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve ?? AppAnimations.enter,
    );

    _start();
  }

  Future<void> _start() async {
    await Future.delayed(
      widget.delay ?? AppAnimations.noDelay,
    );

    if (!mounted) return;

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}


class FadeScaleIn extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Duration? delay;
  final Curve? curve;
  final double? beginScale;

  const FadeScaleIn({
    super.key,
    required this.child,
    this.duration,
    this.delay,
    this.curve,
    this.beginScale,
  });

  @override
  State<FadeScaleIn> createState() => _FadeScaleInState();
}

class _FadeScaleInState extends State<FadeScaleIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? AppAnimations.normal,
    );

    final animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve ?? AppAnimations.standard,
    );

    _opacity = Tween<double>(
      begin: AppAnimations.fadeHidden,
      end: AppAnimations.fadeVisible,
    ).animate(animation);

    _scale = Tween<double>(
      begin: widget.beginScale ?? AppAnimations.scaleStart,
      end: AppAnimations.scaleNormal,
    ).animate(animation);

    _start();
  }

  Future<void> _start() async {
    await Future.delayed(
      widget.delay ?? AppAnimations.noDelay,
    );

    if (!mounted) return;

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}


class SlideFadeIn extends StatefulWidget {
  final Widget child;
  final SlideDirection direction;
  final Duration? duration;
  final Duration? delay;
  final Curve? curve;
  final double? distance;

  const SlideFadeIn({
    super.key,
    required this.child,
    this.direction = SlideDirection.bottom,
    this.duration,
    this.delay,
    this.curve,
    this.distance,
  });

  @override
  State<SlideFadeIn> createState() => _SlideFadeInState();
}

class _SlideFadeInState extends State<SlideFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? AppAnimations.normal,
    );

    final animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve ?? AppAnimations.enter,
    );

    _opacity = Tween<double>(
      begin: AppAnimations.fadeHidden,
      end: AppAnimations.fadeVisible,
    ).animate(animation);

    _slide = Tween<Offset>(
      begin: _getBeginOffset(),
      end: Offset.zero,
    ).animate(animation);

    _start();
  }

  Offset _getBeginOffset() {
    final distance =
        widget.distance ?? AppAnimations.slideMedium;

    switch (widget.direction) {
      case SlideDirection.left:
        return Offset(-distance, 0);

      case SlideDirection.right:
        return Offset(distance, 0);

      case SlideDirection.top:
        return Offset(0, -distance);

      case SlideDirection.bottom:
        return Offset(0, distance);
    }
  }

  Future<void> _start() async {
    await Future.delayed(
      widget.delay ?? AppAnimations.noDelay,
    );

    if (!mounted) return;

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}


class ScaleIn extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Duration? delay;
  final Curve? curve;
  final double? beginScale;

  const ScaleIn({
    super.key,
    required this.child,
    this.duration,
    this.delay,
    this.curve,
    this.beginScale,
  });

  @override
  State<ScaleIn> createState() => _ScaleInState();
}

class _ScaleInState extends State<ScaleIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? AppAnimations.normal,
    );

    _scale = Tween<double>(
      begin: widget.beginScale ?? AppAnimations.scaleSmall,
      end: AppAnimations.scaleNormal,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? AppAnimations.standard,
      ),
    );

    _start();
  }

  Future<void> _start() async {
    await Future.delayed(
      widget.delay ?? AppAnimations.noDelay,
    );

    if (!mounted) return;

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}


class ScaleOnTap extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const ScaleOnTap({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  State<ScaleOnTap> createState() => _ScaleOnTapState();
}

class _ScaleOnTapState extends State<ScaleOnTap> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!mounted) return;

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) {
        _setPressed(false);
        widget.onTap?.call();
      },
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed
            ? AppAnimations.scalePressed
            : AppAnimations.scaleNormal,
        duration: AppAnimations.fast,
        curve: AppAnimations.fastCurve,
        child: widget.child,
      ),
    );
  }
}


class BounceIn extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Duration? delay;

  const BounceIn({
    super.key,
    required this.child,
    this.duration,
    this.delay,
  });

  @override
  State<BounceIn> createState() => _BounceInState();
}

class _BounceInState extends State<BounceIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? AppAnimations.medium,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.bounce,
    );

    _start();
  }

  Future<void> _start() async {
    await Future.delayed(
      widget.delay ?? AppAnimations.noDelay,
    );

    if (!mounted) return;

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}


class Pulse extends StatefulWidget {
  final Widget child;
  final Duration? duration;

  const Pulse({
    super.key,
    required this.child,
    this.duration,
  });

  @override
  State<Pulse> createState() => _PulseState();
}

class _PulseState extends State<Pulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? AppAnimations.slow,
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: AppAnimations.scaleNormal,
      end: AppAnimations.scaleLarge,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppAnimations.smooth,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}


class BounceDots extends StatefulWidget {
  final Duration? duration;

  const BounceDots({
    super.key,
    this.duration,
  });

  @override
  State<BounceDots> createState() => _BounceDotsState();
}

class _BounceDotsState extends State<BounceDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? AppAnimations.loadingDots,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _bounce(int index) {
    final value =
        (_controller.value - (index * 0.2)) % 1.0;

    final progress = value < 0.5
        ? value * 2
        : (1 - value) * 2;

    return -progress * 6;
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
              final bounce = _bounce(index);

              return Transform.translate(
                offset: Offset(0, bounce),
                child: Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.45 +
                          ((-bounce / 6) * 0.55),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}


class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double offset;
  final Curve curve;

  const ScrollReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.offset = 30,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curved);

    _slide = Tween<Offset>(
      begin: Offset(0, widget.offset / 100),
      end: Offset.zero,
    ).animate(curved);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!mounted || _hasAnimated) return;

    final renderObject = context.findRenderObject();

    if (renderObject is! RenderBox) return;

    final position = renderObject.localToGlobal(
      Offset.zero,
    );

    final screenHeight = MediaQuery.of(context).size.height;

    final top = position.dy;
    final bottom = top + renderObject.size.height;

    final isVisible =
        bottom > 0 &&
            top < screenHeight;

    if (isVisible) {
      _hasAnimated = true;

      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return FadeTransition(
          opacity: _opacity,
          child: SlideTransition(
            position: _slide,
            child: child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}