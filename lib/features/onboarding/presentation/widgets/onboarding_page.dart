import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/animation/app_animations.dart';
import '../../../../core/extensions/custom_context_extension.dart';
 import '../../../../core/widgets/image_view.dart';
import '../../models/onboarding_item.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingItem item;
  final int pageIndex;
  final int currentPage;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.pageIndex,
    required this.currentPage,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.medium,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.enter,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: AppAnimations.splashCurve,
          ),
        );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant OnboardingPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPage != widget.currentPage &&
        widget.currentPage == widget.pageIndex) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // bool get _isTrustPage => widget.pageIndex == 3;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(position: _slideAnimation, child: child),
        );
      },
      child: /*_isTrustPage
          ? _buildTrustPage(context)
          :*/ _buildStandardPage(context),
    );
  }

  // ================================================================
  // STANDARD ONBOARDING PAGE
  // ================================================================

  Widget _buildStandardPage(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.widthOf(4)),
      child: Column(
        children: [
          const Spacer(),

          // ------------------------------------------------------------
          // IMAGE
          // ------------------------------------------------------------
          _buildImageCard(context),

          SizedBox(height: context.heightOf(3.5)),

          // ------------------------------------------------------------
          // TEXT
          // ------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Text(
                  widget.item.title,
                  textAlign: TextAlign.center,
                  style: textTheme.displaySmall?.copyWith(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                    letterSpacing: -0.6,
                  ),
                ),

                SizedBox(height: context.heightOf(1.5)),

                Text(
                  widget.item.description,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }

  // ================================================================
  // IMAGE CARD
  // ================================================================

  Widget _buildImageCard(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 480),
      height: context.heightOf(38),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.surfaceContainerHighest),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageView.asset(widget.item.image, fit: BoxFit.cover),

          // ----------------------------------------------------------
          // GLASS BADGE
          // ----------------------------------------------------------
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _GlassBadge(
              badge: widget.item.badge,
              action: widget.item.badgeAction,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // TRUST / REPUTATION PAGE
  // ================================================================

  // Widget _buildTrustPage(BuildContext context) {
  //   final colors = context.colors;
  //   final textTheme = context.textTheme;
  //
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: context.widthOf(4)),
  //     child: Column(
  //       children: [
  //         const Spacer(),
  //
  //         SizedBox(
  //           height: context.heightOf(34),
  //           width: double.infinity,
  //           child: Stack(
  //             clipBehavior: Clip.none,
  //             children: [
  //               // Decorative background
  //               Positioned.fill(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     color: colors.primaryFixed.withValues(alpha: 0.20),
  //                   ),
  //                   child: BackdropFilter(
  //                     filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
  //                     child: const SizedBox(),
  //                   ),
  //                 ),
  //               ),
  //
  //               // Landlord card
  //               Positioned(
  //                 top: 12,
  //                 left: 0,
  //                 child: _ReputationCard(
  //                   name: 'Chidi',
  //                   role: 'Landlord',
  //                   rating: 'Excellent',
  //                   ratingColor: colors.onTertiaryContainer,
  //                   icon: Icons.verified_rounded,
  //                   rotation: -0.03,
  //                 ),
  //               ),
  //
  //               // Tenant card
  //               Positioned(
  //                 bottom: 12,
  //                 right: 0,
  //                 child: _ReputationCard(
  //                   name: 'Bisi',
  //                   role: 'Tenant',
  //                   rating: '9.8/10',
  //                   ratingColor: colors.onTertiaryContainer,
  //                   icon: Icons.verified_rounded,
  //                   rotation: 0.03,
  //                 ),
  //               ),
  //
  //               // Center handshake
  //               Positioned.fill(
  //                 child: Center(
  //                   child: Container(
  //                     width: 128,
  //                     height: 128,
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       color: colors.primaryFixed.withValues(alpha: .2),
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: colors.primary.withValues(alpha: 0.12),
  //                           blurRadius: 20,
  //                           offset: const Offset(0, 10),
  //                         ),
  //                       ],
  //                     ),
  //                     child: Icon(
  //                       Icons.handshake_rounded,
  //                       size: 52,
  //                       color: colors.primary,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //
  //         SizedBox(height: context.heightOf(3)),
  //
  //         // ----------------------------------------------------------
  //         // TITLE
  //         // ----------------------------------------------------------
  //         Text(
  //           widget.item.title,
  //           textAlign: TextAlign.center,
  //           style: textTheme.displaySmall?.copyWith(
  //             fontFamily: 'Inter',
  //             fontWeight: FontWeight.w700,
  //             color: colors.onSurface,
  //             letterSpacing: -0.6,
  //           ),
  //         ),
  //
  //         SizedBox(height: context.heightOf(1.5)),
  //
  //         Text(
  //           widget.item.description,
  //           textAlign: TextAlign.center,
  //           style: textTheme.bodyLarge?.copyWith(
  //             color: colors.onSurfaceVariant,
  //             height: 1.55,
  //           ),
  //         ),
  //
  //         const Spacer(),
  //       ],
  //     ),
  //   );
  // }
}

// ============================================================================
// GLASS BADGE
// ============================================================================

class _GlassBadge extends StatelessWidget {
  final String badge;
  final String action;

  const _GlassBadge({required this.badge, required this.action});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest.withValues(alpha: 0.80),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.surfaceContainerHighest),
          ),
          child: Row(
            children: [
              Icon(
                Icons.verified_rounded,
                size: 20,
                color: colors.secondaryContainer,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  badge,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurface,
                  ),
                ),
              ),

              Text(
                action,
                style: textTheme.labelSmall,
              ),

              const SizedBox(width: 4),

              Icon(Icons.handshake_outlined, size: 17,),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// REPUTATION CARD
// ============================================================================

// class _ReputationCard extends StatelessWidget {
//   final String name;
//   final String role;
//   final String rating;
//   final Color ratingColor;
//   final IconData icon;
//   final double rotation;
//
//   const _ReputationCard({
//     required this.name,
//     required this.role,
//     required this.rating,
//     required this.ratingColor,
//     required this.icon,
//     required this.rotation,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final colors = context.colors;
//     final textTheme = context.textTheme;
//
//     return Transform.rotate(
//       angle: rotation,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(14),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//           child: Container(
//             width: context.widthPx > 500 ? 240 : 220,
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: colors.surfaceContainerLowest.withValues(alpha: 0.82),
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(color: colors.surfaceVariant),
//               boxShadow: [
//                 BoxShadow(
//                   color: colors.primary.withValues(alpha: 0.08),
//                   blurRadius: 15,
//                   offset: const Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: colors.surfaceContainer,
//                   ),
//                   child: Icon(
//                     Icons.person_rounded,
//                     color: colors.onSurfaceVariant,
//                   ),
//                 ),
//
//                 const SizedBox(width: 10),
//
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         style: textTheme.labelMedium?.copyWith(
//                           color: colors.onSurface,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         role,
//                         style: textTheme.labelSmall?.copyWith(
//                           color: colors.onSurfaceVariant,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Icon(icon, size: 20, color: colors.secondaryContainer),
//                     const SizedBox(height: 4),
//                     Text(
//                       rating,
//                       style: textTheme.labelSmall?.copyWith(
//                         color: ratingColor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
