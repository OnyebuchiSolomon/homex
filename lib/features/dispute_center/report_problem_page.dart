import 'package:flutter/material.dart';
import 'package:homex/core/routes/navigator/page_navigator.dart';
import 'package:homex/ui/global.dart';

class ReportProblemPage extends StatefulWidget {
  const ReportProblemPage({
    super.key,
    this.onNext,
  });

  final ValueChanged<String>? onNext;

  @override
  State<ReportProblemPage> createState() => _ReportProblemPageState();
}

class _ReportProblemPageState extends State<ReportProblemPage>
    with SingleTickerProviderStateMixin {
  String? _selectedIssue;

  late final AnimationController _animationController;

  final List<_IssueOption> _issues = const [
    _IssueOption(
      value: 'misrepresentation',
      title: 'Property Misrepresentation',
      icon: Icons.real_estate_agent_outlined,
    ),
    _IssueOption(
      value: 'payment',
      title: 'Payment Issue',
      icon: Icons.account_balance_wallet_outlined,
    ),
    _IssueOption(
      value: 'fake_property',
      title: 'Fake Property',
      icon: Icons.house_siding_outlined,
    ),
    _IssueOption(
      value: 'fake_seller',
      title: 'Fake Seller',
      icon: Icons.person_off_outlined,
    ),
    _IssueOption(
      value: 'ownership',
      title: 'Land Ownership Issue',
      icon: Icons.landscape_outlined,
    ),
    _IssueOption(
      value: 'tenant',
      title: 'Landlord/Tenant Issue',
      icon: Icons.groups_outlined,
    ),
    _IssueOption(
      value: 'fraud',
      title: 'Fraud Suspicion',
      icon: Icons.warning_amber_rounded,
      isDanger: true,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectIssue(String value) {
    if (_selectedIssue == value) return;

    setState(() {
      _selectedIssue = value;
    });
  }

  void _next() {
    final selected = _selectedIssue;

    if (selected == null) return;

    if (widget.onNext != null) {
      widget.onNext!(selected);
      return;
    }
AppNavigator.pushAndStackNamed(AppRoutes.submitEvidencePage);
    // Replace this with your navigation.
    debugPrint('Selected issue: $selected');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;

    final horizontalPadding = width < 360 ? 16.0 : 20.0;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                _buildTopBar(
                  context,
                  colors,
                  horizontalPadding,
                ),
                Expanded(
                  child: _buildContent(
                    context,
                    colors,
                    horizontalPadding,
                  ),
                ),
              ],
            ),

            // Bottom action bar
            _buildBottomActionBar(
              context,
              colors,
              horizontalPadding,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TOP BAR
  // ---------------------------------------------------------------------------

  Widget _buildTopBar(
      BuildContext context,
      ColorScheme colors,
      double horizontalPadding,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant,
            width: 0.7,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 2),
            color: Color(0x0A000000),
          ),
        ],
      ),
      child: Row(
        children: [
          // HomeX logo
          Expanded(
            child: Row(
              children: [
                // Icon(
                //   Icons.arrow_back_ios,
                //   size: 24,
                //   color: colors.primary,
                // ),
                _CircleIconButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: () => Navigator.of(context).maybePop(),
                  backgroundColor: colors.surfaceContainer,
                  iconColor: colors.onSurface,
                ),
                const SizedBox(width: 8),
                // Text(
                //   'HomeX',
                //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                //     fontWeight: FontWeight.w700,
                //     color: colors.primary,
                //     letterSpacing: -0.4,
                //   ),
                // ),
                Text(
                  'Report a Problem',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                )
              ],
            ),
          ),

          // Profile
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              shape: BoxShape.circle,
              border: Border.all(
                color: colors.outlineVariant,
              ),
            ),
            child: Icon(
              Icons.person_outline_rounded,
              size: 18,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // MAIN CONTENT
  // ---------------------------------------------------------------------------

  Widget _buildContent(
      BuildContext context,
      ColorScheme colors,
      double horizontalPadding,
      ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.025),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            20,
            horizontalPadding,
            130,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               // _buildPageHeader(context, colors),

               // const SizedBox(height: 32),

                _buildIssueHeader(context, colors),

                const SizedBox(height: 16),

                _buildIssueGrid(context, colors),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PAGE HEADER
  // ---------------------------------------------------------------------------

  // Widget _buildPageHeader(
  //     BuildContext context,
  //     ColorScheme colors,
  //     ) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           _CircleIconButton(
  //             icon: Icons.arrow_back_rounded,
  //             onTap: () => Navigator.of(context).maybePop(),
  //             backgroundColor: colors.surfaceContainer,
  //             iconColor: colors.onSurface,
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: Text(
  //               'Report a Problem',
  //               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
  //                 color: colors.onSurface,
  //                 fontWeight: FontWeight.w600,
  //                 letterSpacing: -0.3,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //
  //       const SizedBox(height: 20),
  //
  //       Text(
  //         'Step 1 of 3',
  //         style: Theme.of(context).textTheme.labelLarge?.copyWith(
  //           color: colors.onSurfaceVariant,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //
  //       const SizedBox(height: 8),
  //
  //       // Progress
  //       ClipRRect(
  //         borderRadius: BorderRadius.circular(100),
  //         child: SizedBox(
  //           height: 8,
  //           child: Stack(
  //             children: [
  //               Container(
  //                 width: double.infinity,
  //                 color: colors.surfaceContainer,
  //               ),
  //               FractionallySizedBox(
  //                 widthFactor: 1 / 3,
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: colors.primary,
  //                     borderRadius: BorderRadius.circular(100),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // ---------------------------------------------------------------------------
  // ISSUE HEADER
  // ---------------------------------------------------------------------------

  Widget _buildIssueHeader(
      BuildContext context,
      ColorScheme colors,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is the issue?',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Select the category that best describes your problem.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // ISSUE GRID
  // ---------------------------------------------------------------------------

  Widget _buildIssueGrid(
      BuildContext context,
      ColorScheme colors,
      ) {
    return Column(
      children: [
        for (int i = 0; i < _issues.length; i++) ...[
          _buildIssueCard(
            context,
            colors,
            _issues[i],
          ),
          if (i != _issues.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // ISSUE CARD
  // ---------------------------------------------------------------------------

  Widget _buildIssueCard(
      BuildContext context,
      ColorScheme colors,
      _IssueOption issue,
      ) {
    final isSelected = _selectedIssue == issue.value;

    final primaryColor =
    issue.isDanger ? colors.error : colors.primary;

    return AnimatedScale(
      scale: isSelected ? 0.985 : 1.0,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected
              ? colors.surfaceContainerLow
              : colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : colors.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
            const BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 4),
              color: Color(0x0D000000),
            ),
          ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashColor: primaryColor.withValues(alpha: 0.06),
            highlightColor: primaryColor.withValues(alpha: 0.03),
            onTap: () => _selectIssue(issue.value),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor.withValues(alpha: 0.08)
                          : colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      issue.icon,
                      size: 23,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Title
                  Expanded(
                    child: Text(
                      issue.title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: issue.isDanger
                            ? colors.error
                            : colors.onSurface,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ),

                  // Selection indicator
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: isSelected
                        ? Container(
                      key: const ValueKey('selected'),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 15,
                        color: colors.onPrimary,
                      ),
                    )
                        : Container(
                      key: const ValueKey('unselected'),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colors.outlineVariant,
                          width: 1.5,
                        ),
                      ),
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

  // ---------------------------------------------------------------------------
  // BOTTOM ACTION BAR
  // ---------------------------------------------------------------------------

  Widget _buildBottomActionBar(
      BuildContext context,
      ColorScheme colors,
      double horizontalPadding,
      ) {
    final enabled = _selectedIssue != null;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          12,
          horizontalPadding,
          12 + MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          border: Border(
            top: BorderSide(
              color: colors.outlineVariant,
              width: 0.7,
            ),
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 14,
              offset: Offset(0, -4),
              color: Color(0x10000000),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: enabled ? 1 : 0.5,
              child: ElevatedButton(
                onPressed: enabled ? _next : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                  disabledBackgroundColor: colors.primary,
                  disabledForegroundColor: colors.onPrimary,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: BorderSide(color: colors.outlineVariant,)
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: Row(
                    key: ValueKey(enabled),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// ISSUE MODEL
// -----------------------------------------------------------------------------

class _IssueOption {
  final String value;
  final String title;
  final IconData icon;
  final bool isDanger;

  const _IssueOption({
    required this.value,
    required this.title,
    required this.icon,
    this.isDanger = false,
  });
}

// -----------------------------------------------------------------------------
// CIRCLE ICON BUTTON
// -----------------------------------------------------------------------------

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Ink(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}