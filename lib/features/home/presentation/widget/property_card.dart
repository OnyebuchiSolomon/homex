import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';
import 'package:homex/features/home/model/home_model.dart';

class PropertyCard extends StatefulWidget {
  final Property property;

  const PropertyCard({
    super.key,
    required this.property,
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  bool _pressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animation);

    _scale = Tween<double>(
      begin: 0.96,
      end: 1,
    ).animate(animation);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setPressed(bool value) {
    if (!mounted) return;

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedScale(
          scale: _pressed ? 0.985 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: GestureDetector(
            onTapDown: (_) => _setPressed(true),
            onTapCancel: () => _setPressed(false),
            onTapUp: (_) {
              _setPressed(false);

              AppNavigator.pushAndStackNamed(
                AppRoutes.propertyDetailsScreen,
              );
            },
            child: CustomCard(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =====================================================
                  // IMAGE
                  // =====================================================

                  AspectRatio(
                    aspectRatio: 1.35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            widget.property.imageUrl,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                color: colors.surfaceContainer,
                                child: Icon(
                                  Icons.home_work_outlined,
                                  size: 48,
                                  color:
                                  colors.onSurfaceVariant,
                                ),
                              );
                            },
                          ),

                          // Dark gradient at bottom of image.
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [
                                    0.55,
                                    1.0,
                                  ],
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(
                                      alpha: 0.22,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // VERIFIED BADGE
                          if (widget.property.verified)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                  colors.secondaryContainer,
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize:
                                  MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.verified_rounded,
                                      size: 14,
                                      color: colors
                                          .onSecondaryContainer,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Verified',
                                      style: textTheme
                                          .labelSmall
                                          ?.copyWith(
                                        color: colors
                                            .onSecondaryContainer,
                                        fontWeight:
                                        FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =====================================================
                  // PROPERTY INFORMATION
                  // =====================================================

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        // PRICE + RATING
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                widget.property.price,
                                maxLines: 1,
                                overflow:
                                TextOverflow.ellipsis,
                                style: textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight:
                                  FontWeight.w700,
                                  color: colors.onSurface,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color:
                                colors.surfaceContainerLow,
                                borderRadius:
                                BorderRadius.circular(7),
                              ),
                              child: Row(
                                mainAxisSize:
                                MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    size: 14,
                                    color:
                                    colors.secondary,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    widget.property.rating,
                                    style: textTheme
                                        .labelSmall
                                        ?.copyWith(
                                      color: colors
                                          .onSurfaceVariant,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 7),

                        // TITLE
                        Text(
                          widget.property.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                          textTheme.bodyLarge?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // LOCATION
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color:
                              colors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                widget.property.location,
                                maxLines: 1,
                                overflow:
                                TextOverflow.ellipsis,
                                style: textTheme.labelMedium
                                    ?.copyWith(
                                  color: colors
                                      .onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}