import 'package:flutter/material.dart';

class DisputeSummaryPage extends StatefulWidget {
  const DisputeSummaryPage({
    super.key,
    this.category = 'Property Misrepresentation',
    this.description =
    'The property listing clearly stated that all major appliances were included and in working condition. Upon final walkthrough, the refrigerator was missing and the HVAC system was non-functional. I have attached the original listing agreement and quotes for repair.',
    this.escrowAmount = '₦ 45,000,000',
    this.onSubmitted,
  });

  final String category;
  final String description;
  final String escrowAmount;
  final VoidCallback? onSubmitted;

  @override
  State<DisputeSummaryPage> createState() => _DisputeSummaryPageState();
}

class _DisputeSummaryPageState extends State<DisputeSummaryPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  bool _isSubmitting = false;

  final List<_EvidenceItem> _evidence = const [
    _EvidenceItem(
      name: 'listing_agreement.pdf',
      type: _EvidenceType.image,
      icon: Icons.description_outlined,
    ),
    _EvidenceItem(
      name: 'kitchen_photo.jpg',
      type: _EvidenceType.image,
      icon: Icons.image_outlined,
    ),
    _EvidenceItem(
      name: 'hvac_repair_quote.pdf',
      type: _EvidenceType.pdf,
      icon: Icons.description_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _submitDispute() async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    // Replace this with your API/repository call.
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    widget.onSubmitted?.call();

    // Replace with your actual success route.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const DisputeSubmittedPage(),
      ),
    );
  }

  void _showEvidence(_EvidenceItem evidence) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return _EvidencePreviewSheet(evidence: evidence);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context),

            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      20,
                      16,
                      32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 24),

                        _buildSummaryCard(context),
                        const SizedBox(height: 16),

                        _buildEvidenceCard(context),
                        const SizedBox(height: 16),

                        _buildEscrowProtection(context),
                        const SizedBox(height: 24),

                        _buildActions(context),
                      ],
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

  Widget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            _PressScaleButton(
              onTap: () => Navigator.of(context).maybePop(),
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.arrow_back),
              ),
            ),

            const SizedBox(width: 4),

            Text(
              'HomeX',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.primary,
                letterSpacing: -0.4,
              ),
            ),

            const Spacer(),

            _PressScaleButton(
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review & Submit',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            height: 1.25,
            letterSpacing: -0.7,
            //color: colors.primary,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Please review the details of your dispute before final submission.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
            fontSize: 14,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step 3 of 3',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '100%',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Container(
            height: 12,
            width: double.infinity,
            color: colors.surfaceContainerHighest,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DISPUTE CATEGORY',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Icon(
                Icons.gavel,
                color: colors.secondaryContainer,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.category,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Divider(
            height: 1,
            color: colors.outlineVariant,
          ),

          const SizedBox(height: 16),

          Text(
            'DETAILED DESCRIPTION',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            widget.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurface,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Transaction Value in Escrow',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.escrowAmount,
                  style: theme.textTheme.titleLarge?.copyWith(
                  //  color: colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenceCard(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ATTACHED EVIDENCE (3 FILES)',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _evidence.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return _EvidenceThumbnail(
                evidence: _evidence[index],
                onTap: () => _showEvidence(_evidence[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEscrowProtection(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.tertiaryContainer.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.tertiaryContainer.withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield,
            color: colors.tertiaryContainer,
            size: 24,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Escrow Protection Active',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.tertiaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Your funds are held securely in escrow while we investigate this dispute. No funds will be released until a resolution is reached.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurface,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: _PressScaleButton(
            onTap: _isSubmitting
                ? null
                : () => Navigator.of(context).maybePop(),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colors.outlineVariant,
                ),
              ),
              child: Text(
                'Cancel',
                style: theme.textTheme.labelLarge?.copyWith(
                 // color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          height: 52,
          child: _PressScaleButton(
            onTap: _isSubmitting ? null : _submitDispute,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: colors.outlineVariant,
                ),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _isSubmitting
                      ? SizedBox(
                    key: const ValueKey('loading'),
                    width: 21,
                    height: 21,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: colors.onPrimary,
                    ),
                  )
                      : Row(
                    key: const ValueKey('submit'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Submit Dispute',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.send,
                        size: 20,
                        color: colors.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// -----------------------------------------------------------------------------
// Evidence thumbnail
// -----------------------------------------------------------------------------

class _EvidenceThumbnail extends StatelessWidget {
  const _EvidenceThumbnail({
    required this.evidence,
    required this.onTap,
  });

  final _EvidenceItem evidence;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return _PressScaleButton(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            border: Border.all(
              color: colors.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: evidence.type == _EvidenceType.image
                    ? _buildImagePlaceholder(context)
                    : _buildPdfPreview(context),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest.withValues(
                      alpha: 0.92,
                    ),
                  ),
                  child: Text(
                    evidence.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.visibility,
                      color: colors.onPrimary,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.surfaceContainerHigh,
      child: Center(
        child: Icon(
          evidence.icon,
          size: 42,
          color: colors.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildPdfPreview(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      color: colors.surfaceContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 36,
            color: colors.onSurfaceVariant,
          ),
          const SizedBox(height: 6),
          Text(
            'PDF Document',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}


// -----------------------------------------------------------------------------
// Evidence preview
// -----------------------------------------------------------------------------

class _EvidencePreviewSheet extends StatelessWidget {
  const _EvidencePreviewSheet({
    required this.evidence,
  });

  final _EvidenceItem evidence;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: colors.outlineVariant,
                borderRadius: BorderRadius.circular(99),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Icon(
                  evidence.icon,
                  color: colors.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    evidence.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  evidence.type == _EvidenceType.pdf
                      ? Icons.picture_as_pdf_outlined
                      : evidence.icon,
                  size: 64,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


// -----------------------------------------------------------------------------
// Press animation
// -----------------------------------------------------------------------------

class _PressScaleButton extends StatefulWidget {
  const _PressScaleButton({
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<_PressScaleButton> createState() => _PressScaleButtonState();
}

class _PressScaleButtonState extends State<_PressScaleButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? widget.onTap : null,
      onTapDown: enabled
          ? (_) => setState(() => _pressed = true)
          : null,
      onTapUp: enabled
          ? (_) => setState(() => _pressed = false)
          : null,
      onTapCancel: enabled
          ? () => setState(() => _pressed = false)
          : null,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}


// -----------------------------------------------------------------------------
// Models
// -----------------------------------------------------------------------------

enum _EvidenceType {
  image,
  pdf,
}

class _EvidenceItem {
  const _EvidenceItem({
    required this.name,
    required this.type,
    required this.icon,
  });

  final String name;
  final _EvidenceType type;
  final IconData icon;
}


// -----------------------------------------------------------------------------
// Temporary success destination
// Replace this with your existing dispute submitted/success route.
// -----------------------------------------------------------------------------

class DisputeSubmittedPage extends StatelessWidget {
  const DisputeSubmittedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                size: 72,
                color: colors.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Dispute Submitted',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your dispute has been submitted successfully.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}