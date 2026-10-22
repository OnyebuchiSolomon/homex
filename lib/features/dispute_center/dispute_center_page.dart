import 'package:homex/ui/global.dart';

class DisputeCenterPage extends StatefulWidget {
  const DisputeCenterPage({super.key});

  @override
  State<DisputeCenterPage> createState() => _DisputeCenterPageState();
}

class _DisputeCenterPageState extends State<DisputeCenterPage>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;

  late final AnimationController _animationController;

  final List<DisputeModel> _activeDisputes = [
    DisputeModel(
      title: 'Lekki Phase 1 Luxury Villa',
      type: 'Property Misrepresentation',
      date: 'Oct 24, 2023',
      status: DisputeStatus.underReview,
      icon: Icons.assignment_late_outlined,
    ),
    DisputeModel(
      title: 'Victoria Island Commercial Plot',
      type: 'Payment Discrepancy',
      date: 'Oct 20, 2023',
      status: DisputeStatus.awaitingResponse,
      icon: Icons.account_balance_wallet_outlined,
    ),
    DisputeModel(
      title: 'Ikoyi Waterfront Apartment',
      type: 'Title Deed Verification',
      date: 'Oct 18, 2023',
      status: DisputeStatus.underReview,
      icon: Icons.description_outlined,
    ),
  ];

  final List<DisputeModel> _pastDisputes = [
    DisputeModel(
      title: 'Abuja Residential Estate',
      type: 'Payment Discrepancy',
      date: 'Sep 12, 2023',
      status: DisputeStatus.resolved,
      icon: Icons.account_balance_wallet_outlined,
    ),
    DisputeModel(
      title: 'Port Harcourt Apartment',
      type: 'Property Misrepresentation',
      date: 'Aug 30, 2023',
      status: DisputeStatus.resolved,
      icon: Icons.assignment_late_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<DisputeModel> get _currentDisputes {
    return _selectedTab == 0 ? _activeDisputes : _pastDisputes;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: const Text('Dispute Center')),
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final bool isMobile = width < 600;
            final bool isTablet = width >= 600 && width < 1024;

            return Column(
              children: [
                Expanded(
                  child: _buildContent(
                    context,
                    width: width,
                    isMobile: isMobile,
                    isTablet: isTablet,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // MAIN CONTENT
  // ---------------------------------------------------------------------------

  Widget _buildContent(
      BuildContext context, {
        required double width,
        required bool isMobile,
        required bool isTablet,
      }) {
    final horizontalPadding = isMobile
        ? 16.0
        : isTablet
        ? 24.0
        : 40.0;

    const maxContentWidth = 1280.0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        isMobile ? 18 : 22,
        horizontalPadding,
        isMobile ? 100 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageHeader(context, isMobile: isMobile, isTablet: isTablet),
              SizedBox(height: isMobile ? 24 : 32),
              _buildTabs(context),
              const SizedBox(height: 24),
              _buildDisputes(
                context,
                width: width,
                isMobile: isMobile,
                isTablet: isTablet,
              ),
              if (_currentDisputes.isEmpty) _buildEmptyState(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PAGE HEADER
  // ---------------------------------------------------------------------------

  Widget _buildPageHeader(
      BuildContext context, {
        required bool isMobile,
        required bool isTablet,
      }) {
    final theme = Theme.of(context);

    final title = Text(
      'Dispute Center',
      style: theme.textTheme.titleLarge?.copyWith(
        fontSize: isMobile ? 22 : 28,
        height: isMobile ? 1.25 : 1.16,
        letterSpacing: -1.0,
        fontWeight: FontWeight.w700,
        color: theme.colorScheme.onSurface,
      ),
    );

    final description = Text(
      'Manage and track your active and resolved disputes securely.',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        height: 1.5,
      ),
    );

    final button = _buildReportButton(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _animatedItem(index: 0, child: title),
          const SizedBox(height: 8),
          _animatedItem(index: 1, child: description),
          const SizedBox(height: 20),
          _animatedItem(
            index: 2,
            child: SizedBox(width: double.infinity, child: button),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _animatedItem(index: 0, child: title),
              const SizedBox(height: 8),
              _animatedItem(index: 1, child: description),
            ],
          ),
        ),
        const SizedBox(width: 24),
        _animatedItem(index: 2, child: button),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // REPORT PROBLEM BUTTON
  // ---------------------------------------------------------------------------

  Widget _buildReportButton(BuildContext context) {
    final theme = Theme.of(context);

    return _AnimatedScaleButton(
      onPressed: () {
        AppNavigator.pushAndStackNamed(AppRoutes.reportProblemPage);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colors.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.report_problem_outlined,
              size: 20,
              color: theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              'Report a Problem',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TABS
  // ---------------------------------------------------------------------------

  Widget _buildTabs(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          _buildTab(context, label: 'Active', index: 0),
          const SizedBox(width: 24),
          _buildTab(context, label: 'Past', index: 1),
        ],
      ),
    );
  }

  Widget _buildTab(
      BuildContext context, {
        required String label,
        required int index,
      }) {
    final theme = Theme.of(context);
    final selected = _selectedTab == index;

    return InkWell(
      onTap: () {
        if (_selectedTab == index) return;

        setState(() {
          _selectedTab = index;
        });

        _animationController
          ..reset()
          ..forward();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.only(bottom: 10, left: 2, right: 2),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? theme.colorScheme.secondary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: selected
                ? theme.colorScheme.secondary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DISPUTES GRID
  // ---------------------------------------------------------------------------

  Widget _buildDisputes(
      BuildContext context, {
        required double width,
        required bool isMobile,
        required bool isTablet,
      }) {
    int columns;

    if (isMobile) {
      columns = 1;
    } else if (isTablet) {
      columns = 2;
    } else {
      columns = 3;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 16.0;

        final cardWidth =
            (constraints.maxWidth - ((columns - 1) * spacing)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(_currentDisputes.length, (index) {
            return SizedBox(
              width: cardWidth,
              child: _animatedItem(
                index: index + 3,
                child: _DisputeCard(
                  dispute: _currentDisputes[index],
                  onTap: () => _openDisputeDetails(context, _currentDisputes[index]),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // EMPTY STATE
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 48,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No disputes found',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _selectedTab == 0
                ? 'You currently have no active disputes.'
                : 'You have no past disputes.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ANIMATION
  // ---------------------------------------------------------------------------

  Widget _animatedItem({required int index, required Widget child}) {
    final start = (index * 0.08).clamp(0.0, 0.65);
    final end = (start + 0.35).clamp(0.0, 1.0);

    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final value = animation.value;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // ACTIONS
  // ---------------------------------------------------------------------------

  void _openDisputeDetails(BuildContext context, DisputeModel dispute) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DisputeDetailsPage(dispute: dispute)),
    );
  }
}

// =============================================================================
// DISPUTE CARD
// =============================================================================

class _DisputeCard extends StatefulWidget {
  final DisputeModel dispute;
  final VoidCallback onTap;

  const _DisputeCard({required this.dispute, required this.onTap});

  @override
  State<_DisputeCard> createState() => _DisputeCardState();
}

class _DisputeCardState extends State<_DisputeCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dispute = widget.dispute;

    final status = _statusData(context, dispute.status);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..translate(0.0, _hovering ? -3.0 : 0.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovering ? 0.08 : 0.035),
                blurRadius: _hovering ? 16 : 5,
                offset: Offset(0, _hovering ? 8 : 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status + Date
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: status.background,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              status.icon,
                              size: 14,
                              color: status.foreground,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                status.label,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: status.foreground,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        dispute.date,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Property
                Text(
                  dispute.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 6),

                // Dispute type
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      dispute.icon,
                      size: 17,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        dispute.type,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Divider(height: 1, color: theme.colorScheme.outlineVariant),

                const SizedBox(height: 12),

                // View details
                Row(
                  children: [
                    Text(
                      'View Details',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 180),
                      offset: _hovering ? const Offset(0.15, 0) : Offset.zero,
                      child: Icon(
                        Icons.chevron_right,
                        color: theme.colorScheme.primary,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _StatusData _statusData(BuildContext context, DisputeStatus status) {
    final theme = Theme.of(context);

    switch (status) {
      case DisputeStatus.underReview:
        return _StatusData(
          label: 'Under Review',
          icon: Icons.pending_outlined,
          background: theme.colorScheme.secondaryContainer.withValues(alpha: 0.25),
          foreground: theme.colorScheme.secondary,
        );

      case DisputeStatus.awaitingResponse:
        return _StatusData(
          label: 'Awaiting Response',
          icon: Icons.forum_outlined,
          background: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.18),
          foreground: theme.colorScheme.onTertiaryFixedVariant,
        );

      case DisputeStatus.resolved:
        return _StatusData(
          label: 'Resolved',
          icon: Icons.check_circle_outline,
          background: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.18),
          foreground: theme.colorScheme.onTertiaryFixedVariant,
        );
    }
  }
}

// =============================================================================
// BUTTON ANIMATION
// =============================================================================

class _AnimatedScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const _AnimatedScaleButton({required this.child, required this.onPressed});

  @override
  State<_AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<_AnimatedScaleButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}

// =============================================================================
// MODELS
// =============================================================================

enum DisputeStatus { underReview, awaitingResponse, resolved }

class DisputeModel {
  final String title;
  final String type;
  final String date;
  final DisputeStatus status;
  final IconData icon;

  const DisputeModel({
    required this.title,
    required this.type,
    required this.date,
    required this.status,
    required this.icon,
  });
}

class _StatusData {
  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;

  const _StatusData({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });
}

// =============================================================================
// DISPUTE DETAILS PAGE
// Replace this with your actual dispute-details screen content.
// =============================================================================

class DisputeDetailsPage extends StatelessWidget {
  final DisputeModel dispute;

  const DisputeDetailsPage({super.key, required this.dispute});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: const Text('Dispute Details')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(dispute.title, style: theme.textTheme.headlineMedium),
        ),
      ),
    );
  }
}