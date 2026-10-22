import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class AddPropertyLocationPage extends StatefulWidget {
  const AddPropertyLocationPage({super.key});

  @override
  State<AddPropertyLocationPage> createState() =>
      _AddPropertyLocationPageState();
}

class _AddPropertyLocationPageState extends State<AddPropertyLocationPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  String selectedAddress = 'Plot 12, Admiralty Way';
  String selectedArea = 'Lekki Phase 1';
  String selectedCity = 'Lagos, Nigeria';

  late AnimationController _animationController;

  late Animation<double> _pageFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<Offset> _mapSlideAnimation;
  late Animation<double> _pinScaleAnimation;
  late Animation<double> _pinPulseAnimation;
  late Animation<Offset> _addressSlideAnimation;
  late Animation<double> _addressFadeAnimation;
  late Animation<double> _progressAnimation;

  bool _isGettingLocation = false;
  bool _isConfirming = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _pageFadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );

    _headerSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.12), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
          ),
        );

    _mapSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.15, 0.65, curve: Curves.easeOutCubic),
          ),
        );

    _pinScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.35, 0.75, curve: Curves.elasticOut),
      ),
    );

    _pinPulseAnimation = Tween<double>(begin: 0.85, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.65, 1.0, curve: Curves.easeInOut),
      ),
    );

    _addressSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.45, 0.95, curve: Curves.easeOutCubic),
          ),
        );

    _addressFadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.50).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.15, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // CONFIRM LOCATION
  // ============================================================

  Future<void> _confirmLocation() async {
    if (_isConfirming) return;

    setState(() {
      _isConfirming = true;
    });

    await Future.delayed(const Duration(milliseconds: 350));

    if (!mounted) return;

    AppNavigator.pushAndStackNamed(AppRoutes.photosVideoPage);

    setState(() {
      _isConfirming = false;
    });
  }

  // ============================================================
  // CURRENT LOCATION
  // ============================================================

  Future<void> _useCurrentLocation() async {
    if (_isGettingLocation) return;

    setState(() {
      _isGettingLocation = true;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Getting your current location...'),
          behavior: SnackBarBehavior.floating,
        ),
      );

    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    setState(() {
      _isGettingLocation = false;
      selectedAddress = 'Current Location';
      selectedArea = 'Lekki Phase 1';
      selectedCity = 'Lagos, Nigeria';
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Current location selected.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // BACK
  // ============================================================

  void _goBack() {
    Navigator.pop(context);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isMobile = width < 600;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _pageFadeAnimation,
                    child: SlideTransition(
                      position: _headerSlideAnimation,
                      child: _buildHeader(context, isMobile: isMobile),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _pageFadeAnimation,
                    child: SlideTransition(
                      position: _mapSlideAnimation,
                      child: _buildMapSection(context),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context, {required bool isMobile}) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.94),
        border: Border(bottom: BorderSide(color: colors.outlineVariant)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: [
                Row(
                  children: [
                    _AnimatedIconButton(
                      icon: Icons.arrow_back,
                      color: colors.onSurfaceVariant,
                      onPressed: _goBack,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Location',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '3 of 6',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: colors.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Step 3 of 6',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '50%',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: _progressAnimation.value,
                        minHeight: 6,
                        backgroundColor: colors.surfaceContainer,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colors.primary,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                _buildSearchField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SEARCH FIELD
  // ============================================================

  Widget _buildSearchField(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      height: 48,
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search for address or neighborhood',
          hintStyle: AppTextStyles.bodyMedium.copyWith(color: colors.outline),
          prefixIcon: Icon(Icons.search, color: colors.outline),
          filled: true,
          fillColor: colors.surfaceContainerLowest,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colors.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colors.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colors.primary, width: 1.2),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MAP SECTION
  // ============================================================

  Widget _buildMapSection(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 650,
      child: Stack(
        children: [
          Positioned.fill(child: _buildMap(context)),

          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale:
                          _pinScaleAnimation.value * _pinPulseAnimation.value,
                      child: child,
                    );
                  },
                  child: _buildLocationPin(context),
                ),
              ),
            ),
          ),

          Positioned(
            right: 16,
            bottom: 285,
            child: _buildCurrentLocationButton(context, colors),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: _addressFadeAnimation,
              child: SlideTransition(
                position: _addressSlideAnimation,
                child: _buildAddressCard(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CURRENT LOCATION BUTTON
  // ============================================================

  Widget _buildCurrentLocationButton(BuildContext context, ColorScheme colors) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.elasticOut,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: Material(
        color: colors.surfaceContainerLowest,
        elevation: 5,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: _useCurrentLocation,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.7, end: 1).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: _isGettingLocation
                  ? SizedBox(
                      key: const ValueKey('loading'),
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: colors.primary,
                      ),
                    )
                  : Icon(
                      key: const ValueKey('location'),
                      Icons.my_location,
                      color: colors.primary,
                      size: 24,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MAP
  // ============================================================

  Widget _buildMap(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      decoration: BoxDecoration(color: colors.surfaceContainer),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCJUGLM0KoUNyqAgSbTRuA-dTNBOszasKL7g6l2Th2irJo3k-U0p8JgVqfQdqStzkeEAZPKBRvzQN9Xk31dubh0tw6wlke0bOcWxqUy0QIb8xIIF36lmXEKsRWEpoG9zJGxf2MU0kyGdFMgOq-Rte-STm_QCi_ffcPNmpM-Ai0zi7AEoJcp_9yj4qDG_cMcYUbdLago6dKf4KZjjcgAC5qgDrVZgi6CxB59Oy4_8FF8LXqpY0X_byr1',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildMapFallback(context);
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return _buildMapFallback(context, loading: true);
            },
          ),

          Container(color: Colors.white.withValues(alpha: 0.08)),
        ],
      ),
    );
  }

  // ============================================================
  // MAP FALLBACK
  // ============================================================

  Widget _buildMapFallback(BuildContext context, {bool loading = false}) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.surfaceContainer,
      child: Stack(
        children: [
          Positioned(
            top: 80,
            left: -50,
            right: -50,
            child: Transform.rotate(
              angle: -0.15,
              child: Container(
                height: 28,
                color: colors.surfaceContainerLowest,
              ),
            ),
          ),

          Positioned(
            top: 210,
            left: -50,
            right: -50,
            child: Transform.rotate(
              angle: 0.12,
              child: Container(
                height: 20,
                color: colors.surfaceContainerLowest,
              ),
            ),
          ),

          Positioned(
            top: 350,
            left: -50,
            right: -50,
            child: Transform.rotate(
              angle: -0.08,
              child: Container(
                height: 32,
                color: colors.surfaceContainerLowest,
              ),
            ),
          ),

          Positioned(
            left: 100,
            top: -50,
            bottom: -50,
            child: Transform.rotate(
              angle: 0.18,
              child: Container(width: 20, color: colors.surfaceContainerLowest),
            ),
          ),

          Positioned(
            right: 120,
            top: -50,
            bottom: -50,
            child: Transform.rotate(
              angle: -0.22,
              child: Container(width: 26, color: colors.surfaceContainerLowest),
            ),
          ),

          Positioned(
            right: -100,
            top: 0,
            bottom: 0,
            width: 150,
            child: Container(color: Colors.blueGrey.withValues(alpha: 0.10)),
          ),

          if (loading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  // ============================================================
  // LOCATION PIN
  // ============================================================

  Widget _buildLocationPin(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: -10, end: 0),
          duration: const Duration(milliseconds: 650),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.translate(offset: Offset(0, value), child: child);
          },
          child: Icon(
            Icons.location_on,
            size: 52,
            color: colors.primary,
            shadows: const [
              Shadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),

        Transform.translate(
          offset: const Offset(0, -5),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 16,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ADDRESS CARD
  // ============================================================

  Widget _buildAddressCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainerLowest,
      elevation: 12,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border(top: BorderSide(color: colors.outlineVariant)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),

            const SizedBox(height: 20),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.08),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Row(
                key: ValueKey('$selectedAddress-$selectedArea-$selectedCity'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.home, color: colors.primary, size: 24),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedAddress,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          selectedArea,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          selectedCity,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: colors.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: AnimatedScaleButton(
                onPressed: _isConfirming ? null : _confirmLocation,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: _isConfirming
                      ? SizedBox(
                          key: const ValueKey('confirming'),
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: colors.onPrimary,
                          ),
                        )
                      : Text(
                          key: const ValueKey('confirm'),
                          'Confirm Location',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: colors.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// ANIMATED ICON BUTTON
// ================================================================

class _AnimatedIconButton extends StatefulWidget {
  const _AnimatedIconButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  State<_AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<_AnimatedIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      child: AnimatedScale(
        scale: _pressed ? 0.88 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Icon(widget.icon, color: widget.color),
        ),
      ),
    );
  }
}

// ================================================================
// ANIMATED SCALE BUTTON
// ================================================================

class AnimatedScaleButton extends StatefulWidget {
  const AnimatedScaleButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: widget.onPressed == null
          ? null
          : (_) {
              setState(() {
                _pressed = true;
              });
            },
      onTapUp: widget.onPressed == null
          ? null
          : (_) {
              setState(() {
                _pressed = false;
              });

              widget.onPressed?.call();
            },
      onTapCancel: widget.onPressed == null
          ? null
          : () {
              setState(() {
                _pressed = false;
              });
            },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: FilledButton(
          onPressed: widget.onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
