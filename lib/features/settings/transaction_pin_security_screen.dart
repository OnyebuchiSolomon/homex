import 'package:homex/ui/global.dart';
class TransactionPinSecurityScreen extends StatefulWidget {
  const TransactionPinSecurityScreen({
    super.key,
    this.onBack,
    this.onInfo,
    this.onChangePin,
    this.onResetPin,
    this.onEmergencyLock,
  });

  final VoidCallback? onBack;
  final VoidCallback? onInfo;
  final VoidCallback? onChangePin;
  final VoidCallback? onResetPin;
  final VoidCallback? onEmergencyLock;

  @override
  State<TransactionPinSecurityScreen> createState() =>
      _TransactionPinSecurityScreenState();
}

class _TransactionPinSecurityScreenState
    extends State<TransactionPinSecurityScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _contentAnimation;

  bool _escrowThresholdEnabled = true;
  bool _biometricBypassEnabled = true;
  bool _isEmergencyLocking = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: AppAnimations.enter,
    );

    _contentAnimation = Tween<Offset>(
      begin: const Offset(0, 0.012),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.enter,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleEmergencyLock() async {
    if (_isEmergencyLocking) return;

    setState(() {
      _isEmergencyLocking = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() {
      _isEmergencyLocking = false;
    });

    widget.onEmergencyLock?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final width = context.widthPx;

    final horizontalPadding = width < 360 ? 16.0 : 20.0;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              children: [
                _TransactionPinHeader(
                  onBack: widget.onBack,
                  onInfo: widget.onInfo,
                ),
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _contentAnimation,
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              16,
                              horizontalPadding,
                              24,
                            ),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                _SecurityOverviewCard(),

                                const SizedBox(height: 20),

                                _SectionHeader(
                                  title: 'PIN Management & Policies',
                                  trailing: 'Hardware Encrypted',
                                ),

                                const SizedBox(height: 10),

                                _PinManagementCard(
                                  escrowThresholdEnabled:
                                  _escrowThresholdEnabled,
                                  biometricBypassEnabled:
                                  _biometricBypassEnabled,
                                  onChangePin: widget.onChangePin,
                                  onResetPin: widget.onResetPin,
                                  onEscrowThresholdChanged: (value) {
                                    setState(() {
                                      _escrowThresholdEnabled = value;
                                    });
                                  },
                                  onBiometricBypassChanged: (value) {
                                    setState(() {
                                      _biometricBypassEnabled = value;
                                    });
                                  },
                                ),

                                const SizedBox(height: 16),

                                _ProtocolNotice(),

                                const SizedBox(height: 20),

                                const _SectionHeader(
                                  title: 'Recent PIN Authorizations',
                                  trailing: 'Last 30 Days',
                                  trailingMuted: true,
                                ),

                                const SizedBox(height: 10),

                                const _AuthorizationList(),

                                const SizedBox(height: 20),

                                _EmergencyLockCard(
                                  isLoading: _isEmergencyLocking,
                                  onLock: _handleEmergencyLock,
                                ),

                                const SizedBox(height: 16),

                                const _ComplianceFooter(),

                                const SizedBox(height: 8),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
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

// -----------------------------------------------------------------------------
// HEADER
// -----------------------------------------------------------------------------

class _TransactionPinHeader extends StatelessWidget {
  const _TransactionPinHeader({
    required this.onBack,
    required this.onInfo,
  });

  final VoidCallback? onBack;
  final VoidCallback? onInfo;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.94),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          _CircularIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: onBack ?? () => Navigator.maybePop(context),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SECURITY CENTER',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.outline,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Transaction PIN',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _TierBadge(),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onInfo,
            splashRadius: 20,
            tooltip: 'Security information',
            icon: Icon(
              Icons.info_outline_rounded,
              color: colors.outline,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularIconButton extends StatelessWidget {
  const _CircularIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.surfaceContainerLowest,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: colors.onSurface,
            size: 21,
          ),
        ),
      ),
    );
  }
}

