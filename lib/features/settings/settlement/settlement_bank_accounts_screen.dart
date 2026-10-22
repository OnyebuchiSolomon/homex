import 'package:homex/ui/global.dart';

class SettlementBankAccountsScreen extends StatefulWidget {
  const SettlementBankAccountsScreen({
    super.key,
    this.onBack,
    this.onInfo,
    this.onEditPrimaryAccount,
    this.onLinkNewBank,
    this.onSave,
    this.onCancel,
    this.onNavigationChanged,
  });

  final VoidCallback? onBack;
  final VoidCallback? onInfo;
  final VoidCallback? onEditPrimaryAccount;
  final VoidCallback? onLinkNewBank;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;
  final ValueChanged<int>? onNavigationChanged;

  @override
  State<SettlementBankAccountsScreen> createState() =>
      _SettlementBankAccountsScreenState();
}

class _SettlementBankAccountsScreenState
    extends State<SettlementBankAccountsScreen>
    with SingleTickerProviderStateMixin {
  bool _instantDisbursement = true;

  int _selectedPrimaryAccount = 0;

  bool _showToast = false;

  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _showSavedToast() {
    setState(() => _showToast = true);

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      setState(() => _showToast = false);
    });
  }

  void _save() {
    _showSavedToast();
    widget.onSave?.call();
  }

  Future<void> _copyAccountNumber() async {
    await Clipboard.setData(
      const ClipboardData(text: '2088419090'),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account number copied'),
        duration: Duration(milliseconds: 1400),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;



    return Scaffold(
      backgroundColor: colors.surface,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildAppBar(colors),
                    Expanded(
                      child: _buildContent(colors),
                    ),

                  ],
                ),
                _buildToast(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(ColorScheme colors) {
    return Container(
      height: 64,
      width: double.infinity,
      color: colors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _CircleIconButton(
              icon: Icons.arrow_back,
              onPressed: widget.onBack ?? () => Navigator.maybePop(context),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settlement Bank & Escrow Accounts',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.headlineSmall.copyWith(
                      fontSize: 16,
                      height: 20 / 16,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.verified_user,
                        size: 13,
                        color: colors.onTertiaryContainer,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'SEC & NDIC Ring-Fenced Custody',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.labelSmall.copyWith(
                            fontSize: 10.5,
                            color: colors.outline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _CircleIconButton(
              icon: Icons.info_outline,
              onPressed: widget.onInfo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ColorScheme colors) {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        final curved = CurvedAnimation(
          parent: _entranceController,
          curve: AppAnimations.enter,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.012),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProtectionNotice(colors),
            const SizedBox(height: 16),
            _buildPrimaryAccount(colors),
            const SizedBox(height: 18),
            _buildSecondaryAccounts(colors),
            const SizedBox(height: 18),
            _buildLinkBankButton(colors),
            const SizedBox(height: 18),
            _buildSecurityControls(colors),
            const SizedBox(height: 16),
            _buildComplianceFooter(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildProtectionNotice(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shield,
              size: 20,
              color: colors.onPrimary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Statutory Settlement Protection',
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    _SmallBadge(
                      text: 'Tier 3',
                      background: colors.secondaryContainer,
                      foreground: colors.onSecondaryContainer,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(
                    text:
                    'Escrow disbursements and property liquidation payouts are strictly routed to your verified institutional corporate/personal settlement accounts. Name must match ',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 11.5,
                      height: 17 / 11.5,
                      fontWeight: FontWeight.w400,
                      color: colors.onSurfaceVariant,
                    ),
                    children: [
                      TextSpan(
                        text: 'Alexander Magnus',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                        ),
                      ),
                      const TextSpan(
                        text: ' (Tier 3 BVN Verified).',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryAccount(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.primary,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 5,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 13,
                            color: colors.tertiaryFixed,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'PRIMARY SETTLEMENT ACCOUNT',
                            style: AppTextStyles.labelSmall.copyWith(
                              fontSize: 9.5,
                              color: colors.onPrimary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _SmallBadge(
                      text: '100% Name Match Verified',
                      background: colors.onTertiaryContainer
                          .withValues(alpha: 0.10),
                      foreground: colors.onTertiaryContainer,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () {},
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colors.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: colors.outlineVariant.withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'ZB',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Zenith Bank PLC',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.headlineSmall.copyWith(
                              fontSize: 16,
                              height: 20 / 16,
                              fontWeight: FontWeight.w700,
                              color: colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Alexander Magnus',
                            style: AppTextStyles.labelSmall.copyWith(
                              fontSize: 11.5,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _StatusPill(
                text: 'NIBSS Rail',
                icon: Icons.circle,
                colors: colors,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colors.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DESIGNATED NUBAN',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 9.5,
                          color: colors.outline,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '2088 4190 90',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 17,
                          height: 22 / 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.2,
                          color: colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _OutlinedActionButton(
                  icon: Icons.content_copy,
                  label: 'Copy',
                  onPressed: _copyAccountNumber,
                  colors: colors,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _AccountMeta(
                  title: 'Account Classification',
                  value: 'Corporate Savings / Current',
                  colors: colors,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AccountMeta(
                  title: 'Security Clearance',
                  value: '2FA & PIN Enforced',
                  icon: Icons.lock_outline,
                  colors: colors,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 42,
            child: ElevatedButton.icon(
              onPressed:()=>AppNavigator.pushAndStackNamed(AppRoutes.editSettlementAccountScreen),// widget.onEditPrimaryAccount,
              icon: const Icon(
                Icons.edit_outlined,
                size: 18,
              ),
              label: const Text('Edit Account Details'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.surfaceContainerHigh,
                foregroundColor: colors.onSurface,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryAccounts(ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'SECONDARY & BACKUP ACCOUNTS',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.7,
                    color: colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Failover Escrow Protocol',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  color: colors.outline,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _BackupAccountCard(
          initials: 'SB',
          bankName: 'Stanbic IBTC Bank',
          badge: 'BACKUP ESCROW ACCOUNT',
          accountNumber: '0041••••18',
          status: 'Verified (Ready for failover settlement)',
          statusIcon: Icons.check_circle_outline,
          statusColor: colors.onTertiaryContainer,
          badgeBackground: colors.surfaceContainer,
          badgeForeground: colors.onSurfaceVariant,
          colors: colors,
          onSetPrimary: () => _setPrimary(1),
        ),
        const SizedBox(height: 10),
        _BackupAccountCard(
          initials: 'PB',
          bankName: 'Providus Bank PLC',
          badge: 'VIRTUAL ESCROW RESERVES',
          accountNumber: '9928••••34',
          status: 'Dedicated Dynamic Escrow Sub-account',
          statusIcon: Icons.account_tree_outlined,
          statusColor: colors.outline,
          badgeBackground: colors.secondaryFixed,
          badgeForeground: colors.onSecondaryFixed,
          colors: colors,
          onSetPrimary: () => _setPrimary(2),
        ),
      ],
    );
  }

  void _setPrimary(int accountIndex) {
    setState(() {
      _selectedPrimaryAccount = accountIndex;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Primary settlement account updated'),
        duration: Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildLinkBankButton(ColorScheme colors) {
    return Material(
      color: colors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap:()=>AppNavigator.pushAndStackNamed(AppRoutes.linkSettlementBankScreen),// widget.onLinkNewBank,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.outlineVariant,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 20,
                    color: colors.onSurface,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+ Link New Settlement Bank',
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Requires BVN verification & 2FA PIN authorization',
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10.5,
                  color: colors.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityControls(ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ESCROW RULES & SECURITY CONTROLS',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.7,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Institutional parameters governing automated disbursements',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w400,
                  color: colors.outline,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          child: Column(
            children: [
              _buildInstantDisbursementControl(colors),
              Divider(
                height: 1,
                color: colors.surfaceContainer,
              ),
              _buildThresholdControl(colors),
              Divider(
                height: 1,
                color: colors.surfaceContainer,
              ),
              _buildCoolingLock(colors),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstantDisbursementControl(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bolt_outlined,
                      size: 18,
                      color: colors.onSurface,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Instant Disbursement Auto-Routing',
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Automatically route closed property transaction proceeds directly to primary settlement bank within 15 minutes.',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 11.5,
                    height: 16 / 11.5,
                    fontWeight: FontWeight.w400,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: _HomeXSwitch(
              value: _instantDisbursement,
              onChanged: (value) {
                setState(() => _instantDisbursement = value);
              },
              colors: colors,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThresholdControl(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.policy_outlined,
                size: 18,
                color: colors.onSurface,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Dual-Signatory Threshold',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '₦50,000,000.00',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: colors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Payouts above this threshold require secondary trustee sign-off and 6-digit Transaction PIN clearance.',
            style: AppTextStyles.labelSmall.copyWith(
              fontSize: 11.5,
              height: 16 / 11.5,
              fontWeight: FontWeight.w400,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoolingLock(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colors.secondaryFixed.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.lock_clock_outlined,
              size: 18,
              color: colors.onSecondaryFixed,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Disbursement Cooling Lock',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '24-hour mandatory delay after modifying settlement account details to prevent fraudulent diversion.',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 11.5,
                    height: 16 / 11.5,
                    fontWeight: FontWeight.w400,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceFooter(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_outlined,
            size: 22,
            color: colors.outline,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                    'NDIC & Central Bank of Nigeria (CBN) Custody Compliance. ',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 10.5,
                      height: 15 / 10.5,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
                  ),
                  TextSpan(
                    text:
                    'Licensed under SEC Nigeria & NDIC Custody Rules. Zero plaintext banking data retention.',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 10.5,
                      height: 15 / 10.5,
                      fontWeight: FontWeight.w400,
                      color: colors.onSurfaceVariant,
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

  Widget _buildBottomNavigation(ColorScheme colors) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          border: Border(
            top: BorderSide(
              color: colors.outlineVariant.withValues(alpha: 0.7),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(
              icon: Icons.account_balance_outlined,
              label: 'Home',
              selected: false,
              colors: colors,
              onTap: () => widget.onNavigationChanged?.call(0),
            ),
            _BottomNavItem(
              icon: Icons.shield_outlined,
              label: 'Escrow',
              selected: false,
              colors: colors,
              onTap: () => widget.onNavigationChanged?.call(1),
            ),
            _BottomNavItem(
              icon: Icons.real_estate_agent_outlined,
              label: 'Properties',
              selected: false,
              colors: colors,
              onTap: () => widget.onNavigationChanged?.call(2),
            ),
            _BottomNavItem(
              icon: Icons.manage_accounts,
              label: 'Settings',
              selected: true,
              colors: colors,
              onTap: () => widget.onNavigationChanged?.call(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToast(ColorScheme colors) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 86,
      child: IgnorePointer(
        ignoring: !_showToast,
        child: AnimatedOpacity(
          opacity: _showToast ? 1 : 0,
          duration: const Duration(milliseconds: 180),
          curve: AppAnimations.standard,
          child: AnimatedSlide(
            offset: _showToast
                ? Offset.zero
                : const Offset(0, 0.08),
            duration: const Duration(milliseconds: 180),
            curve: AppAnimations.standard,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: colors.inverseSurface,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: colors.shadow.withValues(alpha: 0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 18,
                    color: colors.onInverseSurface,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Settlement preferences updated',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.onInverseSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Live',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 10,
                      color: colors.secondaryFixed,
                      fontWeight: FontWeight.w700,
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

class _BackupAccountCard extends StatelessWidget {
  const _BackupAccountCard({
    required this.initials,
    required this.bankName,
    required this.badge,
    required this.accountNumber,
    required this.status,
    required this.statusIcon,
    required this.statusColor,
    required this.badgeBackground,
    required this.badgeForeground,
    required this.colors,
    required this.onSetPrimary,
  });

  final String initials;
  final String bankName;
  final String badge;
  final String accountNumber;
  final String status;
  final IconData statusIcon;
  final Color statusColor;
  final Color badgeBackground;
  final Color badgeForeground;
  final ColorScheme colors;
  final VoidCallback onSetPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: colors.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      bankName,
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.onSurface,
                      ),
                    ),
                    _SmallBadge(
                      text: badge,
                      background: badgeBackground,
                      foreground: badgeForeground,
                      fontSize: 8.5,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  accountNumber,
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      statusIcon,
                      size: 13,
                      color: statusColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        status,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w500,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          TextButton(
            onPressed: onSetPrimary,
            style: TextButton.styleFrom(
              backgroundColor: colors.surfaceContainerLow,
              foregroundColor: colors.onSurface,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              'Set as Primary',
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountMeta extends StatelessWidget {
  const _AccountMeta({
    required this.title,
    required this.value,
    required this.colors,
    this.icon,
  });

  final String title;
  final String value;
  final ColorScheme colors;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.labelSmall.copyWith(
            fontSize: 9.5,
            fontWeight: FontWeight.w400,
            color: colors.outline,
          ),
        ),
        const SizedBox(height: 3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 13,
                color: colors.onTertiaryContainer,
              ),
              const SizedBox(width: 4),
            ],
            Expanded(
              child: Text(
                value,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10,
                  height: 14 / 10,
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SmallBadge extends StatelessWidget {
  const _SmallBadge({
    required this.text,
    required this.background,
    required this.foreground,
    this.fontSize = 9,
  });

  final String text;
  final Color background;
  final Color foreground;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          fontSize: fontSize,
          height: 12 / fontSize,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.text,
    required this.icon,
    required this.colors,
  });

  final String text;
  final IconData icon;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 6,
            color: colors.onTertiaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              fontSize: 9,
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlinedActionButton extends StatelessWidget {
  const _OutlinedActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.colors,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 16,
      ),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surfaceContainerLowest,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          color: colors.outlineVariant,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: AppTextStyles.labelSmall.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HomeXSwitch extends StatelessWidget {
  const _HomeXSwitch({
    required this.value,
    required this.onChanged,
    required this.colors,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: colors.onPrimary,
      activeTrackColor: colors.primary,
      inactiveThumbColor: colors.surfaceContainerLowest,
      inactiveTrackColor: colors.surfaceContainerHighest,
      trackOutlineColor: WidgetStatePropertyAll(
        colors.outlineVariant,
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.colors,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final ColorScheme colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? colors.onPrimary
        : colors.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: AppAnimations.fastCurve,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colors.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: foreground,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: 10,
                color: foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 22,
        color: colors.onSurface,
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ),
      visualDensity: VisualDensity.compact,
    );
  }
}