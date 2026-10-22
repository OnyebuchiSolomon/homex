import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen>
    with SingleTickerProviderStateMixin {
  bool _faceIdEnabled = true;
  bool _escrowAlertsEnabled = true;

  late final AnimationController _animationController;

  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  double _hPad(BuildContext context) {
    final w = context.widthPx;

    if (w < 360) return 12;
    if (w < 400) return 16;

    return 20;
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.025),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
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

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final hPad = _hPad(context);

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(
              context,
              hPad,
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  hPad,
                  12,
                  hPad,
                  24,
                ),
                child: AnimatedBuilder(
                  animation: _animationController,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileCard(context),

                      const SizedBox(height: 16),

                      _buildCreateAccountBanner(context),

                      const SizedBox(height: 20),

                      _buildSectionHeader(
                        context,
                        'ACCOUNT VERIFICATION',
                        trailing: 'Highest Tier',
                      ),

                      const SizedBox(height: 8),

                      _buildVerificationGroup(context),

                      const SizedBox(height: 20),

                      _buildSectionHeader(
                        context,
                        'SECURITY & CREDENTIALS',
                      ),

                      const SizedBox(height: 8),

                      _buildSecurityGroup(context),

                      const SizedBox(height: 20),

                      _buildSectionHeader(
                        context,
                        'ESCROW & BANKING',
                      ),

                      const SizedBox(height: 8),

                      _buildEscrowGroup(context),

                      const SizedBox(height: 20),

                      _buildSectionHeader(
                        context,
                        'PREFERENCES',
                      ),

                      const SizedBox(height: 8),

                      _buildPreferencesGroup(context),

                      const SizedBox(height: 20),

                      _buildSectionHeader(
                        context,
                        'SUPPORT & CONCIERGE',
                      ),

                      const SizedBox(height: 8),

                      _buildSupportGroup(context),

                      const SizedBox(height: 20),

                      _buildSectionHeader(
                        context,
                        'ABOUT HOMEX',
                      ),

                      const SizedBox(height: 8),

                      _buildAboutGroup(context),

                      const SizedBox(height: 20),

                      _buildSectionHeader(
                        context,
                        'ACCOUNT CLOSURE & DATA PRIVACY',
                      ),

                      const SizedBox(height: 8),

                      _buildClosureGroup(context),

                      const SizedBox(height: 20),

                      _buildSignOutButton(context),

                      const SizedBox(height: 12),

                      Text(
                        'HomeX Real Estate Escrow Technologies Ltd. Regulated by NDIC & SEC Nigeria.',
                        textAlign: TextAlign.center,
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: colors.outline,
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
    );
  }

  // ===========================================================================
  // HEADER
  // ===========================================================================

  Widget _buildHeader(
      BuildContext context,
      double hPad,
      ) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScaleOnTap(
            onTap: () => Navigator.of(context).maybePop(),
            child: Icon(
              Icons.arrow_back,
              color: colors.onSurface,
            ),
          ),

          Text(
            'Settings',
            style: textTheme.headlineSmall?.copyWith(
              color: colors.onSurface,
            ),
          ),

          ScaleOnTap(
            onTap: () {},
            child: Icon(
              Icons.notifications,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PROFILE CARD
  // ===========================================================================

  Widget _buildProfileCard(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _AnimatedSection(
      delay: 0,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colors.outlineVariant.withValues(
              alpha: 0.4,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors.surfaceContainerHighest,
                            width: 2,
                          ),
                        ),
                        child: ImageView.networkCached(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDX-GtW3KZwQQlhfEuUoosFieY4qDDxTaGa5d-DfKV5w30xY51tgKXYMKs8nOtE8IrxUN6OqSp8hEAiuxcf0mAD22xajltJOaK2zHBCxukhWKy9DDBFjiKQ1hca6sQjyPx435aR4suC8hJ__raAuEfWSLAcW3Xh7S0WIT-HWbISwg5cDmm1_sD9gOf_IqVcqs1kPL6FpBJ4AetmEKRByr3g1cKu8f41lP27vawIY8p3Q65bFqjsXafN',
                          fit: BoxFit.cover,
                          errorWidget: Icon(
                            Icons.person,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLowest,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified,
                          size: 16,
                          color: colors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Alexander Magnus',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colors.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          ScaleOnTap(
                            onTap: () {
                              AppNavigator.pushAndStackNamed(
                                AppRoutes.editProfileScreen,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: colors.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: colors.outlineVariant.withValues(
                                    alpha: 0.4,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Edit',
                                    style: textTheme.labelSmall?.copyWith(
                                      color: colors.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Icon(
                                    Icons.edit,
                                    size: 12,
                                    color: colors.onSurface,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Text(
                        'alexander.magnus@homex.ng',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 6),

                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _pillBadge(
                            context,
                            icon: Icons.diamond,
                            label: 'Diamond Tier',
                            bg: colors.secondaryContainer,
                            fg: colors.onSecondaryContainer,
                          ),
                          _pillBadge(
                            context,
                            icon: Icons.shield,
                            label: '99.4% Trust',
                            bg: colors.tertiaryContainer,
                            fg: colors.onTertiaryContainer,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colors.outlineVariant.withValues(
                    alpha: 0.2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secured Portfolio Limit',
                          style: textTheme.labelSmall?.copyWith(
                            fontSize: 11,
                            color: colors.onSurfaceVariant,
                          ),
                        ),

                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '₦ 450,000,000.00',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: colors.outlineVariant.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: colors.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 6),

                        Text(
                          'Institutional Access',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onSurface,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PILL BADGE
  // ===========================================================================

  Widget _pillBadge(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color bg,
        required Color fg,
      }) {
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: fg,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              fontSize: 11,
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // CREATE ACCOUNT
  // ===========================================================================

  Widget _buildCreateAccountBanner(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _AnimatedSection(
      delay: 60,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colors.outlineVariant.withValues(
              alpha: 0.4,
            ),
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.secondaryContainer.withValues(
                      alpha: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.person_add,
                    color: colors.secondary,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Text(
                            'Create New Account / Join HomeX',
                            style: textTheme.bodyMedium?.copyWith(
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
                              color: colors.secondaryFixed,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'New',
                              style: textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                color: colors.onSecondaryFixed,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Register as a verified Buyer, Seller, Lawyer, or Real Estate Manager to unlock regulated escrow and direct deals.',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ScaleOnTap(
                    onTap: () {
                      AppNavigator.pushAndStackNamed(
                        AppRoutes.chooseYourRoleScreen,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create an Account',
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: colors.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                ScaleOnTap(
                  onTap: () {
                    AppNavigator.pushAndStackNamed(
                      AppRoutes.secureLoginScreen,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colors.outlineVariant.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    child: Text(
                      'Login >',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION HEADER
  // ===========================================================================

  Widget _buildSectionHeader(
      BuildContext context,
      String title, {
        String? trailing,
      }) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.labelSmall?.copyWith(
            fontSize: 11,
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),

        if (trailing != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: colors.secondaryContainer.withValues(
                alpha: 0.18,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              trailing,
              style: textTheme.labelSmall?.copyWith(
                fontSize: 10,
                //color: colors.surface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }

  // ===========================================================================
  // GROUP CARD
  // ===========================================================================

  Widget _groupCard(
      BuildContext context, {
        required List<Widget> children,
      }) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.outlineVariant.withValues(
            alpha: 0.3,
          ),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              Container(
                height: 1,
                color: colors.outlineVariant.withValues(
                  alpha: 0.2,
                ),
              ),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // SETTINGS ROW
  // ===========================================================================

  Widget _settingsRow(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        Color? iconBg,
        Color? iconFg,
        Widget? trailing,
        VoidCallback? onTap,
      }) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return ScaleOnTap(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg ?? colors.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 20,
                color: iconFg ?? colors.onSurface,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    subtitle,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            trailing ??
                Icon(
                  Icons.chevron_right,
                  color: colors.outlineVariant,
                ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // VERIFICATION
  // ===========================================================================

  Widget _buildVerificationGroup(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _AnimatedSection(
      delay: 120,
      child: _groupCard(
        context,
        children: [
          _settingsRow(
            context,
            onTap: () {
              AppNavigator.pushAndStackNamed(
                AppRoutes.identityKycScreen,
              );
            },
            icon: Icons.badge,
            title: 'Identity KYC',
            subtitle: 'BVN, NIN, Proof of Address & Biometrics',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: colors.onTertiaryContainer,
                ),
                const SizedBox(width: 4),
                Text(
                  'Verified',
                  style: textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    color: colors.onTertiaryContainer,
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

  // ===========================================================================
  // SECURITY
  // ===========================================================================

  Widget _buildSecurityGroup(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _AnimatedSection(
      delay: 180,
      child: _groupCard(
        context,
        children: [
          ScaleOnTap(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.face,
                      size: 20,
                      color: colors.onSurface,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Face ID & Biometrics',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Fast unlock and escrow clearance',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Switch(
                    value: _faceIdEnabled,
                    activeThumbColor: colors.primary,
                    onChanged: (value) {
                      setState(() {
                        _faceIdEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          _settingsRow(
            context,
            icon: Icons.verified_user_sharp,
            title: 'Two-Factor Authentication',
            subtitle: 'Hardware authenticator synced',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: colors.tertiaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Active',
                    style: textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: colors.onTertiaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(width: 4),

                Icon(
                  Icons.chevron_right,
                  color: colors.outlineVariant,
                ),
              ],
            ),
          ),

          _settingsRow(
            context,
            onTap: () {
              AppNavigator.pushAndStackNamed(
                AppRoutes.resetTransactionPinScreen,
              );
            },
            icon: Icons.dialpad,
            title: 'Transaction PIN',
            subtitle: '6-digit alphanumeric key configured',
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // ESCROW
  // ===========================================================================

  Widget _buildEscrowGroup(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _AnimatedSection(
      delay: 240,
      child: _groupCard(
        context,
        children: [
          _settingsRow(
            context,
            onTap: () {
              AppNavigator.pushAndStackNamed(
                AppRoutes.settlementBankAccountsScreen,
              );
            },
            icon: Icons.account_balance,
            title: 'Designated Settlement Bank',
            subtitle:
            'Zenith Bank PLC • 2088••••90 · PRIMARY ESCROW ACCOUNT',
          ),

          ScaleOnTap(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.campaign,
                      size: 20,
                      color: colors.onSurface,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Escrow Push Alerts',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Text(
                          'Real-time custody release notifications',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Switch(
                    value: _escrowAlertsEnabled,
                    activeThumbColor: colors.primary,
                    onChanged: (value) {
                      setState(() {
                        _escrowAlertsEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PREFERENCES
  // ===========================================================================

  Widget _buildPreferencesGroup(BuildContext context) {
    return _AnimatedSection(
      delay: 300,
      child: _groupCard(
        context,
        children: [
          _settingsRow(
            context,
            icon: Icons.notifications_active,
            title: 'Notification Channels',
            subtitle: 'WhatsApp, Email & In-App Alerts',
          ),

          _settingsRow(
            context,
            onTap: () {
              AppNavigator.pushAndStackNamed(
                AppRoutes.displayOptionsScreen,
              );
            },
            icon: Icons.palette,
            title: 'Display Options',
            subtitle: 'Currency view (₦ NGN), System Theme',
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SUPPORT
  // ===========================================================================

  Widget _buildSupportGroup(BuildContext context) {
    final colors = context.colors;

    return _AnimatedSection(
      delay: 360,
      child: _groupCard(
        context,
        children: [
          _settingsRow(
            context,
            icon: Icons.support_agent,
            title: 'Customer Service Concierge',
            subtitle: 'Dedicated Diamond advisor available 24/7',
            iconBg: colors.secondaryContainer.withValues(
              alpha: 0.2,
            ),
            iconFg: colors.secondary,
          ),

          _settingsRow(
            context,
            onTap: () {
              AppNavigator.pushAndStackNamed(
                AppRoutes.disputeCenterPage,
              );
            },
            icon: Icons.help,
            title: 'Dispute Resolution & Escrow Claims',
            subtitle:
            'Lagos Multi-Door Courthouse & SEC arbiter support',
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // ABOUT
  // ===========================================================================

  Widget _buildAboutGroup(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _AnimatedSection(
      delay: 420,
      child: _groupCard(
        context,
        children: [
          _settingsRow(
            context,
            icon: Icons.corporate_fare,
            title: 'About HomeX',
            subtitle:
            'Regulated direct-deal property marketplace & escrow custodian',
          ),

          _settingsRow(
            context,
            icon: Icons.gavel,
            title: 'Terms of Service & Escrow Regulations',
            subtitle:
            'SEC Nigeria licensed real estate partner rules',
          ),

          _settingsRow(
            context,
            icon: Icons.policy,
            title: 'Privacy Policy & NDPR Compliance',
            subtitle:
            'Nigeria Data Protection Regulation custody standards',
          ),

          Container(
            color: colors.surfaceContainerLow.withValues(
              alpha: 0.3,
            ),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.info,
                    size: 20,
                    color: colors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'App Version & Release Notes',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        'Version 4.12.8 (Build 8904 - Production Lagos)',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Up to date',
                    style: textTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
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

  // ===========================================================================
  // CLOSURE
  // ===========================================================================

  Widget _buildClosureGroup(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _AnimatedSection(
      delay: 480,
      child: _groupCard(
        context,
        children: [
          _settingsRow(
            context,
            icon: Icons.archive,
            title: 'Download Account Data Archive',
            subtitle:
            'Export transactions, title deeds, and escrow logs as an encrypted ZIP',
          ),

          ScaleOnTap(
            onTap: () {},
            child: Container(
              color: colors.errorContainer.withValues(
                alpha: 0.2,
              ),
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colors.errorContainer.withValues(
                        alpha: 0.4,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.delete_forever,
                      size: 20,
                      color: colors.error,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delete Account & Purge Data',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.error,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        Text(
                          'Permanently close account, de-link escrow vaults, and erase biometric data in compliance with NDPR',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    color: colors.error,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SIGN OUT
  // ===========================================================================

  Widget _buildSignOutButton(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return _AnimatedSection(
      delay: 540,
      child: ScaleOnTap(
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: colors.errorContainer.withValues(
              alpha: 0.4,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: colors.error.withValues(
                alpha: 0.2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                size: 18,
                color: colors.error,
              ),

              const SizedBox(width: 8),

              Flexible(
                child: Text(
                  'Sign Out Alexander Magnus',
                  textAlign: TextAlign.center,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.error,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// ANIMATED SECTION
// ============================================================================

class _AnimatedSection extends StatefulWidget {
  final Widget child;
  final int delay;

  const _AnimatedSection({
    required this.child,
    this.delay = 0,
  });

  @override
  State<_AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<_AnimatedSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacity;
  late final Animation<Offset> _position;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 450,
      ),
    );

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _position = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    Future.delayed(
      Duration(
        milliseconds: widget.delay,
      ),
          () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _position,
        child: widget.child,
      ),
    );
  }
}