class _TierBadge extends StatelessWidget {
  const _TierBadge();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shield_rounded,
            size: 14,
            color: colors.secondary,
          ),
          const SizedBox(width: 5),
          Text(
            'Tier 3',
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SECURITY OVERVIEW
// -----------------------------------------------------------------------------

class _SecurityOverviewCard extends StatelessWidget {
  const _SecurityOverviewCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            bottom: -35,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.password_rounded,
                      color: colors.primaryFixed,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _StatusBadge(),
                        const SizedBox(height: 4),
                        Text(
                          '6-Digit Cryptographic Key',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.verified_user_rounded,
                    color: colors.secondary,
                    size: 22,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'Your cryptographic PIN authorizes high-value escrow fund '
                    'deposits, milestone disbursements, and authenticates '
                    'direct-deal Lagos and Abuja deed bindings.',
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 1,
                color: colors.surfaceContainer,
              ),
              const SizedBox(height: 12),
              const _SecurityMetaRow(),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: colors.tertiaryFixed.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colors.tertiaryFixedDim.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: colors.onTertiaryContainer,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'ACTIVE & SECURED',
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.onTertiaryContainer,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityMetaRow extends StatelessWidget {
  const _SecurityMetaRow();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Expanded(
          child: _MetaItem(
            icon: Icons.schedule_rounded,
            label: 'Changed 42 days ago',
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: _MetaItem(
            icon: Icons.smartphone_rounded,
            label: 'iPhone 15 Pro • Ikoyi',
          ),
        ),
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: colors.outline,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.outline,
              fontSize: 10.5,
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// SECTION HEADER
// -----------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.trailing,
    this.trailingMuted = false,
  });

  final String title;
  final String trailing;
  final bool trailingMuted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.outline,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            trailing,
            style: AppTextStyles.labelSmall.copyWith(
              color: trailingMuted
                  ? colors.outline
                  : colors.secondary,
              fontWeight: trailingMuted
                  ? FontWeight.w400
                  : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PIN MANAGEMENT
// -----------------------------------------------------------------------------

class _PinManagementCard extends StatelessWidget {
  const _PinManagementCard({
    required this.escrowThresholdEnabled,
    required this.biometricBypassEnabled,
    required this.onChangePin,
    required this.onResetPin,
    required this.onEscrowThresholdChanged,
    required this.onBiometricBypassChanged,
  });

  final bool escrowThresholdEnabled;
  final bool biometricBypassEnabled;
  final VoidCallback? onChangePin;
  final VoidCallback? onResetPin;
  final ValueChanged<bool> onEscrowThresholdChanged;
  final ValueChanged<bool> onBiometricBypassChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _ManagementAction(
            icon: Icons.lock_reset_rounded,
            title: 'Change Transaction PIN',
            subtitle: 'Re-authenticate with current PIN & Biometrics',
            onTap: onChangePin,
          ),
          _Divider(),
          _ManagementAction(
            icon: Icons.badge_rounded,
            title: 'Reset Forgotten PIN',
            subtitle: 'Tier 3 BVN/NIN verification + SMS/Email OTP',
            onTap: onResetPin,
          ),
          _Divider(),
          _PolicyToggleRow(
            icon: Icons.rule_rounded,
            title: 'Escrow Threshold',
            badge: '₦500k+',
            subtitle:
            'Enforce mandatory PIN for all escrow actions > ₦500,000',
            value: escrowThresholdEnabled,
            onChanged: onEscrowThresholdChanged,
          ),
          _PolicyToggleRow(
            icon: Icons.fingerprint_rounded,
            title: 'Biometric PIN Bypass',
            badge: 'Under ₦5M',
            mutedBadge: true,
            subtitle:
            'Use Face ID or Touch ID in place of key for minor fees',
            value: biometricBypassEnabled,
            onChanged: onBiometricBypassChanged,
          ),
        ],
      ),
    );
  }
}

class _ManagementAction extends StatefulWidget {
  const _ManagementAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  State<_ManagementAction> createState() => _ManagementActionState();
}

