import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class PropertyDetailsPage extends StatefulWidget {
  const PropertyDetailsPage({super.key});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage>
    with SingleTickerProviderStateMixin {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  bool isForSale = true;

  int bedrooms = 3;
  int bathrooms = 2;
  int parking = 1;

  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _progressAnimation = Tween<double>(begin: 0, end: 2 / 6).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
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
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 768),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildProgress(context),

                            const SizedBox(height: 32),

                            _buildForm(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            _buildBottomButton(context),
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

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, -12 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(
            bottom: BorderSide(
              color: colors.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: 'Back',
              icon: Icon(Icons.arrow_back, color: colors.onSurface),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Property Details',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  'Step 2 of 6',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 48),
          ],
        ),
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
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: _progressAnimation.value,
            minHeight: 10,
            backgroundColor: colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
          ),
        );
      },
    );
  }

  // ============================================================
  // FORM
  // ============================================================

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPurpose(context),

        const SizedBox(height: 24),

        _AnimatedFormItem(
          delay: 80,
          child: _buildTextField(
            context,
            label: 'Property Title',
            hint: 'e.g. Luxury 4 Bedroom Duplex',
            controller: titleController,
            icon: Icons.home_work_outlined,
          ),
        ),

        const SizedBox(height: 20),

        _AnimatedFormItem(delay: 140, child: _buildDescription(context)),

        const SizedBox(height: 20),

        _AnimatedFormItem(
          delay: 200,
          child: _buildTextField(
            context,
            label: 'Price',
            hint: '0.00',
            controller: priceController,
            icon: Icons.payments_outlined,
            prefix: '₦',
            keyboardType: TextInputType.number,
          ),
        ),

        const SizedBox(height: 28),

        const Divider(),

        const SizedBox(height: 24),

        _AnimatedFormItem(delay: 260, child: _buildFeatureCounters(context)),
      ],
    );
  }

  // ============================================================
  // PURPOSE
  // ============================================================

  Widget _buildPurpose(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _AnimatedFormItem(
      delay: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Purpose',
            style: AppTextStyles.labelMedium.copyWith(color: colors.onSurface),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _purposeButton(
                    context,
                    title: 'Sell',
                    selected: isForSale,
                    onTap: () {
                      if (!isForSale) {
                        setState(() {
                          isForSale = true;
                        });
                      }
                    },
                  ),
                ),

                Expanded(
                  child: _purposeButton(
                    context,
                    title: 'Rent',
                    selected: !isForSale,
                    onTap: () {
                      if (isForSale) {
                        setState(() {
                          isForSale = false;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _purposeButton(
    BuildContext context, {
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? colors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          style: AppTextStyles.labelMedium.copyWith(
            color: selected ? colors.onPrimary : colors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    IconData? icon,
    String? prefix,
    TextInputType? keyboardType,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(color: colors.onSurface),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: hint,

            prefixIcon: icon == null ? null : Icon(icon, color: colors.outline),

            prefixText: prefix,

            prefixStyle: AppTextStyles.headlineSmall.copyWith(
              color: colors.outline,
            ),

            filled: true,

            fillColor: colors.surfaceContainerLowest,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.primary, width: 2),
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  Widget _buildDescription(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyles.labelMedium.copyWith(color: colors.onSurface),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: descriptionController,
          minLines: 4,
          maxLines: 6,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            hintText: 'Describe the key features and selling points...',

            filled: true,

            fillColor: colors.surfaceContainerLowest,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.primary, width: 2),
            ),

            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FEATURE COUNTERS
  // ============================================================

  Widget _buildFeatureCounters(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features',
          style: AppTextStyles.headlineSmall.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 20),

        _counter(
          context,
          title: 'Bedrooms',
          icon: Icons.bed_outlined,
          value: bedrooms,
          onDecrease: () {
            if (bedrooms > 0) {
              setState(() => bedrooms--);
            }
          },
          onIncrease: () {
            setState(() => bedrooms++);
          },
        ),

        const SizedBox(height: 20),

        _counter(
          context,
          title: 'Bathrooms',
          icon: Icons.bathtub_outlined,
          value: bathrooms,
          onDecrease: () {
            if (bathrooms > 0) {
              setState(() => bathrooms--);
            }
          },
          onIncrease: () {
            setState(() => bathrooms++);
          },
        ),

        const SizedBox(height: 20),

        _counter(
          context,
          title: 'Parking',
          icon: Icons.directions_car_outlined,
          value: parking,
          onDecrease: () {
            if (parking > 0) {
              setState(() => parking--);
            }
          },
          onIncrease: () {
            setState(() => parking++);
          },
        ),
      ],
    );
  }

  Widget _counter(
    BuildContext context, {
    required String title,
    required IconData icon,
    required int value,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(icon, key: ValueKey(icon), color: colors.outline),
            ),

            const SizedBox(width: 12),

            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(color: colors.onSurface),
            ),
          ],
        ),

        Row(
          children: [
            _counterButton(context, icon: Icons.remove, onTap: onDecrease),

            SizedBox(
              width: 50,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Text(
                  '$value',
                  key: ValueKey(value),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            _counterButton(context, icon: Icons.add, onTap: onIncrease),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // COUNTER BUTTON
  // ============================================================

  Widget _counterButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainerLow,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Center(
            child: Icon(icon, size: 18, color: colors.onSurfaceVariant),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM BUTTON
  // ============================================================

  Widget _buildBottomButton(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(
            top: BorderSide(
              color: colors.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton(
              onPressed: () {
                FocusScope.of(context).unfocus();

                AppNavigator.pushAndStackNamed(
                  AppRoutes.addPropertyLocationPage,
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// ANIMATED FORM ITEM
// ================================================================

class _AnimatedFormItem extends StatefulWidget {
  final Widget child;
  final int delay;

  const _AnimatedFormItem({required this.child, required this.delay});

  @override
  State<_AnimatedFormItem> createState() => _AnimatedFormItemState();
}

class _AnimatedFormItemState extends State<_AnimatedFormItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
