import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class PortfolioDealsHubScreen extends StatefulWidget {
  const PortfolioDealsHubScreen({
    super.key,
    this.onHome,
    this.onExplore,
    this.onRequests,
    this.onWallet,
    this.onProfile,
    this.onNotifications,
    this.onShare,
    this.onHelp,
    this.onAddProperty,
  });

  final VoidCallback? onHome;
  final VoidCallback? onExplore;
  final VoidCallback? onRequests;
  final VoidCallback? onWallet;
  final VoidCallback? onProfile;
  final VoidCallback? onNotifications;
  final VoidCallback? onShare;
  final VoidCallback? onHelp;
  final VoidCallback? onAddProperty;

  @override
  State<PortfolioDealsHubScreen> createState() =>
      _PortfolioDealsHubScreenState();
}

class _PortfolioDealsHubScreenState extends State<PortfolioDealsHubScreen> {
  bool _isBuyerMode = true;
  bool _showRentedProperties = true;

  /// Dedicated controller.
  ///
  /// This prevents the Scrollbar from attaching to the
  /// PrimaryScrollController used elsewhere in the application.
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: _buildScrollableContent(
                    colors,
                    textTheme,
                    constraints.maxHeight,
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
  // MAIN SCROLLABLE CONTENT
  // ============================================================

  Widget _buildScrollableContent(
      ColorScheme colors,
      TextTheme textTheme,
      double availableHeight,
      ) {
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        primary: false,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 22),
                  _buildRoleSwitcher(colors, textTheme),
                  const SizedBox(height: 26),

                  // IMPORTANT:
                  // Do not use AnimatedSwitcher here.
                  //
                  // AnimatedSwitcher keeps the previous child alive while
                  // inserting the next child. With Material buttons this can
                  // result in Flutter's internal InkFeatures GlobalKey being
                  // mounted twice during a rebuild.
                  AnimatedSize(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: KeyedSubtree(
                      key: ValueKey(
                        _isBuyerMode ? 'buyer-workspace' : 'seller-workspace',
                      ),
                      child: _isBuyerMode
                          ? _buildBuyerWorkspace(colors, textTheme)
                          : _buildSellerWorkspace(colors, textTheme),
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

  // ============================================================
  // HEADER PIECES
  // ============================================================

  Widget _buildAvatar(
      ColorScheme colors, {
        bool compact = false,
      }) {
    final size = compact ? 38.0 : 42.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            shape: BoxShape.circle,
            border: Border.all(
              color: colors.outlineVariant,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'AM',
            style: context.textTheme.labelMedium?.copyWith(
              color: colors.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: colors.tertiary,
              shape: BoxShape.circle,
              border: Border.all(
                color: colors.surfaceContainerLowest,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderActions(
      ColorScheme colors, {
        bool compact = false,
      }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _iconButton(
          colors,
          icon: Icons.notifications_outlined,
          badge: '3',
          onTap: widget.onNotifications,
          compact: compact,
        ),
        const SizedBox(width: 2),
        _iconButton(
          colors,
          icon: Icons.share_outlined,
          onTap: widget.onShare,
          compact: compact,
        ),
      ],
    );
  }

  Widget _auditButton(ColorScheme colors) {
    return OutlinedButton.icon(
      key: const ValueKey('audit-passports-button'),
      onPressed: widget.onHelp,
      icon: const Icon(
        Icons.verified_user_outlined,
        size: 16,
      ),
      label: const Text('Audit Passports'),
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.onPrimary,
        side: BorderSide(
          color: colors.onPrimary.withValues(alpha: .15),
        ),
        backgroundColor:
        colors.surfaceContainerLowest.withValues(alpha: .08),
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 9,
        ),
      ),
    );
  }

  // ============================================================
  // ROLE SWITCHER
  // ============================================================

  Widget _buildRoleSwitcher(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 620),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: _roleTab(
                colors: colors,
                textTheme: textTheme,
                active: _isBuyerMode,
                icon: Icons.shopping_bag_outlined,
                title: 'Buyer & Tenant',
                count: '3 Active',
                onTap: () {
                  if (!_isBuyerMode) {
                    setState(() {
                      _isBuyerMode = true;
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: _roleTab(
                colors: colors,
                textTheme: textTheme,
                active: !_isBuyerMode,
                icon: Icons.real_estate_agent_outlined,
                title: 'Seller & Landlord',
                count: '2 Listings',
                onTap: () {
                  if (_isBuyerMode) {
                    setState(() {
                      _isBuyerMode = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleTab({
    required ColorScheme colors,
    required TextTheme textTheme,
    required bool active,
    required IconData icon,
    required String title,
    required String count,
    required VoidCallback onTap,
  }) {
    return Material(
      color: active
          ? colors.surfaceContainerLowest
          : colors.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: active
                    ? colors.primary
                    : colors.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: active
                        ? colors.primary
                        : colors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              _countBadge(
                colors,
                count,
                active: active,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BUYER WORKSPACE
  // ============================================================

  Widget _buildBuyerWorkspace(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      key: const ValueKey('buyer'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeading(
          colors,
          textTheme,
          title: 'Buyer & Tenant Workspace',
          activeColor: colors.secondary,
          trailing: _buyerWorkspaceTabs(
            colors,
            textTheme,
          ),
        ),
        const SizedBox(height: 12),
        _buildTenancyCard(colors, textTheme),
        const SizedBox(height: 28),
        _sectionHeading(
          colors,
          textTheme,
          title: 'Sent Offers & In-Flight Negotiations',
          activeColor: colors.primaryContainer,
          trailing: _smallBadge(
            colors,
            '2 Active Submissions',
            colors.surfaceContainerHigh,
            colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 700) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPurchaseOfferCard(
                    colors,
                    textTheme,
                  ),
                  const SizedBox(height: 14),
                  _buildCounterOfferCard(
                    colors,
                    textTheme,
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildPurchaseOfferCard(
                    colors,
                    textTheme,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildCounterOfferCard(
                    colors,
                    textTheme,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        _buildBuyerBottomGrid(colors, textTheme),
      ],
    );
  }

  Widget _buyerWorkspaceTabs(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Wrap(
        children: [
          _miniTab(
            colors,
            textTheme,
            active: true,
            icon: Icons.home_outlined,
            title: 'My Tenancy',
            badge: 'Active',
          ),
          _miniTab(
            colors,
            textTheme,
            active: false,
            icon: Icons.outbox_outlined,
            title: 'Sent Offers',
            badge: '2',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TENANCY
  // ============================================================

  Widget _buildTenancyCard(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _card(
      colors,
      padding: const EdgeInsets.all(18),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final narrow = constraints.maxWidth < 760;

          final details = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 7,
                runSpacing: 5,
                children: [
                  _smallBadge(
                    colors,
                    'Active Tenancy',
                    colors.secondaryContainer,
                    colors.onSecondaryContainer,
                  ),
                  Text(
                    'Unit 4B Penthouse Suite',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'Ikoyi Waterfront Penthouse (Unit 4B)',
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              _locationText(
                colors,
                'Alexander Road, Ikoyi, Lagos Island',
              ),
              const SizedBox(height: 14),
              _landlordStrip(colors, textTheme),
              const SizedBox(height: 17),
              _leaseProgress(colors, textTheme),
            ],
          );

          final finance = _tenancyFinanceRail(
            colors,
            textTheme,
          );

          if (narrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                details,
                const SizedBox(height: 18),
                finance,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: details,
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 5,
                child: finance,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _landlordStrip(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: .3),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 430;

          final profile = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: colors.primary,
                child: Text(
                  'OA',
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 5,
                      runSpacing: 3,
                      crossAxisAlignment:
                      WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Otunba Adeleke',
                          style: textTheme.labelMedium?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(
                          Icons.verified,
                          size: 14,
                          color: colors.secondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Direct Landlord • Verified Tier 3 (LASRERA Certified)',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

          final button = TextButton.icon(
            key: const ValueKey('message-landlord-button'),
            onPressed: _noop,
            icon: const Icon(
              Icons.chat_outlined,
              size: 16,
            ),
            label: const Text('Message Landlord'),
            style: TextButton.styleFrom(
              foregroundColor: colors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 5,
              ),
            ),
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profile,
                const SizedBox(height: 5),
                button,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: profile),
              button,
            ],
          );
        },
      ),
    );
  }

  Widget _leaseProgress(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Lease Duration: 223 / 365 Days',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '142 Days Remaining',
              style: textTheme.labelSmall?.copyWith(
                color: colors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: .61,
            minHeight: 8,
            backgroundColor: colors.surfaceContainerHigh,
            valueColor: AlwaysStoppedAnimation<Color>(
              colors.primary,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Automatic renewal notice protocol activates in 52 days via Stanbic Trustee escrow.',
          style: textTheme.labelSmall?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _tenancyFinanceRail(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: .3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'NEXT ESCROW CYCLE',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .7,
                  ),
                ),
              ),
              _smallBadge(
                colors,
                'Current',
                colors.tertiaryContainer,
                colors.onTertiaryContainer,
              ),
            ],
          ),
          Divider(
            height: 22,
            color: colors.outlineVariant.withValues(alpha: .3),
          ),
          _financeRow(
            colors,
            textTheme,
            'Service Charge Escrow',
            '₦1,200,000 (Settled)',
          ),
          _financeRow(
            colors,
            textTheme,
            'Security Deposit Held',
            '₦1,000,000 (Protected)',
          ),
          _financeRow(
            colors,
            textTheme,
            'Legal & Document Vault',
            'Signed Digitally',
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              key: const ValueKey(
                'pay-next-escrow-button',
              ),
              onPressed: _noop,
              icon: const Icon(
                Icons.account_balance_wallet_outlined,
                size: 17,
              ),
              label: const Text(
                'Pay Next Escrow Rent (Early Reserve)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 10,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _outlinedAction(
                  colors,
                  icon: Icons.description_outlined,
                  label: 'View Agreement',
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: _outlinedAction(
                  colors,
                  icon: Icons.history_edu_outlined,
                  label: 'Rent Receipts',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _financeRow(
      ColorScheme colors,
      TextTheme textTheme,
      String label,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // OFFERS
  // ============================================================

  Widget _buildPurchaseOfferCard(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _offerCard(
      colors,
      textTheme,
      title: 'Lekki Phase 1 4-Bed Duplex',
      location: 'Admiralty Way Axis, Lekki Phase 1, Lagos',
      ref: '#LX-1092',
      status: 'Expires in 22h 14m',
      statusColor: colors.secondaryContainer,
      statusTextColor: colors.onSecondaryContainer,
      icon: Icons.hourglass_top,
      financialRows: const [
        _FinancialRow(
          'Submitted Purchase Offer:',
          '₦115,000,000',
          emphasized: true,
        ),
        _FinancialRow(
          '10% Earnest Pre-Funded:',
          '₦11,500,000 (Stanbic IBTC Trust)',
          icon: Icons.lock,
        ),
      ],
      footerLabel: 'Vendor Decision Status:',
      footerValue: 'Under Review by Vendor',
      footerColor: colors.secondary,
      actions: [
        _PrimaryActionData(
          keyValue: 'view-offer-terms',
          label: 'View Offer Terms',
        ),
        _OutlinedActionData(
          keyValue: 'modify-counter',
          label: 'Modify / Counter',
        ),
        _IconActionData(
          keyValue: 'cancel-offer',
          icon: Icons.cancel_outlined,
        ),
      ],
    );
  }

  Widget _buildCounterOfferCard(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _offerCard(
          colors,
          textTheme,
          title: 'Maitama Terrace Duplex, Abuja',
          location: 'Gana Street, Maitama Diplomatic Zone, FCT',
          ref: '#ABJ-5510',
          status: 'Counter-Offer Received',
          statusColor: colors.tertiaryContainer,
          statusTextColor: colors.onTertiaryContainer,
          icon: Icons.swap_horiz,
          financialRows: const [
            _FinancialRow(
              'Your Initial Bid:',
              '₦7,800,000/yr',
              muted: true,
            ),
            _FinancialRow(
              'Landlord Counter Proposal:',
              '₦8,200,000/yr',
              emphasized: true,
            ),
          ],
          footerLabel: 'Landlord Concession:',
          footerValue: 'Includes Full Inverter Maintenance',
          footerColor: colors.onSurface,
          actions: [
            _PrimaryActionData(
              keyValue: 'review-counter',
              label: 'Review Counter & Accept',
              background: true,
            ),
            _OutlinedActionData(
              keyValue: 'decline-counter',
              label: 'Decline',
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(13),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              'ACTION REQUIRED',
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSecondary,
                fontWeight: FontWeight.w700,
                letterSpacing: .5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _offerCard(
      ColorScheme colors,
      TextTheme textTheme, {
        required String title,
        required String location,
        required String ref,
        required String status,
        required Color statusColor,
        required Color statusTextColor,
        required IconData icon,
        required List<_FinancialRow> financialRows,
        required String footerLabel,
        required String footerValue,
        required Color footerColor,
        required List<Object> actions,
      }) {
    return _card(
      colors,
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _smallBadge(
                  colors,
                  status,
                  statusColor,
                  statusTextColor,
                  icon: icon,
                ),
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  'Ref: $ref',
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.outline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          _locationText(colors, location),
          const SizedBox(height: 13),
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: colors.outlineVariant.withValues(alpha: .2),
              ),
            ),
            child: Column(
              children: [
                ...financialRows.map(
                      (row) => _financialRowWidget(
                    colors,
                    textTheme,
                    row,
                  ),
                ),
                Divider(
                  height: 15,
                  color: colors.outlineVariant.withValues(alpha: .3),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        footerLabel,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        footerValue,
                        textAlign: TextAlign.end,
                        style: textTheme.labelSmall?.copyWith(
                          color: footerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 11),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: actions.map((action) {
              if (action is _PrimaryActionData) {
                return _primaryAction(
                  colors,
                  action.label,
                  key: ValueKey(action.keyValue),
                  onPressed: action.keyValue == 'review-counter'
                      ? () => AppNavigator.pushAndStackNamed(
                    AppRoutes.offerReviewScreen,
                  )
                      : _noop,
                  background: action.background
                      ? colors.secondary
                      : null,
                  foreground: action.background
                      ? colors.onSecondary
                      : null,
                );
              }

              if (action is _OutlinedActionData) {
                return _outlinedAction(
                  colors,
                  key: ValueKey(action.keyValue),
                  icon: null,
                  label: action.label,
                );
              }

              if (action is _IconActionData) {
                return _iconAction(
                  colors,
                  action.icon,
                  key: ValueKey(action.keyValue),
                );
              }

              return const SizedBox.shrink();
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _financialRowWidget(
      ColorScheme colors,
      TextTheme textTheme,
      _FinancialRow row,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (row.icon != null) ...[
                  Icon(
                    row.icon,
                    size: 14,
                    color: colors.secondary,
                  ),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: Text(
                    row.label,
                    style: textTheme.labelSmall?.copyWith(
                      color: row.emphasized
                          ? colors.secondary
                          : colors.onSurfaceVariant,
                      fontWeight: row.emphasized
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              row.value,
              textAlign: TextAlign.end,
              style: textTheme.labelMedium?.copyWith(
                color: row.muted
                    ? colors.onSurfaceVariant
                    : colors.onSurface,
                fontWeight: row.emphasized
                    ? FontWeight.w700
                    : FontWeight.w600,
                decoration: row.muted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUYER BOTTOM GRID
  // ============================================================

  Widget _buildBuyerBottomGrid(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInquiriesCard(colors, textTheme),
              const SizedBox(height: 14),
              _buildGatePassCard(colors, textTheme),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: _buildInquiriesCard(
                colors,
                textTheme,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 5,
              child: _buildGatePassCard(
                colors,
                textTheme,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInquiriesCard(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _card(
      colors,
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _cardHeading(
            colors,
            textTheme,
            icon: Icons.forum_outlined,
            title: 'Direct Landlord Inquiries',
            badge: '2 Active Dialogues',
          ),
          const SizedBox(height: 11),
          _inquiryItem(
            colors,
            textTheme,
            initials: 'CO',
            name: 'Chief Ogundipe (Owner)',
            property: 'Banana Island Villa',
            message:
            '"Deed of assignment confirmed at Alausa registry. You may inspect the survey pillar points."',
            time: 'Today, 11:20 AM',
            avatarColor: colors.primaryFixed,
            avatarTextColor: colors.onPrimaryFixed,
          ),
          const SizedBox(height: 8),
          _inquiryItem(
            colors,
            textTheme,
            initials: 'EA',
            name: 'Engr. Alabi (Developer)',
            property: 'Chevron Twin Homes',
            message:
            '"Approved the 24-hour walkthrough pass. The LASRERA rep will accompany your surveyor."',
            time: 'Yesterday',
            avatarColor: colors.secondaryFixed,
            avatarTextColor: colors.onSecondaryFixed,
          ),
        ],
      ),
    );
  }

  Widget _inquiryItem(
      ColorScheme colors,
      TextTheme textTheme, {
        required String initials,
        required String name,
        required String property,
        required String message,
        required String time,
        required Color avatarColor,
        required Color avatarTextColor,
      }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: avatarColor,
            child: Text(
              initials,
              style: textTheme.labelSmall?.copyWith(
                color: avatarTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 5,
                  runSpacing: 2,
                  children: [
                    Text(
                      name,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      property,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  message,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  time,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.outline,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            key: ValueKey('send-inquiry-$initials'),
            onPressed: _noop,
            icon: const Icon(Icons.send_outlined),
            iconSize: 17,
            color: colors.primary,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGatePassCard(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _card(
      colors,
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _cardHeading(
            colors,
            textTheme,
            icon: Icons.badge_outlined,
            title: 'Estate Gate Pass',
            badge: 'Authorized',
            iconColor: colors.secondary,
            badgeColor: colors.tertiaryContainer,
            badgeTextColor: colors.onTertiaryContainer,
          ),
          const SizedBox(height: 11),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: colors.outlineVariant,
              ),
            ),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 380) {
                      return Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IKATE ELEGUSHI ESTATE ACCESS',
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tomorrow, 10:00 AM',
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            'IKATE ELEGUSHI ESTATE ACCESS',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Tomorrow, 10:00 AM',
                            textAlign: TextAlign.end,
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color:
                      colors.outlineVariant.withValues(alpha: .3),
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 360) {
                        return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            _gatePin(colors, textTheme),
                            const SizedBox(height: 10),
                            _escortStatus(
                              colors,
                              textTheme,
                              alignEnd: false,
                            ),
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: _gatePin(
                              colors,
                              textTheme,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: _escortStatus(
                              colors,
                              textTheme,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 11),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 360) {
                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Tap to show QR to Estate Guards',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 7),
                    _outlinedAction(
                      colors,
                      key: const ValueKey(
                        'display-qr-mobile',
                      ),
                      icon: Icons.qr_code_2,
                      label: 'Display QR',
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: Text(
                      'Tap to show QR to Estate Guards',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _outlinedAction(
                    colors,
                    key: const ValueKey('display-qr'),
                    icon: Icons.qr_code_2,
                    label: 'Display QR',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _gatePin(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GATE SECURITY PIN',
          style: textTheme.labelSmall?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '#904-812',
          style: textTheme.titleLarge?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _escortStatus(
      ColorScheme colors,
      TextTheme textTheme, {
        bool alignEnd = true,
      }) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          'Escort Status',
          style: textTheme.labelSmall?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 14,
              color: colors.tertiary,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                'LASRERA Officer Assigned',
                textAlign: alignEnd
                    ? TextAlign.end
                    : TextAlign.start,
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // SELLER WORKSPACE
  // ============================================================

  Widget _buildSellerWorkspace(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      key: const ValueKey('seller'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSellerPortalHeader(colors, textTheme),
        const SizedBox(height: 13),
        _buildLivingStatus(colors, textTheme),
        const SizedBox(height: 27),
        _buildPropertiesPortfolio(colors, textTheme),
      ],
    );
  }

  Widget _buildSellerPortalHeader(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _card(
      colors,
      padding: const EdgeInsets.all(18),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 650;

          final description = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DIRECT LANDLORD & SELLER PORTAL',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.secondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .7,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Manage Your Owned Real Estate',
                style: textTheme.titleLarge?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Deploy verified direct deal listings with zero agent commissions and automated tenant escrow collection.',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          );

          final button = FilledButton.icon(
            key: const ValueKey('add-property-button'),
            onPressed: () {
              AppNavigator.pushAndStackNamed(
                AppRoutes.propertyTypePage,
              );
            },
            icon: const Icon(
              Icons.add_circle_outline,
              size: 18,
            ),
            label: const Text('+ Add / List New Property'),
            style: FilledButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 11,
              ),
            ),
          );

          if (compact) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              children: [
                description,
                const SizedBox(height: 13),
                button,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: description),
              const SizedBox(width: 16),
              Flexible(child: button),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLivingStatus(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: .3),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 650;

          final content = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: colors.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.home_mini,
                  size: 18,
                  color: colors.onSecondaryContainer,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR PERSONAL LIVING STATUS',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Living under Landlord: Otunba Adeleke (Ikoyi Waterfront Unit 4B)',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

          final switchButton = TextButton(
            key: const ValueKey('switch-tenancy-desk'),
            onPressed: () {
              setState(() {
                _isBuyerMode = true;
              });
            },
            child: const Text('Switch to Tenancy Desk'),
          );

          if (compact) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                content,
                switchButton,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: content),
              switchButton,
            ],
          );
        },
      ),
    );
  }

  Widget _buildPropertiesPortfolio(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 700;

            final heading = Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: colors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        'Properties Portfolio',
                        style: textTheme.titleLarge?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Manage escrow sales and rental disbursements directly',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            );

            final tabs = _sellerPropertyTabs(
              colors,
              textTheme,
            );

            if (compact) {
              return Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  heading,
                  const SizedBox(height: 11),
                  tabs,
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: heading),
                const SizedBox(width: 11),
                tabs,
              ],
            );
          },
        ),
        const SizedBox(height: 13),

        // Same reason as the workspace above:
        // do not keep the previous button subtree alive.
        AnimatedSize(
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: KeyedSubtree(
            key: ValueKey(
              _showRentedProperties
                  ? 'rented-properties'
                  : 'sale-properties',
            ),
            child: _showRentedProperties
                ? _buildRentedProperties(
              colors,
              textTheme,
            )
                : _buildSaleProperties(
              colors,
              textTheme,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sellerPropertyTabs(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Wrap(
        children: [
          _miniTab(
            colors,
            textTheme,
            active: !_showRentedProperties,
            icon: Icons.sell_outlined,
            title: 'Properties for Sale',
            badge: '2 Active',
            onTap: () {
              if (_showRentedProperties) {
                setState(() {
                  _showRentedProperties = false;
                });
              }
            },
          ),
          _miniTab(
            colors,
            textTheme,
            active: _showRentedProperties,
            icon: Icons.key_outlined,
            title: 'Rented Properties',
            badge: '1 Tenancy',
            onTap: () {
              if (!_showRentedProperties) {
                setState(() {
                  _showRentedProperties = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SALE PROPERTIES
  // ============================================================

  Widget _buildSaleProperties(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _propertySaleCard(
          colors,
          textTheme,
          imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDvmEOT4hjsY1KrPqLkdcld4nlmzml8KeKTKjmsWyV4Cl4EeB7ZLyIHvnXLET8QQ923daDTrvqDksv_B3Cf9NdjNYUIMQQwLvC-L9PZroLba55zqF8knegr_pnNwPakBnrpjV3lPpRS0w11bh7unb9ei6kVcb1cXmmBeSizQozcSf2B4qMYNJS8Gd7P-q-3oX3yM8oaF-5X-ztwOKhCdbFln4kCYckTOCvhuUBFFDg_e4ql8DyzFO4L',
          title: 'Lekki Phase 1 4-Bed Duplex',
          location:
          'Admiralty Way Axis, Lekki Phase 1, Lagos',
          price: '₦120,000,000',
          ref: '#LX-1092',
          status: 'Live on Market',
          offer: '2 Offers Received',
          offerTop: '(₦115M Top)',
          secondaryStatus: 'Escrow Funded',
          imageLabel: 'FOR SALE',
        ),
        const SizedBox(height: 13),
        _propertySaleCard(
          colors,
          textTheme,
          imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBvJGU5PT-Ien-Q3vHUXKO3xXjah3XKRGzZaumPUDVX0Phe_zcdm7RzXcst7qEEHL3y_YUUiYTYDMnX7Les11lz5_IceZTaRgRA7NLgcOX37L9fSH78a9jKap628jonXIj4zHbhCziym3pj-Fbuo1OyDiqAQbP37YPux-YLdJu5Gq7AVijhRsk8tfBJYmZ-HV5hAYbo1Y1ziX8AkA199YV3-Xcgwgew3E2AeUQVawAwQcSqFsffD5a',
          title: 'Victoria Island Waterfront Plot',
          location:
          'Ozumba Mbadiwe Way, Victoria Island, Lagos',
          price: '₦85,000,000',
          ref: '#VI-WF-850',
          status: 'Audited C-of-O',
          offer: '1 Active Offer',
          offerTop: '(₦82M Top)',
          secondaryStatus: '3 Inspections',
          imageLabel: 'FOR SALE',
        ),
      ],
    );
  }

  Widget _propertySaleCard(
      ColorScheme colors,
      TextTheme textTheme, {
        required String imageUrl,
        required String title,
        required String location,
        required String price,
        required String ref,
        required String status,
        required String offer,
        required String offerTop,
        required String secondaryStatus,
        required String imageLabel,
      }) {
    return _card(
      colors,
      padding: const EdgeInsets.all(17),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 700;

          final property = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _propertyImage(
                colors,
                imageUrl,
                imageLabel,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        _smallBadge(
                          colors,
                          status,
                          colors.tertiaryContainer,
                          colors.onTertiaryContainer,
                        ),
                        Text(
                          'Ref: $ref',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.outline,
                          ),
                        ),
                        Text(
                          '• LASRERA Verified',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onTertiaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _locationText(
                      colors,
                      location,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 3,
                      children: [
                        Text(
                          'List Price:',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          price,
                          style: textTheme.titleMedium?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );

          final escrowFunded =
              secondaryStatus == 'Escrow Funded';

          final actions = Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,
            children: [
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 5,
                runSpacing: 5,
                children: [
                  _smallBadge(
                    colors,
                    '$offer $offerTop',
                    colors.surfaceContainerLow,
                    colors.onSurface,
                    icon: Icons.local_offer_outlined,
                  ),
                  _smallBadge(
                    colors,
                    secondaryStatus,
                    escrowFunded
                        ? colors.tertiaryContainer
                        : colors.surfaceContainerLow,
                    escrowFunded
                        ? colors.onTertiaryContainer
                        : colors.onSurface,
                    icon: escrowFunded
                        ? Icons.shield_outlined
                        : Icons.calendar_month_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                alignment: WrapAlignment.end,
                children: [
                  _primaryAction(
                    colors,
                    'Manage Listing',
                    key: ValueKey(
                      'manage-listing-$ref',
                    ),
                    onPressed: _noop,
                  ),
                  _outlinedAction(
                    colors,
                    key: ValueKey(
                      'review-property-$ref',
                    ),
                    icon: null,
                    label: escrowFunded
                        ? 'Review Offers'
                        : 'Review Terms',
                  ),
                ],
              ),
            ],
          );

          if (compact) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              children: [
                property,
                const SizedBox(height: 13),
                Divider(
                  color: colors.outlineVariant
                      .withValues(alpha: .3),
                ),
                const SizedBox(height: 9),
                actions,
              ],
            );
          }

          return Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              Expanded(child: property),
              const SizedBox(width: 14),
              Flexible(child: actions),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRentedProperties(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _card(
      colors,
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 650;

              final title = Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 5,
                    runSpacing: 4,
                    children: [
                      _smallBadge(
                        colors,
                        'Active Tenancy',
                        colors.tertiaryContainer,
                        colors.onTertiaryContainer,
                      ),
                      Text(
                        'Lease #IKY-TEN-001',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.outline,
                        ),
                      ),
                      Text(
                        '• Stanbic IBTC Escrow Protected',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onTertiaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Ikoyi Waterfront Penthouse (Unit 4B)',
                    style: textTheme.titleMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  _locationText(
                    colors,
                    'Alexander Road, Ikoyi, Lagos Island',
                  ),
                ],
              );

              final rent = Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  crossAxisAlignment: compact
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Annual Escrow Rental Yield',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '₦7,500,000/yr',
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );

              if (compact) {
                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    title,
                    const SizedBox(height: 11),
                    rent,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: title),
                  const SizedBox(width: 11),
                  rent,
                ],
              );
            },
          ),
          Divider(
            height: 27,
            color: colors.outlineVariant.withValues(alpha: .3),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 700;

              final tenant = Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: colors.outlineVariant
                        .withValues(alpha: .2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor:
                      colors.primaryContainer,
                      child: Text(
                        'BA',
                        style: textTheme.labelMedium?.copyWith(
                          color: colors.onPrimaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 5,
                            runSpacing: 4,
                            children: [
                              Text(
                                'Babatunde Adele',
                                style:
                                textTheme.labelMedium?.copyWith(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              _smallBadge(
                                colors,
                                'Verified Tenant',
                                colors.tertiaryContainer,
                                colors.onTertiaryContainer,
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Status: Rent Current • Next Escrow Payout: Oct 15, 2025',
                            style:
                            textTheme.labelSmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Lease Duration: 223 / 365 Days (142 Days Remaining)',
                            style:
                            textTheme.labelSmall?.copyWith(
                              color: colors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );

              final actions = Column(
                crossAxisAlignment:
                CrossAxisAlignment.stretch,
                children: [
                  FilledButton.icon(
                    key: const ValueKey(
                      'collect-rent-escrow',
                    ),
                    onPressed: _noop,
                    icon: const Icon(
                      Icons.payments_outlined,
                      size: 17,
                    ),
                    label: const Text(
                      'Collect Rent Escrow',
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 7),
                  OutlinedButton.icon(
                    key: const ValueKey(
                      'manage-tenancy-conduct',
                    ),
                    onPressed: _noop,
                    icon: Icon(
                      Icons.rate_review_outlined,
                      size: 17,
                      color: colors.secondary,
                    ),
                    label: const Text(
                      'Manage Tenancy & Conduct',
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.onSurface,
                      side: BorderSide(
                        color: colors.outlineVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 6,
                    children: [
                      _tinyInfo(
                        colors,
                        Icons.star,
                        'Conduct Rating',
                      ),
                      _tinyInfo(
                        colors,
                        Icons.verified,
                        'Vacate Status',
                      ),
                    ],
                  ),
                ],
              );

              if (compact) {
                return Column(
                  children: [
                    tenant,
                    const SizedBox(height: 11),
                    actions,
                  ],
                );
              }

              return Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(child: tenant),
                  const SizedBox(width: 13),
                  SizedBox(
                    width: 245,
                    child: actions,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SHARED COMPONENTS
  // ============================================================

  Widget _sectionHeading(
      ColorScheme colors,
      TextTheme textTheme, {
        required String title,
        required Color activeColor,
        Widget? trailing,
      }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 700;

        final titleWidget = Row(
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );

        if (trailing == null) {
          return titleWidget;
        }

        if (compact) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              titleWidget,
              const SizedBox(height: 9),
              trailing,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: titleWidget),
            const SizedBox(width: 9),
            trailing,
          ],
        );
      },
    );
  }

  Widget _cardHeading(
      ColorScheme colors,
      TextTheme textTheme, {
        required IconData icon,
        required String title,
        required String badge,
        Color? iconColor,
        Color? badgeColor,
        Color? badgeTextColor,
      }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color: iconColor ?? colors.primary,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 7),
        _smallBadge(
          colors,
          badge,
          badgeColor ?? colors.surfaceContainerHigh,
          badgeTextColor ?? colors.onSurfaceVariant,
        ),
      ],
    );
  }

  Widget _miniTab(
      ColorScheme colors,
      TextTheme textTheme, {
        required bool active,
        required IconData icon,
        required String title,
        required String badge,
        VoidCallback? onTap,
      }) {
    return Material(
      color: active
          ? colors.surfaceContainerLowest
          : colors.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: active
                    ? colors.primary
                    : colors.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: textTheme.labelSmall?.copyWith(
                  color: active
                      ? colors.primary
                      : colors.onSurfaceVariant,
                  fontWeight: active
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              _countBadge(
                colors,
                badge,
                active: active,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(
      ColorScheme colors, {
        required Widget child,
        EdgeInsetsGeometry? padding,
      }) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: .4),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _statusBadge(
      ColorScheme colors, {
        required IconData icon,
        required String text,
        required Color background,
        required Color foreground,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: foreground,
          ),
          const SizedBox(width: 3),
          Text(
            text,
            style: context.textTheme.labelSmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallBadge(
      ColorScheme colors,
      String text,
      Color background,
      Color foreground, {
        IconData? icon,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 13,
              color: foreground,
            ),
            const SizedBox(width: 3),
          ],
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _countBadge(
      ColorScheme colors,
      String text, {
        required bool active,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: active
            ? colors.primaryContainer
            : colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.labelSmall?.copyWith(
          color: active
              ? colors.onPrimaryContainer
              : colors.onSurfaceVariant,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _locationText(
      ColorScheme colors,
      String text,
      ) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 15,
            color: colors.outline,
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _outlinedAction(
      ColorScheme colors, {
        Key? key,
        required IconData? icon,
        required String label,
      }) {
    return OutlinedButton.icon(
      key: key,
      onPressed: _noop,
      icon: icon == null
          ? const SizedBox(
        width: 0,
        height: 0,
      )
          : Icon(
        icon,
        size: 15,
      ),
      label: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.onSurface,
        side: BorderSide(
          color: colors.outlineVariant,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 8,
        ),
        textStyle: context.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _primaryAction(
      ColorScheme colors,
      String label, {
        Key? key,
        required VoidCallback onPressed,
        Color? background,
        Color? foreground,
      }) {
    return FilledButton(
      key: key,
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: background ?? colors.primary,
        foregroundColor: foreground ?? colors.onPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 9,
        ),
        textStyle: context.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _iconAction(
      ColorScheme colors,
      IconData icon, {
        Key? key,
      }) {
    return OutlinedButton(
      key: key,
      onPressed: _noop,
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.onSurface,
        side: BorderSide(
          color: colors.outlineVariant.withValues(alpha: .4),
        ),
        minimumSize: const Size(42, 40),
        padding: EdgeInsets.zero,
      ),
      child: Icon(
        icon,
        size: 18,
      ),
    );
  }

  Widget _iconButton(
      ColorScheme colors, {
        required IconData icon,
        String? badge,
        VoidCallback? onTap,
        bool compact = false,
      }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: colors.onSurfaceVariant,
            size: compact ? 21 : 22,
          ),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(
            minWidth: compact ? 34 : 38,
            minHeight: compact ? 34 : 38,
          ),
        ),
        if (badge != null)
          Positioned(
            right: 0,
            top: -1,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: colors.error,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.surfaceContainerLowest,
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                badge,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.onError,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _propertyImage(
      ColorScheme colors,
      String imageUrl,
      String label,
      ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: SizedBox(
        width: 96,
        height: 96,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: colors.surfaceContainerHigh,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.home_work_outlined,
                    color: colors.onSurfaceVariant,
                    size: 30,
                  ),
                );
              },
              loadingBuilder: (
                  context,
                  child,
                  progress,
                  ) {
                if (progress == null) {
                  return child;
                }

                return Container(
                  color: colors.surfaceContainerHigh,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value:
                      progress.expectedTotalBytes == null
                          ? null
                          : progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes!,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: 5,
              top: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(
                    alpha: .88,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  label,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.onPrimary,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tinyInfo(
      ColorScheme colors,
      IconData icon,
      String text,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 12,
          color: colors.secondary,
        ),
        const SizedBox(width: 3),
        Text(
          text,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  static void _noop() {}
}

// ============================================================
// ACTION DATA
// ============================================================

class _PrimaryActionData {
  const _PrimaryActionData({
    required this.keyValue,
    required this.label,
    this.background = false,
  });

  final String keyValue;
  final String label;
  final bool background;
}

class _OutlinedActionData {
  const _OutlinedActionData({
    required this.keyValue,
    required this.label,
  });

  final String keyValue;
  final String label;
}

class _IconActionData {
  const _IconActionData({
    required this.keyValue,
    required this.icon,
  });

  final String keyValue;
  final IconData icon;
}

// ============================================================
// DATA MODELS
// ============================================================

class _FinancialRow {
  const _FinancialRow(
      this.label,
      this.value, {
        this.icon,
        this.emphasized = false,
        this.muted = false,
      });

  final String label;
  final String value;
  final IconData? icon;
  final bool emphasized;
  final bool muted;
}