class _ManagementActionState extends State<_ManagementAction> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: _pressed
          ? colors.surfaceContainerLow
          : colors.surfaceContainerLowest,
      child: InkWell(
        onTap: widget.onTap,
        onHighlightChanged: (value) {
          setState(() {
            _pressed = value;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                curve: AppAnimations.fastCurve,
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _pressed
                      ? colors.primary
                      : colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  widget.icon,
                  color: _pressed
                      ? colors.onPrimary
                      : colors.onSurface,
                  size: 19,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.outline,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              AnimatedSlide(
                duration: const Duration(milliseconds: 120),
                curve: AppAnimations.fastCurve,
                offset: _pressed
                    ? const Offset(0.08, 0)
                    : Offset.zero,
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: _pressed
                      ? colors.onSurface
                      : colors.outlineVariant,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.colors.surfaceContainer,
    );
  }
}

class _PolicyToggleRow extends StatelessWidget {
  const _PolicyToggleRow({
    required this.icon,
    required this.title,
    required this.badge,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.mutedBadge = false,
  });

  final IconData icon;
  final String title;
  final String badge;
  final String subtitle;
  final bool value;
  final bool mutedBadge;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              color: colors.onSurface,
              size: 19,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: mutedBadge
                            ? colors.surfaceContainerHigh
                            : colors.secondaryFixed,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badge,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: mutedBadge
                              ? colors.onSurfaceVariant
                              : colors.onSecondaryFixed,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.outline,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _HomeXSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _HomeXSwitch extends StatelessWidget {
  const _HomeXSwitch({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: AppAnimations.smooth,
        width: 44,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value
              ? colors.primary
              : colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: AppAnimations.smooth,
          alignment:
          value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              shape: BoxShape.circle,
              border: Border.all(
                color: value
                    ? colors.surfaceContainerLowest
                    : colors.outlineVariant,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SECURITY NOTICE
// -----------------------------------------------------------------------------

class _ProtocolNotice extends StatelessWidget {
  const _ProtocolNotice();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.policy_rounded,
            color: colors.secondary,
            size: 19,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Strict Escrow Protocol: ',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                    'Never disclose your 6-digit key to developers, '
                        'realtors, or escrow brokers. HomeX legal officers '
                        'will never ask for your PIN.',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.5,
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
}

// -----------------------------------------------------------------------------
// AUDIT TRAIL
// -----------------------------------------------------------------------------

class _AuthorizationList extends StatelessWidget {
  const _AuthorizationList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _AuthorizationItem(
          icon: Icons.real_estate_agent_rounded,
          title: 'The Ikoyi Pearl Milestone 2',
          amount: '₦15,000,000',
          description: 'Escrow Release Authorization',
          date: 'Authorized Oct 28, 2023, 14:22 WAT',
        ),
        SizedBox(height: 8),
        _AuthorizationItem(
          icon: Icons.account_balance_rounded,
          title: 'Asokoro Heights Escrow Deposit',
          amount: '₦45,500,000',
          description: 'Initial Property Commitment Bond',
          date: 'Authorized Oct 24, 2023, 10:15 WAT',
        ),
      ],
    );
  }
}

class _AuthorizationItem extends StatelessWidget {
  const _AuthorizationItem({
    required this.icon,
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
  });

  final IconData icon;
  final String title;
  final String amount;
  final String description;
  final String date;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: colors.onSurfaceVariant,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      amount,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.outline,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: colors.onTertiaryContainer,
                      size: 12,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: colors.outline,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// EMERGENCY LOCK
// -----------------------------------------------------------------------------

class _EmergencyLockCard extends StatelessWidget {
  const _EmergencyLockCard({
    required this.isLoading,
    required this.onLock,
  });

  final bool isLoading;
  final VoidCallback onLock;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.errorContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.errorContainer,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colors.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.gpp_bad_rounded,
                  color: colors.error,
                  size: 19,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emergency Killswitch',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.onErrorContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Detect unauthorized access? Instantly lock your '
                          'transaction PIN and freeze all pending escrow '
                          'milestone releases.',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.error,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: isLoading ? null : onLock,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.error,
                foregroundColor: colors.onError,
                disabledBackgroundColor: colors.error.withValues(
                  alpha: 0.65,
                ),
                disabledForegroundColor: colors.onError,
                elevation: 1,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                switchInCurve: AppAnimations.enter,
                switchOutCurve: AppAnimations.exit,
                child: isLoading
                    ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : Row(
                  key: const ValueKey('button'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_rounded,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Temporarily Lock Escrow Transacting',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.onError,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPLIANCE FOOTER
// -----------------------------------------------------------------------------

class _ComplianceFooter extends StatelessWidget {
  const _ComplianceFooter();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assured_workload_rounded,
              size: 15,
              color: colors.outline,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'SEC NIGERIA COMPLIANT & NDIC CUSTODY',
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.outline,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            'Secured under NDIC Escrow Custody Regulations & SEC Nigeria '
                'Digital Assets Guidelines. 256-bit HSM key management.',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.outline,
              fontSize: 9.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}