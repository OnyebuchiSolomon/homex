 import 'package:homex/ui/global.dart';

class OfferReviewScreen extends StatefulWidget {
  const OfferReviewScreen({
    super.key,
    this.onBack,
    this.onShare,
    this.onMore,
    this.onViewBuyerProfile,
    this.onCounter,
    this.onAccept,
    this.onDecline,
  });

  final VoidCallback? onBack;
  final VoidCallback? onShare;
  final VoidCallback? onMore;
  final VoidCallback? onViewBuyerProfile;
  final VoidCallback? onCounter;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  @override
  State<OfferReviewScreen> createState() => _OfferReviewScreenState();
}

class _OfferReviewScreenState extends State<OfferReviewScreen> {
  bool _isAccepting = false;

  Future<void> _handleAccept() async {
    if (_isAccepting) return;

    setState(() => _isAccepting = true);

    await Future<void>.delayed(AppAnimations.mediumDelay);

    if (!mounted) return;
AppNavigator.pushAndStackNamed(AppRoutes.acceptLockEscrowScreen);
    setState(() => _isAccepting = false);
    widget.onAccept?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final media = MediaQuery.sizeOf(context);

    final isCompact = media.width < 360;
    final horizontalPadding = media.width < 400 ? 16.0 : 20.0;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildAppBar(
                      context,
                      colors,
                      textTheme,
                      isCompact,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      16,
                      horizontalPadding,
                      168,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          _buildStatusCard(
                            context,
                            colors,
                            textTheme,
                            isCompact,
                          ),
                          const SizedBox(height: 16),
                          _buildFinancialSummary(
                            context,
                            colors,
                            textTheme,
                            isCompact,
                          ),
                          const SizedBox(height: 16),
                          _buildBuyerTrust(
                            context,
                            colors,
                            textTheme,
                            isCompact,
                          ),
                          const SizedBox(height: 16),
                          _buildMilestones(
                            context,
                            colors,
                            textTheme,
                            isCompact,
                          ),
                          const SizedBox(height: 16),
                          _buildPropertyOverview(
                            context,
                            colors,
                            textTheme,
                            isCompact,
                          ),
                          const SizedBox(height: 16),
                          _buildTerms(
                            context,
                            colors,
                            textTheme,
                            isCompact,
                          ),
                          const SizedBox(height: 16),
                          _buildRegulatoryFootnote(
                            context,
                            colors,
                            textTheme,
                            isCompact,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildBottomActions(
              context,
              colors,
              textTheme,
              isCompact,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(
      BuildContext context,
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(
            color: colors.surfaceContainerHigh,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 12 : 16,
          vertical: 10,
        ),
        child: Row(
          children: [
            _CircleIconButton(
              icon: Icons.arrow_back_rounded,
              tooltip: 'Go Back',
              color: colors.primary,
              onPressed: widget.onBack ?? () => Navigator.of(context).maybePop(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Offer Details #LX-1092',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Lekki Duplex Phase 1',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            _CircleIconButton(
              icon: Icons.share_outlined,
              tooltip: 'Share Slip',
              color: colors.primary,
              onPressed: widget.onShare,
            ),
            _CircleIconButton(
              icon: Icons.more_vert_rounded,
              tooltip: 'More Options',
              color: colors.primary,
              onPressed: widget.onMore,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(
      BuildContext context,
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return _CardContainer(
      colors: colors,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCompact)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _statusBadge(colors, textTheme),
                const SizedBox(height: 8),
                _expiryBadge(colors, textTheme),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _statusBadge(colors, textTheme),
                ),
                const SizedBox(width: 8),
                _expiryBadge(colors, textTheme),
              ],
            ),
          const SizedBox(height: 10),
          Divider(
            height: 1,
            color: colors.surfaceContainer,
          ),
          const SizedBox(height: 8),
          if (isCompact)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _verifiedRail(colors, textTheme),
                const SizedBox(height: 5),
                Text(
                  'Stanbic IBTC Rails',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.outline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _verifiedRail(colors, textTheme),
                ),
                Text(
                  'Stanbic IBTC Rails',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.outline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _statusBadge(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colors.secondaryContainer.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: colors.secondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              'PENDING SELLER DECISION',
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: colors.secondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _expiryBadge(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colors.errorContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colors.errorContainer,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 15,
            color: colors.error,
          ),
          const SizedBox(width: 4),
          Text(
            'Expires in 22h 45m',
            style: textTheme.labelSmall?.copyWith(
              color: colors.error,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verifiedRail(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.verified_user_rounded,
          size: 16,
          color: colors.tertiary,
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            'NIBSS Verified Escrow-Ready',
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialSummary(
      BuildContext context,
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return _CardContainer(
      colors: colors,
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Positioned(
            top: -55,
            right: -55,
            child: IgnorePointer(
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: colors.primaryFixed.withValues(alpha: 0.28),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total Cash Offer Amount',
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _smallSurfaceBadge(
                    colors,
                    textTheme,
                    'Outright Purchase',
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
               // t: TextBaseline.alphabetic,
                children: [
                  Text(
                    '₦115,000,000',
                    style: textTheme.displaySmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.1,
                      fontFeatures: const [
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                  Text(
                    '.00',
                    style: textTheme.titleLarge?.copyWith(
                      color: colors.outline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '"One Hundred and Fifteen Million Nigerian Naira Only"',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              _buildPricingGrid(
                colors,
                textTheme,
                isCompact,
              ),
              const SizedBox(height: 12),
              _buildDepositCallout(
                colors,
                textTheme,
                isCompact,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallSurfaceBadge(
      ColorScheme colors,
      TextTheme textTheme,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: textTheme.labelSmall?.copyWith(
          color: colors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildPricingGrid(
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    if (isCompact) {
      return Column(
        children: [
          _pricingItem(
            colors,
            textTheme,
            'Listing Price',
            '₦120,000,000',
          ),
          const SizedBox(height: 8),
          _pricingItem(
            colors,
            textTheme,
            'Variance',
            '-4.1% (₦5M off)',
            secondary: true,
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _pricingItem(
              colors,
              textTheme,
              'Listing Price',
              '₦120,000,000',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _pricingItem(
              colors,
              textTheme,
              'Variance',
              '-4.1% (₦5M off)',
              secondary: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pricingItem(
      ColorScheme colors,
      TextTheme textTheme,
      String label,
      String value, {
        bool secondary = false,
      }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              if (secondary) ...[
                Icon(
                  Icons.trending_down_rounded,
                  size: 14,
                  color: colors.secondary,
                ),
                const SizedBox(width: 2),
              ],
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: secondary
                        ? colors.secondary
                        : colors.onSurface,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepositCallout(
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.surfaceContainerHigh,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              size: 18,
              color: colors.onPrimary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Earnest Deposit Committed: ',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: '₦11,500,000 (10%)',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text:
                    '\nPre-Authorized in Stanbic IBTC Escrow Vault. Instant freeze occurs upon offer acceptance.',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyerTrust(
      BuildContext context,
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return _CardContainer(
      colors: colors,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (isCompact)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buyerIdentity(colors, textTheme),
                const SizedBox(height: 10),
                _trustBadge(colors, textTheme),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _buyerIdentity(colors, textTheme),
                ),
                const SizedBox(width: 8),
                _trustBadge(colors, textTheme),
              ],
            ),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: colors.surfaceContainer,
          ),
          const SizedBox(height: 12),
          if (isCompact)
            Column(
              children: [
                _trustMetric(
                  colors,
                  textTheme,
                  icon: Icons.account_balance_rounded,
                  iconColor: colors.primary,
                  title: 'Bank Proof of Funds',
                  value: 'Zenith Bank PLC',
                  subtitle: '₦150M+ Verified Capacity',
                ),
                const SizedBox(height: 8),
                _trustMetric(
                  colors,
                  textTheme,
                  icon: Icons.verified_rounded,
                  iconColor: colors.secondary,
                  title: 'Statutory KYC',
                  value: 'Tier 3 Certified',
                  subtitle: 'BVN, NIN & CAC Cleared',
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _trustMetric(
                    colors,
                    textTheme,
                    icon: Icons.account_balance_rounded,
                    iconColor: colors.primary,
                    title: 'Bank Proof of Funds',
                    value: 'Zenith Bank PLC',
                    subtitle: '₦150M+ Verified Capacity',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _trustMetric(
                    colors,
                    textTheme,
                    icon: Icons.verified_rounded,
                    iconColor: colors.secondary,
                    title: 'Statutory KYC',
                    value: 'Tier 3 Certified',
                    subtitle: 'BVN, NIN & CAC Cleared',
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: widget.onViewBuyerProfile,
            style: TextButton.styleFrom(
              foregroundColor: colors.primary,
              padding: const EdgeInsets.symmetric(vertical: 6),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'View Full Buyer Trust Profile & KYC Dossier',
                    textAlign: TextAlign.center,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 15,
                  color: colors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buyerIdentity(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'AB',
                style: textTheme.titleMedium?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Positioned(
              right: -1,
              bottom: -1,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: colors.tertiaryFixed,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colors.surfaceContainerLowest,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: 9,
                  color: colors.onTertiaryFixed,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 6,
                runSpacing: 3,
                children: [
                  Text(
                    'Adeola Balogun',
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colors.secondaryContainer.withValues(
                        alpha: 0.14,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: colors.secondaryFixed,
                      ),
                    ),
                    child: Text(
                      'REAN',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.secondary,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Accredited Institutional Buyer',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.outline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _trustBadge(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shield_rounded,
                size: 13,
                color: colors.secondaryContainer,
              ),
              const SizedBox(width: 4),
              Text(
                '94% Trust',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '14 Verified Closures',
          style: textTheme.labelSmall?.copyWith(
            color: colors.outline,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _trustMetric(
      ColorScheme colors,
      TextTheme textTheme, {
        required IconData icon,
        required Color iconColor,
        required String title,
        required String value,
        required String subtitle,
      }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(
                icon,
                size: 15,
                color: iconColor,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestones(
      BuildContext context,
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return _CardContainer(
      colors: colors,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCompact)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _milestoneTitle(colors, textTheme),
                const SizedBox(height: 8),
                _closeBadge(colors, textTheme),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _milestoneTitle(colors, textTheme),
                ),
                _closeBadge(colors, textTheme),
              ],
            ),
          const SizedBox(height: 16),
          _timeline(
            colors,
            textTheme,
            isCompact,
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: isCompact
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimated Closing Window:',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.outline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                _closingDate(colors, textTheme),
              ],
            )
                : Row(
              children: [
                Expanded(
                  child: Text(
                    'Estimated Closing Window:',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.outline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                _closingDate(colors, textTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _milestoneTitle(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Row(
      children: [
        Icon(
          Icons.payments_outlined,
          size: 17,
          color: colors.primary,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            'Milestone Settlement Rails',
            style: textTheme.labelLarge?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _closeBadge(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: colors.primaryFixed,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        '14-Day Close',
        style: textTheme.labelSmall?.copyWith(
          color: colors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _timeline(
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return Padding(
      padding: const EdgeInsets.only(left: 9),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 18,
              child: Column(
                children: [
                  _timelineDot(
                    colors.primary,
                    colors.surfaceContainerLowest,
                  ),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: colors.surfaceContainerHigh,
                    ),
                  ),
                  _timelineDot(
                    colors.outlineVariant,
                    colors.surfaceContainerLowest,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                children: [
                  _milestoneItem(
                    colors,
                    textTheme,
                    title: 'Milestone 1: Earnest Escrow Hold',
                    amount: '₦11,500,000 (10%)',
                    description:
                    'Locked instantaneously in Stanbic Vault upon pressing "Accept Offer".',
                    active: true,
                    compact: isCompact,
                  ),
                  const SizedBox(height: 24),
                  _milestoneItem(
                    colors,
                    textTheme,
                    title: 'Milestone 2: Deed & Cadastral Handover',
                    amount: '₦103,500,000 (90%)',
                    description:
                    'Released upon Lagos State Land Bureau search confirmation and physical keys exchange.',
                    active: false,
                    compact: isCompact,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timelineDot(
      Color color,
      Color ringColor,
      ) {
    return Container(
      width: 17,
      height: 17,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: ringColor,
          width: 3,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color == ringColor
              ? Colors.transparent
              : Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _milestoneItem(
      ColorScheme colors,
      TextTheme textTheme, {
        required String title,
        required String amount,
        required String description,
        required bool active,
        required bool compact,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (compact)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.labelMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                amount,
                style: textTheme.labelMedium?.copyWith(
                  color: active ? colors.primary : colors.onSurface,
                  fontWeight: FontWeight.w800,
                  fontFeatures: const [
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                amount,
                textAlign: TextAlign.right,
                style: textTheme.labelMedium?.copyWith(
                  color: active ? colors.primary : colors.onSurface,
                  fontWeight: FontWeight.w800,
                  fontFeatures: const [
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
            ],
          ),
        const SizedBox(height: 3),
        Text(
          description,
          style: textTheme.labelSmall?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _closingDate(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.event_available_rounded,
          size: 14,
          color: colors.primary,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            '14 Business Days (Nov 15, 2024)',
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyOverview(
      BuildContext context,
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return _CardContainer(
      colors: colors,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _propertyImage(colors),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LISTED ASSET',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.secondary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.7,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Contemporary 4-Bed Smart Detached Duplex with BQ',
                  maxLines: isCompact ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: colors.outline,
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        'Admiralty Way, Lekki Phase 1, Lagos',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.outline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Gov. Consent & C-of-O Audited',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _propertyImage(ColorScheme colors) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCHYGD8kBZ0HlI7RoIl5O5V-OovhuKJXof44DbjZsC0pjXTLUhN7YN77yHcpPYwXco3lH0FWz37vlMgFZkPMbGdjHUM-FxMZja59I5fdyVJ0v9mKorqp1ExbSr_n032KnUL4EaW05P6B14hignFH2SnYp2w6BF8u44W6U2x5VHqezRmy9sLfH8NRcxrgWdXZPTCPsoVRHtzRh2BnNMzEAem0pm_jjnYxZ_6_yHrx1ZHif1chjPSU4fY',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Icon(
            Icons.home_work_outlined,
            color: colors.outline,
            size: 28,
          );
        },
      ),
    );
  }

  Widget _buildTerms(
      BuildContext context,
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return _CardContainer(
      colors: colors,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TERMS & CONTINGENCIES',
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          _termRow(
            colors,
            textTheme,
            icon: Icons.domain_verification_outlined,
            title: 'Inspection Period',
            description:
            '48-Hour structural and smart automation fixtures walkthrough window post-deposit.',
          ),
          const SizedBox(height: 10),
          _termRow(
            colors,
            textTheme,
            icon: Icons.gavel_rounded,
            title: 'Conveyancing Solicitor',
            description:
            'Adeola & Partners Legal Chambers (REAN Accredited Conveyancers).',
          ),
          const SizedBox(height: 10),
          _termRow(
            colors,
            textTheme,
            icon: Icons.money_off_rounded,
            iconColor: colors.tertiary,
            title: 'Zero Brokerage Commission',
            description:
            'HomeX Direct-Deal protocol applies. ₦0 commission payable by the seller.',
          ),
        ],
      ),
    );
  }

  Widget _termRow(
      ColorScheme colors,
      TextTheme textTheme, {
        required IconData icon,
        required String title,
        required String description,
        Color? iconColor,
      }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 17,
          color: iconColor ?? colors.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$title: ',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: description,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegulatoryFootnote(
      BuildContext context,
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_rounded,
                size: 14,
                color: colors.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  'SEC Nigeria & NDIC Insured Escrow Rails',
                  textAlign: TextAlign.center,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "Accepting this offer legally commits the buyer's ₦11.5M earnest hold. Countering will immediately notify Adeola Balogun and reset the 24-hour decision timer.",
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(
      BuildContext context,
      ColorScheme colors,
      TextTheme textTheme,
      bool isCompact,
      ) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest.withValues(
            alpha: 0.96,
          ),
          border: Border(
            top: BorderSide(
              color: colors.surfaceContainerHigh,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.10),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              isCompact ? 12 : 16,
              10,
              isCompact ? 12 : 16,
              10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: OutlinedButton.icon(
                        onPressed:()=>AppNavigator.pushAndStackNamed(AppRoutes.counterOfferScreen),// widget.onCounter,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.primary,
                          side: BorderSide(
                            color: colors.outline,
                          ),
                          minimumSize: const Size(
                            double.infinity,
                            48,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                        ),
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          size: 18,
                        ),
                        label: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Counter Offer',
                            style: textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: FilledButton.icon(
                        onPressed:
                        _isAccepting ? null : _handleAccept,
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: colors.onPrimary,
                          disabledBackgroundColor:
                          colors.primary.withValues(alpha: 0.55),
                          minimumSize: const Size(
                            double.infinity,
                            48,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                        ),
                        icon: _isAccepting
                            ? SizedBox(
                          width: 17,
                          height: 17,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors.onPrimary,
                          ),
                        )
                            : const Icon(
                          Icons.lock_rounded,
                          size: 17,
                        ),
                        label: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _isAccepting
                                ? 'Locking Escrow...'
                                : 'Accept & Lock Escrow',
                            style: textTheme.labelMedium?.copyWith(
                              color: colors.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: widget.onDecline,
                  style: TextButton.styleFrom(
                    foregroundColor: colors.error,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.close_rounded,
                        size: 14,
                        color: colors.error,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'Decline Offer & Archive Dossier',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.error,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  const _CardContainer({
    required this.colors,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final ColorScheme colors;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.035),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.tooltip,
    required this.color,
    this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      splashRadius: 22,
      icon: Icon(
        icon,
        size: 21,
        color: color,
      ),
    );
  }
}