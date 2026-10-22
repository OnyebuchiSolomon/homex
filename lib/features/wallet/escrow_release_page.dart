import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class EscrowReleasePage extends StatefulWidget {
  const EscrowReleasePage({super.key});

  @override
  State<EscrowReleasePage> createState() =>
      _EscrowReleasePageState();
}

class _EscrowReleasePageState extends State<EscrowReleasePage>
    with TickerProviderStateMixin {
  late AnimationController _pageAnimationController;
  late AnimationController _pulseAnimationController;
  late AnimationController _timelineAnimationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _timelineAnimation;

  @override
  void initState() {
    super.initState();

    // ============================================================
    // PAGE ANIMATION
    // ============================================================

    _pageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _pageAnimationController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _pageAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.96,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _pageAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    // ============================================================
    // SUCCESS PULSE ANIMATION
    // ============================================================

    _pulseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.06,
    ).animate(
      CurvedAnimation(
        parent: _pulseAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // ============================================================
    // TIMELINE ANIMATION
    // ============================================================

    _timelineAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _timelineAnimation = CurvedAnimation(
      parent: _timelineAnimationController,
      curve: Curves.easeOutCubic,
    );

    _pageAnimationController.forward();

    Future.delayed(
      const Duration(milliseconds: 300),
          () {
        if (mounted) {
          _pulseAnimationController.repeat(
            reverse: true,
          );
        }
      },
    );

    Future.delayed(
      const Duration(milliseconds: 500),
          () {
        if (mounted) {
          _timelineAnimationController.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    _pulseAnimationController.dispose();
    _timelineAnimationController.dispose();
    super.dispose();
  }

  // ============================================================
  // MAIN BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final bool isSmallPhone = width < 360;
            final bool isPhone = width < 600;
            final bool isTablet =
                width >= 600 && width < 1024;
            final bool isDesktop = width >= 1024;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                isSmallPhone
                    ? 16
                    : isPhone
                    ? 20
                    : isTablet
                    ? 32
                    : 40,
                isPhone ? 28 : 48,
                isSmallPhone
                    ? 16
                    : isPhone
                    ? 20
                    : isTablet
                    ? 32
                    : 40,
                isPhone ? 40 : 56,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 768,
                  ),
                  child: AnimatedBuilder(
                    animation:
                    _pageAnimationController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Transform.scale(
                            scale: _scaleAnimation.value,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [
                        _buildSuccessHeader(
                          context,
                          width: width,
                        ),

                        SizedBox(
                          height: isPhone ? 24 : 32,
                        ),

                        _buildTransactionCard(
                          context,
                          width: width,
                        ),

                        SizedBox(
                          height: isPhone ? 16 : 20,
                        ),

                        _buildEscrowStatus(
                          context,
                          width: width,
                        ),

                        SizedBox(
                          height: isPhone ? 20 : 28,
                        ),

                        _buildActions(
                          context,
                          width: width,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // SUCCESS HEADER
  // ============================================================

  Widget _buildSuccessHeader(
      BuildContext context, {
        required double width,
      }) {
    final colors = context.colors;

    final bool isSmallPhone = width < 360;
    final bool isPhone = width < 600;

    final double outerCircleSize =
    isSmallPhone
        ? 76
        : isPhone
        ? 84
        : 96;

    final double innerCircleSize =
    isSmallPhone
        ? 52
        : isPhone
        ? 58
        : 64;

    final double iconSize =
    isSmallPhone
        ? 28
        : isPhone
        ? 32
        : 38;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: child,
            );
          },
          child: Container(
            width: outerCircleSize,
            height: outerCircleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
              colors.onTertiaryContainer.withValues(
                alpha: 0.10,
              ),
            ),
            child: Center(
              child: Container(
                width: innerCircleSize,
                height: innerCircleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.onTertiaryContainer,
                  boxShadow: [
                    BoxShadow(
                      color: colors.onTertiaryContainer
                          .withValues(alpha: 0.18),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: colors.onPrimary,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          height: isPhone ? 14 : 18,
        ),

        TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 0,
            end: 1,
          ),
          duration:
          const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (
              context,
              value,
              child,
              ) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(
                  0,
                  18 * (1 - value),
                ),
                child: child,
              ),
            );
          },
          child: Text(
            'Funds Released',
            textAlign: TextAlign.center,
            style: (isPhone
                ? AppTextStyles.headlineSmall
                : AppTextStyles.displayLarge)
                .copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: isSmallPhone
                  ? 20
                  : isPhone
                  ? 28
                  : 34,
            ),
          ),
        ),

        const SizedBox(height: 8),

        TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 0,
            end: 1,
          ),
          duration:
          const Duration(milliseconds: 850),
          curve: Curves.easeOutCubic,
          builder: (
              context,
              value,
              child,
              ) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(
                  0,
                  15 * (1 - value),
                ),
                child: child,
              ),
            );
          },
          child: Padding(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text.rich(
              TextSpan(
                text:
                'Your payment for ',
                children: [
                  TextSpan(
                    text:
                    'Lekki Phase 1 Luxury Villa',
                    style: AppTextStyles
                        .labelMedium
                        .copyWith(
                      color:
                      colors.onSurface,
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text:
                    ' has been released to the seller.',
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style:
              AppTextStyles.bodyLarge.copyWith(
                color:
                colors.onSurfaceVariant,
                height: 1.55,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TRANSACTION CARD
  // ============================================================

  Widget _buildTransactionCard(
      BuildContext context, {
        required double width,
      }) {
    final colors = context.colors;

    final bool isSmallPhone = width < 360;
    final bool isPhone = width < 600;

    return _AnimatedContent(
      delay: const Duration(milliseconds: 150),
      duration:
      const Duration(milliseconds: 700),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          isSmallPhone
              ? 16
              : isPhone
              ? 18
              : 24,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius:
          BorderRadius.circular(16),
          border: Border.all(
            color: colors.surfaceContainerHighest,
          ),
          boxShadow: [
            BoxShadow(
              color:
              colors.onSurface.withValues(
                alpha: 0.045,
              ),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Total Amount Released',
                    style: AppTextStyles
                        .labelMedium
                        .copyWith(
                      color:
                      colors.onSurfaceVariant,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Flexible(
                  child: Text(
                    '₦45,000,000',
                    textAlign: TextAlign.right,
                    style: AppTextStyles
                        .headlineMedium
                        .copyWith(
                      color:
                      colors.onSurface,
                      fontWeight:
                      FontWeight.w700,
                      fontSize:
                      isSmallPhone
                          ? 16
                          : isPhone
                          ? 18
                          : 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Divider(
              height: 1,
              color: colors.surfaceContainerHighest,
            ),

            const SizedBox(height: 18),

            LayoutBuilder(
              builder: (
                  context,
                  constraints,
                  ) {
                final compact =
                    constraints.maxWidth <
                        430;

                if (compact) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTransactionInfo(
                            context,
                            label: 'Transaction ID',
                            value: 'HMX-ESC-8921',
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          _buildTransactionInfo(
                            context,
                            label: 'Date',
                            value:
                            'Oct 24, 2023',
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      _buildBeneficiary(
                        context,
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:
                          _buildTransactionInfo(
                            context,
                            label:
                            'Transaction ID',
                            value:
                            'HMX-ESC-8921',
                          ),
                        ),

                        const SizedBox(
                          width: 20,
                        ),

                        Expanded(
                          child:
                          _buildTransactionInfo(
                            context,
                            label: 'Date',
                            value:
                            'Oct 24, 2023',
                            alignRight: true,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    _buildBeneficiary(
                      context,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TRANSACTION INFO
  // ============================================================

  Widget _buildTransactionInfo(
      BuildContext context, {
        required String label,
        required String value,
        bool alignRight = false,
      }) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: alignRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign:
          alignRight
              ? TextAlign.right
              : TextAlign.left,
          style: AppTextStyles.labelSmall.copyWith(
            color:
            colors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          textAlign:
          alignRight
              ? TextAlign.right
              : TextAlign.left,
          style: AppTextStyles.bodyMedium.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BENEFICIARY
  // ============================================================

  Widget _buildBeneficiary(
      BuildContext context,
      ) {
    final colors = context.colors;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color:
            colors.surfaceContainerHigh,
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: ImageView.networkCached(
            'https://images.unsplash.com/'
                'photo-1560250097-0b93528c311a'
                '?auto=format&fit=crop&w=200&q=80',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorWidget: Container(
              color:
              colors.surfaceContainerHigh,
              alignment: Alignment.center,
              child: Icon(
                Icons.person_outline_rounded,
                color:
                colors.onSurfaceVariant,
                size: 22,
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'Beneficiary',
                style:
                AppTextStyles.labelSmall
                    .copyWith(
                  color:
                  colors.onSurfaceVariant,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Adeyemi Properties Ltd.',
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: AppTextStyles
                    .labelMedium
                    .copyWith(
                  color:
                  colors.onSurface,
                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ESCROW STATUS
  // ============================================================

  Widget _buildEscrowStatus(
      BuildContext context, {
        required double width,
      }) {
    final colors = context.colors;

    final bool isSmallPhone = width < 360;
    final bool isPhone = width < 600;

    return _AnimatedContent(
      delay: const Duration(milliseconds: 280),
      duration:
      const Duration(milliseconds: 750),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          isSmallPhone
              ? 16
              : isPhone
              ? 18
              : 24,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius:
          BorderRadius.circular(16),
          border: Border.all(
            color: colors.surfaceVariant,
          ),
          boxShadow: [
            BoxShadow(
              color:
              colors.onSurface.withValues(
                alpha: 0.045,
              ),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Escrow Status',
              style:
              AppTextStyles.headlineSmall
                  .copyWith(
                color: colors.onSurface,
                fontWeight:
                FontWeight.w700,
              ),
            ),

            const SizedBox(height: 20),

            _buildTimeline(
              context,
              width: width,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TIMELINE
  // ============================================================

  Widget _buildTimeline(
      BuildContext context, {
        required double width,
      }) {
    final colors = context.colors;

    return AnimatedBuilder(
      animation: _timelineAnimation,
      builder: (context, child) {
        final value =
            _timelineAnimation.value;

        return Stack(
          children: [
            Positioned(
              left: 11,
              top: 14,
              bottom: 14,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color:
                  colors.onTertiaryContainer
                      .withValues(
                    alpha: 0.16,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                ),
              ),
            ),

            Column(
              children: [
                _buildTimelineStep(
                  context,
                  index: 0,
                  title:
                  'Funds Secured in Escrow',
                  date: 'Oct 10, 2023',
                  progress: value,
                  isLast: false,
                ),

                const SizedBox(height: 24),

                _buildTimelineStep(
                  context,
                  index: 1,
                  title:
                  'Inspection Confirmed',
                  date:
                  'Oct 24, 2023 - 09:15 AM',
                  progress: value,
                  isLast: false,
                ),

                const SizedBox(height: 24),

                _buildTimelineStep(
                  context,
                  index: 2,
                  title: 'Funds Released',
                  date: 'Completed',
                  progress: value,
                  isLast: true,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // TIMELINE STEP
  // ============================================================

  Widget _buildTimelineStep(
      BuildContext context, {
        required int index,
        required String title,
        required String date,
        required double progress,
        required bool isLast,
      }) {
    final colors = context.colors;

    final stepProgress =
    ((progress - (index * 0.18)) /
        0.55)
        .clamp(0.0, 1.0);

    return Opacity(
      opacity: stepProgress,
      child: Transform.translate(
        offset: Offset(
          15 * (1 - stepProgress),
          0,
        ),
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              margin:
              const EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                colors.onTertiaryContainer,
                border: Border.all(
                  color: colors
                      .surfaceContainerLowest,
                  width: 2,
                ),
                boxShadow: isLast
                    ? [
                  BoxShadow(
                    color: colors
                        .onTertiaryContainer
                        .withValues(
                      alpha: 0.16,
                    ),
                    blurRadius: 0,
                    spreadRadius: 4,
                  ),
                ]
                    : null,
              ),
              child: Icon(
                Icons.check_rounded,
                color: colors.onPrimary,
                size: 14,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles
                        .labelMedium
                        .copyWith(
                      color:
                      colors.onSurface,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    date,
                    style: AppTextStyles
                        .labelSmall
                        .copyWith(
                      color: isLast
                          ? colors
                          .onTertiaryContainer
                          : colors
                          .onSurfaceVariant,
                      fontWeight: isLast
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ACTIONS
  // ============================================================

  Widget _buildActions(
      BuildContext context, {
        required double width,
      }) {
    final colors = context.colors;

    final bool isPhone = width < 600;

    return _AnimatedContent(
      delay: const Duration(milliseconds: 450),
      duration:
      const Duration(milliseconds: 700),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: isPhone ? 52 : 56,
            child: FilledButton.icon(
              onPressed: () {
               AppNavigator.pushAndStackNamed(AppRoutes.reviewSellerScreen);
              },
              icon: const Icon(
                Icons.star_rounded,
                size: 20,
              ),
              label: Text(
                'Rate Your Experience',
                style:
                AppTextStyles.labelMedium
                    .copyWith(
                  fontWeight:
                  FontWeight.w600,
                  color:
                  colors.onPrimary,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor:
                colors.primaryContainer,
                foregroundColor:
                colors.onPrimary,
                elevation: 2,
                shadowColor:
                colors.onSurface.withValues(
                  alpha: 0.12,
                ),
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: isPhone ? 52 : 56,
            child: OutlinedButton(
              onPressed: () {
                _goToWallet(context);
              },
              style:
              OutlinedButton.styleFrom(
                foregroundColor:
                colors.primaryContainer,
                backgroundColor:
                colors.surfaceContainerLowest,
                side: BorderSide(
                  color: colors.surfaceContainerHighest,
                ),
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Go to Wallet',
                style:
                AppTextStyles.labelMedium
                    .copyWith(
                  color:
                  colors.primaryContainer,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // RATING DIALOG
  // ============================================================

  void _showRatingDialog(
      BuildContext context,
      ) {
    final colors = context.colors;

    showDialog(
      context: context,
      builder: (context) {
        int selectedRating = 0;

        return StatefulBuilder(
          builder: (
              context,
              setDialogState,
              ) {
            return AlertDialog(
              backgroundColor:
              colors.surfaceContainerLowest,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20),
              ),
              title: Text(
                'Rate Your Experience',
                style: AppTextStyles
                    .headlineSmall
                    .copyWith(
                  fontWeight:
                  FontWeight.w700,
                ),
              ),
              content: Column(
                mainAxisSize:
                MainAxisSize.min,
                children: [
                  Text(
                    'How was your experience with this transaction?',
                    textAlign:
                    TextAlign.center,
                    style: AppTextStyles
                        .bodyMedium
                        .copyWith(
                      color: colors
                          .onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) {
                        final selected =
                            index <
                                selectedRating;

                        return IconButton(
                          onPressed: () {
                            setDialogState(() {
                              selectedRating =
                                  index + 1;
                            });
                          },
                          icon: Icon(
                            selected
                                ? Icons
                                .star_rounded
                                : Icons
                                .star_outline_rounded,
                            color: selected
                                ? colors
                                .secondaryContainer
                                : colors
                                .onSurfaceVariant,
                            size: 34,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop();
                  },
                  child:
                  const Text('Cancel'),
                ),
                FilledButton(
                  onPressed:
                  selectedRating == 0
                      ? null
                      : () {
                    Navigator.of(
                      context,
                    ).pop();

                    ScaffoldMessenger
                        .of(
                      this.context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Thank you for your rating.',
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Submit',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ============================================================
  // GO TO WALLET
  // ============================================================

  void _goToWallet(
      BuildContext context,
      ) {
    Navigator.of(context).pop();
  }
}

// ================================================================
// ANIMATED CONTENT
// ================================================================

class _AnimatedContent extends StatefulWidget {
  const _AnimatedContent({
    required this.child,
    required this.delay,
    required this.duration,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  State<_AnimatedContent> createState() =>
      _AnimatedContentState();
}

class _AnimatedContentState
    extends State<_AnimatedContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    Future.delayed(
      widget.delay,
          () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (
          context,
          child,
          ) {
        final value = animation.value;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              0,
              25 * (1 - value),
            ),
            child: Transform.scale(
              scale:
              0.97 + (0.03 * value),
              child: child,
            ),
          ),
        );
      },
    );
  }
}