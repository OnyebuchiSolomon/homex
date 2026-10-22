import 'package:homex/res/app_strings.dart';
import 'package:homex/ui/global.dart';

class AccountVerifiedScreen extends StatefulWidget {
  const AccountVerifiedScreen({
    super.key,
    this.onClose,
    this.onExploreProperties,
    this.onCompleteKyc,
    this.onSetEscrowPin,
    this.onLinkSettlementBank,
    this.onUpgrade,
  });

  final VoidCallback? onClose;
  final VoidCallback? onExploreProperties;
  final VoidCallback? onCompleteKyc;
  final VoidCallback? onSetEscrowPin;
  final VoidCallback? onLinkSettlementBank;
  final VoidCallback? onUpgrade;

  @override
  State<AccountVerifiedScreen> createState() =>
      _AccountVerifiedScreenState();
}

class _AccountVerifiedScreenState
    extends State<AccountVerifiedScreen> {
  static const String _memberId = 'HX-NG-984210';

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  Future<void> _copyMemberId() async {
    await Clipboard.setData(
      const ClipboardData(text: _memberId),
    );

    if (!mounted) return;

    _showMessage('Member ID copied');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final roleMap = ModalRoute.of(context)?.settings.arguments as Map;
    final role = roleMap['role'] as Set<String>;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 448,
            ),
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      16,
                      20,
                      48,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [
                        _buildHeroSection(context),
                        const SizedBox(height: 24),
                        _buildAccountSnapshot(context),
                        const SizedBox(height: 20),
                        _buildNextSteps(context),
                        const SizedBox(height: 16),
                        _buildSecurityNote(context),
                        const SizedBox(height: 18),
                        _buildActions(context),
                        const SizedBox(height: 14),
                        _buildTrustFootnote(context),
                      ],
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

  // ============================================================
  // APP BAR
  // ============================================================

  Widget _buildAppBar(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Material(
      color: colors.surface.withValues(alpha: 0.96),
      elevation: 1,
      shadowColor: colors.shadow.withValues(alpha: 0.08),
      child: SizedBox(
        height: 64,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              Text(
                '${AppStrings.appName} ',
                style: textTheme.headlineSmall?.copyWith(
                 // color: colors.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainer,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: colors.outlineVariant,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        size: 13,
                        color: colors.onTertiaryContainer,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          'SEC • NDIC Partner',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                          textTheme.labelSmall?.copyWith(
                            color:
                            colors.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              _HeaderCloseButton(
                onPressed:
                widget.onClose ??
                        () => Navigator.of(context).maybePop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHeroSection(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 4),

        const _SuccessEmblem(),

        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: colors.outlineVariant,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withValues(
                  alpha: 0.05,
                ),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colors.onTertiaryContainer,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ACCOUNT ACTIVATED & ENCRYPTED',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onTertiaryContainer,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Welcome to HomeX!',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),

        const SizedBox(height: 6),

        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 340,
          ),
          child: Text(
            'Your identity has been verified and your secure '
                'real estate investor account is now active.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ACCOUNT SNAPSHOT
  // ============================================================

  Widget _buildAccountSnapshot(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _HomeXCard(
      colors: colors,
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        18,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          // Brand accent.
          Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              gradient: LinearGradient(
                colors: [
                  colors.primary,
                  colors.secondary,
                  colors.tertiaryContainer,
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Header.
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Account Holder',
                          style:
                          textTheme.labelSmall?.copyWith(
                            color: colors.outline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.shield,
                          size: 14,
                          color: colors.secondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Alexander Magnus',
                      style:
                      textTheme.headlineSmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'alexander.m@homex.ng',
                      style:
                      textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.surfaceContainerLowest,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colors.shadow.withValues(
                            alpha: 0.08,
                          ),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'AM',
                      style:
                      textTheme.labelLarge?.copyWith(
                        color:
                        colors.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NGN RESIDENT',
                    style:
                    textTheme.labelSmall?.copyWith(
                      color: colors.outline,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          Divider(
            height: 1,
            color: colors.surfaceContainer,
          ),

          const SizedBox(height: 14),

          // Member ID / phone.
          LayoutBuilder(
            builder: (context, constraints) {
              final narrow =
                  constraints.maxWidth < 320;

              if (narrow) {
                return Column(
                  children: [
                    _buildMemberId(context),
                    const SizedBox(height: 10),
                    _buildPhone(context),
                  ],
                );
              }

              return Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildMemberId(context),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildPhone(context),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 14),

          Divider(
            height: 1,
            color: colors.surfaceContainer,
          ),

          const SizedBox(height: 14),

          // Roles.
          Text(
            'ACTIVATED ROLE CAPACITIES',
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              fontSize: 10,
            ),
          ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _RoleChip(
                label: 'Buyer / Tenant',
                colors: colors,
              ),
              _RoleChip(
                label: 'Land Seller (Direct Owner)',
                colors: colors,
              ),
            ],
          ),

          const SizedBox(height: 14),

          Divider(
            height: 1,
            color: colors.surfaceContainer,
          ),

          const SizedBox(height: 14),

          // Tier status.
          LayoutBuilder(
            builder: (context, constraints) {
              final narrow =
                  constraints.maxWidth < 330;

              final tierInfo = Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.stars,
                    size: 19,
                    color: colors.secondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 7,
                          runSpacing: 5,
                          crossAxisAlignment:
                          WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Tier 1 Verified',
                              style: textTheme.labelMedium
                                  ?.copyWith(
                                // color: colors.outlineVariant,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                            Container(
                              padding:
                              const EdgeInsets
                                  .symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color:
                                colors.secondaryFixed,
                                borderRadius:
                                BorderRadius.circular(
                                  4,
                                ),
                              ),
                              child: Text(
                                'Active',
                                style: textTheme
                                    .labelSmall
                                    ?.copyWith(
                                  color:
                                  colors.onSecondaryFixed,
                                  fontWeight:
                                  FontWeight.w700,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '₦20,000,000 Starting Bidding Limit',
                          style: textTheme.labelSmall
                              ?.copyWith(
                            color:
                            colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              final upgrade = TextButton.icon(
                onPressed:
                widget.onUpgrade ??
                        () => _showMessage(
                      'Upgrade account tier',
                    ),
                style: TextButton.styleFrom(
                  foregroundColor: colors.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
                ),
                iconAlignment:
                IconAlignment.end,
                icon: const Icon(
                  Icons.chevron_right,
                  size: 15,
                ),
                label: const Text('Upgrade'),
              );

              if (narrow) {
                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,
                  children: [
                    tierInfo,
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: upgrade,
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(child: tierInfo),
                  upgrade,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMemberId(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            'Member ID',
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w500,
              fontSize: 10.5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  _memberId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                    letterSpacing: 0.1,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: _copyMemberId,
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Icon(
                    Icons.content_copy,
                    size: 16,
                    color: colors.outline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhone(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            'Verified Phone',
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w500,
              fontSize: 10.5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                size: 14,
                color: colors.onTertiaryContainer,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  '+234 803 ••• 4920',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NEXT STEPS
  // ============================================================

  Widget _buildNextSteps(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _HomeXCard(
      colors: colors,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Next Steps for Maximum Security',
                  style: textTheme.titleMedium?.copyWith(
                   // color: colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  borderRadius:
                  BorderRadius.circular(999),
                ),
                child: Text(
                  '1 of 3 Done',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _SecurityStep(
            colors: colors,
            textTheme: textTheme,
            icon: Icons.check,
            iconBackground: colors.tertiaryContainer,
            iconForeground: colors.tertiaryFixed,
            title: 'Phone & Email OTP Authentication',
            status: 'Completed',
            statusColor:
            colors.onTertiaryContainer,
            description:
            'Two-factor credentials bound to Nigerian '
                'phone & secure mailbox.',
            completed: true,
          ),
          const SizedBox(height: 16),

          _SecurityStep(
            colors: colors,
            textTheme: textTheme,
            icon: Icons.verified_user_outlined,
            iconBackground: colors.secondaryFixed,
            iconForeground:
            colors.onSecondaryFixed,
            title: 'Complete full kyc',
           status: 'Set Up Now',
            statusColor: colors.secondary,
            description:
            'Your credentials which relates to your selected role  ',
            completed: false,
            onTap: ()=>AppNavigator.pushAndStackNamed(AppRoutes.authRoleVerificationScreen),
          ),
          const SizedBox(height: 10),

          _SecurityStep(
            colors: colors,
            textTheme: textTheme,
            icon: Icons.pin,
            iconBackground: colors.secondaryFixed,
            iconForeground:
            colors.onSecondaryFixed,
            title: 'Set 6-Digit Escrow PIN',
            status: 'Set Up Now',
            statusColor: colors.secondary,
            description:
            'Protects high-value property locks, offers, '
                'and vault withdrawals.',
            onTap: ()=>AppNavigator.pushAndStackNamed(AppRoutes.authSetEscrowPinScreen),
          ),
          //onTap: ()=>AppNavigator.pushAndStackNamed(AppRoutes.authRoleVerificationScreen),
          const SizedBox(height: 10),

          _SecurityStep(
            colors: colors,
            textTheme: textTheme,
            icon: Icons.account_balance,
            iconBackground:
            colors.surfaceContainer,
            iconForeground: colors.onSurface,
            title: 'Link Settlement NUBAN Bank',
            status: 'Add Bank',
            statusColor: colors.outline,
            description:
            'Instant disbursement routing to GTBank, '
                'Access, Zenith, or standard CBN rails.',
            onTap:()=>AppNavigator.pushAndStackNamed(AppRoutes.authLinkSettlementBankScreen),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECURITY NOTE
  // ============================================================

  Widget _buildSecurityNote(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(
              Icons.verified,
              size: 20,
              //color: colors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  // TextSpan(
                  //   text:
                  //   '',
                  //   style: TextStyle(
                  //     color: colors.primary,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  const TextSpan(
                    text:
                    'Your property investments, titles, '
                        'and deposit commitments are safeguarded '
                        'under ${AppStrings.appName} electronic settlement rails.',
                  ),
                ],
              ),
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACTIONS
  // ============================================================

  Widget _buildActions(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 52,
          child: FilledButton(
            onPressed:
            widget.onExploreProperties ??
                    () => _showMessage(
                  'Opening verified properties',
                ),
            style: FilledButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              elevation: 2,
              side: BorderSide(
                color: colors.outlineVariant,
              ),
              shadowColor:
              colors.shadow.withValues(
                alpha: 0.18,
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Explore Verified Properties & Deals',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: colors.onPrimary,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 50,
          child: OutlinedButton(
            onPressed:
            widget.onCompleteKyc ??
                    () => _showMessage(
                  'Opening Full Profile & Tier 2 KYC',
                ),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              backgroundColor:
              colors.surfaceContainerLowest,
              side: BorderSide(
                color: colors.outlineVariant,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.badge_outlined,
                  size: 17,
                  color: colors.outline,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Complete Full Profile & Tier 2 KYC',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge?.copyWith(

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FOOTNOTE
  // ============================================================

  Widget _buildTrustFootnote(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock,
          size: 12,
          color: colors.outline,
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            '256-Bit Financial Grade Encryption • HomeX NG',
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w500,
              fontSize: 10.5,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SUCCESS EMBLEM
// ============================================================

class _SuccessEmblem extends StatelessWidget {
  const _SuccessEmblem();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: 112,
      height: 112,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring.
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              color: colors.tertiaryFixed.withValues(
                alpha: 0.18,
              ),
              shape: BoxShape.circle,
            ),
          ),

          // Middle ring.
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: colors.tertiaryFixedDim.withValues(
                alpha: 0.22,
              ),
              shape: BoxShape.circle,
            ),
          ),

          // Main shield circle.
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              shape: BoxShape.circle,
              border: Border.all(
                color: colors.onTertiaryContainer,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(
                    alpha: 0.10,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: colors.tertiaryContainer,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.verified_user,
                size: 36,
                //color: colors.tertiaryFixed,
              ),
            ),
          ),

          // Lock badge.
          Positioned(
            right: 1,
            bottom: 3,
            child: Container(
              width: 28,
              height: 28,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.shadow.withValues(
                      alpha: 0.08,
                    ),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.secondary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.lock,
                  size: 13,
                  color: colors.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME X CARD
// ============================================================

class _HomeXCard extends StatelessWidget {
  const _HomeXCard({
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
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(
              alpha: 0.045,
            ),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ============================================================
// HEADER CLOSE BUTTON
// ============================================================

class _HeaderCloseButton extends StatelessWidget {
  const _HeaderCloseButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return IconButton(
      onPressed: onPressed,
      tooltip: 'Close',
      icon: const Icon(
        Icons.close,
        size: 20,
      ),
      color: colors.onSurfaceVariant,
      style: IconButton.styleFrom(
        backgroundColor:
        colors.surfaceContainer,
        minimumSize: const Size(36, 36),
        maximumSize: const Size(36, 36),
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
      ),
    );
  }
}

// ============================================================
// ROLE CHIP
// ============================================================

class _RoleChip extends StatelessWidget {
  const _RoleChip({
    required this.label,
    required this.colors,
  });

  final String label;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colors.surfaceContainerHigh,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 13,
            color: colors.onTertiaryContainer,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECURITY STEP
// ============================================================

class _SecurityStep extends StatelessWidget {
  const _SecurityStep({
    required this.colors,
    required this.textTheme,
    required this.icon,
    required this.iconBackground,
    required this.iconForeground,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.description,
    this.completed = false,
    this.onTap,
  });

  final ColorScheme colors;
  final TextTheme textTheme;
  final IconData icon;
  final Color iconBackground;
  final Color iconForeground;
  final String title;
  final String status;
  final Color statusColor;
  final String description;
  final bool completed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: completed
            ? colors.surfaceContainerLow
            : colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: completed
              ? colors.surfaceContainer
              : colors.outlineVariant,
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 18,
              color: iconForeground,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final narrow =
                        constraints.maxWidth < 220;

                    final titleWidget = Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelLarge?.copyWith(
                       // color: colors.s,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    );

                    final statusWidget = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (completed)
                          Icon(
                            Icons.check_circle,
                            size: 13,
                            color: statusColor,
                          ),
                        if (completed)
                          const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            status,
                            maxLines: 1,
                            overflow:
                            TextOverflow.ellipsis,
                            style: textTheme.labelSmall
                                ?.copyWith(
                              color: statusColor,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                        if (!completed)
                          Icon(
                            Icons.chevron_right,
                            size: 15,
                            color: statusColor,
                          ),
                      ],
                    );

                    if (narrow) {
                      return Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          titleWidget,
                          const SizedBox(height: 4),
                          statusWidget,
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: titleWidget,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Align(
                            alignment:
                            Alignment.topRight,
                            child: statusWidget,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: textTheme.labelSmall?.copyWith(
                    color: completed
                        ? colors.outline
                        : colors.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: content,
      ),
    );
  }
}