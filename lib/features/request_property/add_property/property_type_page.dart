import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class PropertyTypePage extends StatefulWidget {
  const PropertyTypePage({super.key});

  @override
  State<PropertyTypePage> createState() => _PropertyTypePageState();
}

class _PropertyTypePageState extends State<PropertyTypePage>
    with SingleTickerProviderStateMixin {
  String? selectedType;

  late AnimationController _pageAnimationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _progressAnimation;

  final List<Map<String, dynamic>> propertyTypes = [
    {
      'title': 'House',
      'description':
      'Standalone home, townhome, or multi-family building.',
      'icon': Icons.house_outlined,
    },
    {
      'title': 'Apartment',
      'description':
      'Condo, flat, or unit within a larger residential building.',
      'icon': Icons.apartment_outlined,
    },
    {
      'title': 'Land',
      'description':
      'Residential, commercial, agricultural, or undeveloped land.',
      'icon': Icons.landscape_outlined,
    },
    {
      'title': 'Commercial',
      'description':
      'Office, shop, warehouse, retail, or other commercial property.',
      'icon': Icons.business_outlined,
    },
  ];

  @override
  void initState() {
    super.initState();

    _pageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _pageAnimationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _pageAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: 1 / 6,
    ).animate(
      CurvedAnimation(
        parent: _pageAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _pageAnimationController.forward();
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  16,
                  24,
                  16,
                  32,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 768,
                    ),
                    child: AnimatedBuilder(
                      animation: _pageAnimationController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          _buildProgress(context),

                          const SizedBox(height: 32),

                          _buildTitle(context),

                          const SizedBox(height: 32),

                          _buildPropertyTypes(context),

                          const SizedBox(height: 32),

                          _buildContinueButton(context),
                        ],
                      ),
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

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _AnimatedIconButton(
            icon: Icons.close,
            tooltip: 'Close',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          Text(
            'List Your Property',
            style: AppTextStyles.headlineSmall.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ============================================================
  // PROGRESS
  // ============================================================

  Widget _buildProgress(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Step 1 of 6',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),

                Text(
                  'Property Type',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: _progressAnimation.value,
                minHeight: 10,
                backgroundColor:
                colors.surfaceContainerHighest,
                valueColor:
                AlwaysStoppedAnimation<Color>(
                  colors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // TITLE
  // ============================================================

  Widget _buildTitle(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What are you listing?',
          style: AppTextStyles.headlineMedium.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Select the property type that best describes your listing.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROPERTY TYPES
  // ============================================================

  Widget _buildPropertyTypes(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;

        if (isWide) {
          return GridView.builder(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.55,
            ),
            itemCount: propertyTypes.length,
            itemBuilder: (context, index) {
              return _buildAnimatedPropertyCard(
                context,
                propertyTypes[index],
                index,
              );
            },
          );
        }

        return Column(
          children: List.generate(
            propertyTypes.length,
                (index) {
              return Padding(
                padding:
                const EdgeInsets.only(bottom: 16),
                child: _buildAnimatedPropertyCard(
                  context,
                  propertyTypes[index],
                  index,
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ============================================================
  // ANIMATED PROPERTY CARD
  // ============================================================

  Widget _buildAnimatedPropertyCard(
      BuildContext context,
      Map<String, dynamic> type,
      int index,
      ) {
    final delay = index * 120;

    return TweenAnimationBuilder<double>(
      key: ValueKey(type['title']),
      tween: Tween(begin: 0, end: 1),
      duration: Duration(
        milliseconds: 550 + delay,
      ),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final curvedValue =
        Curves.easeOutCubic.transform(value);

        return Opacity(
          opacity: curvedValue,
          child: Transform.translate(
            offset: Offset(
              0,
              30 * (1 - curvedValue),
            ),
            child: Transform.scale(
              scale: 0.94 + (0.06 * curvedValue),
              child: child,
            ),
          ),
        );
      },
      child: _propertyCard(
        context,
        type,
      ),
    );
  }

  // ============================================================
  // PROPERTY CARD
  // ============================================================

  Widget _propertyCard(
      BuildContext context,
      Map<String, dynamic> type,
      ) {
    final colors = Theme.of(context).colorScheme;

    final title = type['title'] as String;
    final description =
    type['description'] as String;
    final icon = type['icon'] as IconData;

    final selected = selectedType == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected
              ? colors.surfaceContainerLow
              : colors.surfaceContainerLowest,
          borderRadius:
          BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? colors.primary
                : colors.outlineVariant,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color:
              Colors.black.withValues(
                alpha: 0.08,
              ),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ]
              : null,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            AnimatedScale(
              scale: selected ? 1.08 : 1.0,
              duration:
              const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              child: AnimatedContainer(
                duration:
                const Duration(milliseconds: 250),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: selected
                      ? colors.primary
                      : colors.surfaceContainerLow,
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                child: AnimatedSwitcher(
                  duration:
                  const Duration(milliseconds: 250),
                  transitionBuilder:
                      (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: Icon(
                    icon,
                    key: ValueKey(
                      '$title-$selected',
                    ),
                    size: 28,
                    color: selected
                        ? colors.onPrimary
                        : colors.onSurface,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            AnimatedDefaultTextStyle(
              duration:
              const Duration(milliseconds: 250),
              style:
              AppTextStyles.headlineMedium.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
              child: Text(title),
            ),

            const SizedBox(height: 8),

            Text(
              description,
              style:
              AppTextStyles.bodyMedium.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CONTINUE BUTTON
  // ============================================================

  Widget _buildContinueButton(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final enabled = selectedType != null;

    return AnimatedOpacity(
      duration:
      const Duration(milliseconds: 250),
      opacity: enabled ? 1.0 : 0.75,
      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..scale(enabled ? 1.0 : 0.98),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: FilledButton(
            onPressed: enabled
                ? () {
              AppNavigator.pushAndStackNamed(
                AppRoutes.propertyDetailsPage,
              );
            }
                : null,
            style: FilledButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              disabledBackgroundColor:
              colors.surfaceContainerHighest,
              disabledForegroundColor:
              colors.onSurfaceVariant,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(12),
              ),
            ),
            child: AnimatedSwitcher(
              duration:
              const Duration(milliseconds: 250),
              transitionBuilder:
                  (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
              child: Text(
                'Continue',
                key: ValueKey(enabled),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// ANIMATED HEADER ICON BUTTON
// ================================================================

class _AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final String? tooltip;
  final VoidCallback onPressed;

  const _AnimatedIconButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  @override
  State<_AnimatedIconButton> createState() =>
      _AnimatedIconButtonState();
}

class _AnimatedIconButtonState
    extends State<_AnimatedIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors =
        Theme.of(context).colorScheme;

    return Tooltip(
      message: widget.tooltip ?? '',
      child: GestureDetector(
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
          duration:
          const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Center(
              child: Icon(
                widget.icon,
                color: colors.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}