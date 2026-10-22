import 'package:homex/ui/global.dart';

class AuthRoleVerificationScreen extends StatefulWidget {
  const AuthRoleVerificationScreen({
    super.key,
    this.onBack,
    this.onHelp,
    this.onSubmit,
    this.onSaveDraft,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final VoidCallback? onSubmit;
  final VoidCallback? onSaveDraft;

  @override
  State<AuthRoleVerificationScreen> createState() =>
      _AuthRoleVerificationScreenState();
}

class _AuthRoleVerificationScreenState
    extends State<AuthRoleVerificationScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _progressController;

  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _progressAnimation;

  bool _isEstateManager = true;
  bool _isSubmitting = false;

  String _entityType = 'Licensed Brokerage';
  String _estateBank = 'Guaranty Trust Bank (GTBank)';
  String _legalBank = 'First Bank of Nigeria';

  String _portfolioUnits = '6 - 20 Multi-Family Units';
  String _notaryStatus =
      'Commissioned Notary Public (Supreme Court Appointment)';

  final Set<String> _estateJurisdictions = {
    'Ikoyi',
    'Victoria Island',
  };

  final Set<String> _legalCompetencies = {
    "Title Perfection & Governor's Consent",
    'Deed of Conveyance',
  };

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutCubic,
      ),
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: 0.6,
    ).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeOutCubic,
      ),
    );

    _entranceController.forward();

    Future<void>.delayed(const Duration(milliseconds: 180), () {
      if (mounted) {
        _progressController.forward();
      }
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _switchRole(bool estateManager) {
    if (_isEstateManager == estateManager) return;

    setState(() {
      _isEstateManager = estateManager;
    });
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 900),
    );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    widget.onSubmit?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildTopBar(
                  colors,
                  textTheme,
                ),
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildBody(
                        colors,
                        textTheme,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomNavigation(colors, textTheme),
        ],
      ),
    );
  }

  Widget _buildTopBar(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            _AnimatedIconButton(
              icon: Icons.arrow_back_rounded,
              tooltip: 'Go Back',
              onTap: widget.onBack,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.15),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  key: ValueKey(_isEstateManager),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Identity Verification',
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.1,
                      ),
                    ),
                    Text(
                      _isEstateManager
                          ? 'LASRERA & Corporate Accreditation'
                          : 'NBA & Supreme Court Legal Accreditation',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _AnimatedIconButton(
              icon: Icons.help_outline_rounded,
              tooltip: 'Support & Help',
              onTap: widget.onHelp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth >= 600 ? 24.0 : 16.0;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            12,
            horizontalPadding,
            112,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 448,
              ),
              child: Column(
                children: [
                  _buildProfileCard(colors, textTheme),
                  const SizedBox(height: 12),
                  _buildRoleSelector(colors, textTheme),
                  const SizedBox(height: 12),
                  _buildHeroBanner(colors, textTheme),
                  const SizedBox(height: 12),
                  _buildProgress(colors, textTheme),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 420),
                    reverseDuration: const Duration(milliseconds: 260),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(0, 0.025),
                        end: Offset.zero,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: _isEstateManager
                        ? _buildEstateManagerDossier(
                      colors,
                      textTheme,
                    )
                        : _buildLegalCounselDossier(
                      colors,
                      textTheme,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildComplianceNotice(colors, textTheme),
                  const SizedBox(height: 12),
                  _buildActions(colors, textTheme),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileCard(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _AnimatedCard(
      delay: const Duration(milliseconds: 50),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(colors),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.surface,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.shadow.withValues(alpha: 0.08),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'AM',
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  right: -3,
                  bottom: -3,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: colors.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.surface,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.verified_rounded,
                      size: 12,
                      color: colors.onSecondary,
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
                      Flexible(
                        child: Text(
                          'Alexander Magnus',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelLarge?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
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
                          'Tier 1',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    child: Row(
                      key: ValueKey(_isEstateManager),
                      children: [
                        Text(
                          'Upgrade in Progress: ',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            _isEstateManager
                                ? 'Tier 2 Estate Manager'
                                : 'Tier 2 Legal Counsel',
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _StatusBadge(
              text: 'Pending Audit',
              colors: colors,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSelector(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _AnimatedCard(
      delay: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              'SELECTED OPERATING LICENSE',
              style: textTheme.labelSmall?.copyWith(
                color: colors.outline,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                fontSize: 10,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colors.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _RoleTab(
                    selected: _isEstateManager,
                    icon: Icons.apartment_rounded,
                    title: 'Estate Manager',
                    colors: colors,
                    textTheme: textTheme,
                    onTap: () => _switchRole(true),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _RoleTab(
                    selected: !_isEstateManager,
                    icon: Icons.gavel_rounded,
                    title: 'Legal Counsel',
                    colors: colors,
                    textTheme: textTheme,
                    onTap: () => _switchRole(false),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 360),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.985,
              end: 1,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey(_isEstateManager),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -28,
              bottom: -28,
              child: IgnorePointer(
                child: Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.secondary.withValues(alpha: 0.10),
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _isEstateManager
                      ? Icons.verified_user_rounded
                      : Icons.gavel_rounded,
                  color: colors.secondaryContainer,
                  size: 21,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isEstateManager
                            ? 'Institutional Corporate Clearance'
                            : 'Accredited Legal Counsel Clearance',
                        style: textTheme.labelMedium?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          text: _isEstateManager
                              ? 'Unlock Corporate Portfolio Management, '
                              'Multi-Unit Direct Tenancy Escrow, and '
                              'Verified Broker Badge up to '
                              : 'Unlock Title Perfection Clearance, '
                              'Solicitor Trust Account Escrow, and '
                              'Authorized Legal Conveyancer Badge up to ',
                          children: [
                            TextSpan(
                              text: _isEstateManager
                                  ? '₦500,000,000'
                                  : '₦1,000,000,000',
                              style: TextStyle(
                                color: colors.onPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(
                              text: ' transaction limits.',
                            ),
                          ],
                        ),
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.primaryFixedDim,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        final percentage =
        (_progressAnimation.value * 100).round();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  Text(
                    'Step 2 of 4',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '•',
                    style: TextStyle(
                      color: colors.outlineVariant,
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Text(
                      _isEstateManager
                          ? 'Compliance Dossier'
                          : 'Legal Dossier',
                      key: ValueKey(_isEstateManager),
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$percentage% Complete',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: _progressAnimation.value,
                minHeight: 6,
                backgroundColor: colors.surfaceContainerHigh,
                valueColor: AlwaysStoppedAnimation<Color>(
                  colors.secondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEstateManagerDossier(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      key: const ValueKey('estate-manager'),
      children: [
        _SectionCard(
          number: '1',
          title: 'Corporate Affairs Commission (CAC)',
          badge: 'Live API Sync',
          badgeColor: colors.tertiaryFixed,
          badgeTextColor: colors.onTertiaryFixed,
          colors: colors,
          textTheme: textTheme,
          children: [
            _FieldLabel(
              'Operating Entity Type',
              colors,
              textTheme,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _ChoiceCard(
                    title: 'Licensed Brokerage',
                    subtitle: 'Registered firm / LTD',
                    selected: _entityType == 'Licensed Brokerage',
                    colors: colors,
                    textTheme: textTheme,
                    onTap: () {
                      setState(() {
                        _entityType = 'Licensed Brokerage';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ChoiceCard(
                    title: 'Independent Facility',
                    subtitle: 'Property Manager',
                    selected: _entityType == 'Independent Facility',
                    colors: colors,
                    textTheme: textTheme,
                    onTap: () {
                      setState(() {
                        _entityType = 'Independent Facility';
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _InputField(
              label: 'CAC Registration Number',
              value: 'RC-449102-LA',
              icon: Icons.badge_outlined,
              trailing: 'ACTIVE REG',
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 12),
            _InputField(
              label: 'Registered Legal Entity Name',
              value: 'Magnus Crestline Properties & Facility Ltd',
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 14),
            _DocumentTile(
              label: 'Certificate of Incorporation (CAC)',
              fileName: 'CAC_Certificate_Incorporation.pdf',
              meta: '2.4 MB • Uploaded & SHA-256 Encrypted',
              colors: colors,
              textTheme: textTheme,
              onReplace: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          number: '2',
          title: 'Regulatory Real Estate Accreditation',
          badge: 'Lagos State Mandate',
          badgeColor: colors.secondaryFixed,
          badgeTextColor: colors.onSecondaryFixed,
          colors: colors,
          textTheme: textTheme,
          children: [
            _InputField(
              label: 'LASRERA Practitioner ID / REAN License',
              value: 'LASRERA/BRK/2023/8892',
              icon: Icons.verified_outlined,
              accent: true,
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 5),
            _HelperText(
              icon: Icons.bolt_rounded,
              text:
              'Connected directly to Lagos State Real Estate Regulatory Authority portal.',
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 14),
            _DocumentTile(
              label: 'Practicing Certificate or Annual Renewal Stamp',
              fileName: 'LASRERA_Current_License_2024.jpg',
              meta: '1.1 MB • Validated until Dec 2025',
              colors: colors,
              textTheme: textTheme,
              verified: true,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          number: '3',
          title: 'Operating Office & Commercial Premises',
          icon: Icons.location_on_outlined,
          colors: colors,
          textTheme: textTheme,
          children: [
            _InputField(
              label: 'Registered Office Address',
              value:
              'Suite 402, Landmark Towers, Water Corporation Drive, Victoria Island, Lagos',
              maxLines: 2,
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 14),
            _UploadBox(
              title: 'Tap to upload Eko DisCo Bill / Lease Agreement',
              subtitle: 'PDF, PNG, JPG (Must be less than 90 days old)',
              colors: colors,
              textTheme: textTheme,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          number: '4',
          title: 'Corporate Escrow Settlement (NUBAN)',
          badge: '0% Commission Escrow',
          badgeColor: colors.secondaryContainer.withValues(alpha: 0.18),
          badgeTextColor: colors.secondary,
          colors: colors,
          textTheme: textTheme,
          children: [
            Text(
              'Direct settlement destination for tenant rental tranches '
                  'and management fees. Verified name must match CAC registration.',
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            _DropdownField(
              label: 'Commercial Bank',
              value: _estateBank,
              items: const [
                'Guaranty Trust Bank (GTBank)',
                'Access Bank Plc',
                'Zenith Bank Plc',
                'Stanbic IBTC Bank',
              ],
              colors: colors,
              textTheme: textTheme,
              onChanged: (value) {
                if (value == null) return;
                setState(() => _estateBank = value);
              },
            ),
            const SizedBox(height: 12),
            _InputField(
              label: 'NUBAN Corporate Account Number (10 Digits)',
              value: '0429188204',
              trailing: '✓ Name Match',
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 10),
            _AccountName(
              name: 'MAGNUS CRESTLINE PROPERTIES & FACILITY LTD',
              colors: colors,
              textTheme: textTheme,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          number: '5',
          title: 'Active Portfolio Baseline (Optional)',
          badge: 'Quick Start',
          badgeColor: colors.outlineVariant,
          badgeTextColor: colors.outline,
          colors: colors,
          textTheme: textTheme,
          children: [
            _DropdownField(
              label: 'Units Currently Under Direct Management',
              value: _portfolioUnits,
              items: const [
                '1 - 5 Residential / Commercial Units',
                '6 - 20 Multi-Family Units',
                '20+ Large Commercial & Residential Portfolios',
              ],
              colors: colors,
              textTheme: textTheme,
              onChanged: (value) {
                if (value == null) return;
                setState(() => _portfolioUnits = value);
              },
            ),
            const SizedBox(height: 14),
            _FieldLabel(
              'Core Management Jurisdictions',
              colors,
              textTheme,
            ),
            const SizedBox(height: 7),
            _buildChips(
              colors,
              textTheme,
              _estateJurisdictions,
              const [
                'Lekki Phase 1',
                'Maitama, Abuja',
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegalCounselDossier(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      key: const ValueKey('legal-counsel'),
      children: [
        _SectionCard(
          number: '1',
          title: 'Nigerian Bar Association (NBA) Bar Roll',
          badge: 'Supreme Court Mandate',
          badgeColor: colors.secondaryFixed,
          badgeTextColor: colors.onSecondaryFixed,
          colors: colors,
          textTheme: textTheme,
          children: [
            _InputField(
              label: 'Supreme Court Enrolment Number (SCN)',
              value: 'SCN-084920',
              icon: Icons.verified_outlined,
              trailing: 'ACTIVE BAR',
              accent: true,
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 5),
            _HelperText(
              icon: Icons.bolt_rounded,
              text:
              'Synced with Supreme Court of Nigeria & NBA National Database.',
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 14),
            _DocumentTile(
              label: 'Annual Practicing Seal & NBA Stamp',
              fileName: 'NBA_Practicing_Stamp_2024.jpg',
              meta: '1.8 MB • Verified Valid 2024/2025',
              colors: colors,
              textTheme: textTheme,
              verified: true,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          number: '2',
          title: 'Law Chambers CAC Accreditation',
          badge: 'Live API Sync',
          badgeColor: colors.tertiaryFixed,
          badgeTextColor: colors.onTertiaryFixed,
          colors: colors,
          textTheme: textTheme,
          children: [
            _InputField(
              label: 'Business Name Registration Number (BN)',
              value: 'BN-2940182',
              icon: Icons.badge_outlined,
              trailing: 'ACTIVE REG',
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 12),
            _InputField(
              label: 'Registered Legal Chambers Name',
              value: 'Magnus & Partners Legal Practitioners',
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 14),
            _DocumentTile(
              label: 'CAC Business Name Certificate',
              fileName: 'BN_Certificate_Magnus_Partners.pdf',
              meta: '1.9 MB • Uploaded & Verified',
              colors: colors,
              textTheme: textTheme,
              onReplace: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          number: '3',
          title: 'Physical Chambers Address',
          icon: Icons.gavel_rounded,
          colors: colors,
          textTheme: textTheme,
          children: [
            _InputField(
              label: 'Chambers Practice Address',
              value:
              '45 Broad Street, Legal Chambers District, Lagos Island, Lagos',
              maxLines: 2,
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 14),
            _UploadBox(
              title: 'Tap to upload Chambers Tenancy / Law Utility Bill',
              subtitle: 'PDF, PNG, JPG (Must be less than 90 days old)',
              colors: colors,
              textTheme: textTheme,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          number: '4',
          title: 'Designated Solicitor Trust Account (NUBAN)',
          badge: 'Client Escrow Trust',
          badgeColor: colors.secondaryContainer.withValues(alpha: 0.18),
          badgeTextColor: colors.secondary,
          colors: colors,
          textTheme: textTheme,
          children: [
            Text(
              'Dedicated client funds account compliant with NBA Rules '
                  'of Professional Conduct (Rule 23 - Client Property & Trust).',
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            _DropdownField(
              label: 'Commercial Bank',
              value: _legalBank,
              items: const [
                'First Bank of Nigeria',
                'Guaranty Trust Bank (GTBank)',
                'Zenith Bank Plc',
                'Stanbic IBTC Bank',
              ],
              colors: colors,
              textTheme: textTheme,
              onChanged: (value) {
                if (value == null) return;
                setState(() => _legalBank = value);
              },
            ),
            const SizedBox(height: 12),
            _InputField(
              label: 'NUBAN Client Trust Account (10 Digits)',
              value: '3108924510',
              trailing: '✓ Trust Matched',
              colors: colors,
              textTheme: textTheme,
            ),
            const SizedBox(height: 10),
            _AccountName(
              name: 'MAGNUS & PARTNERS (CLIENTS TRUST ACCOUNT)',
              colors: colors,
              textTheme: textTheme,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          number: '5',
          title: 'Legal Practice Specialties',
          badge: 'Practice Profile',
          badgeColor: colors.outlineVariant,
          badgeTextColor: colors.outline,
          colors: colors,
          textTheme: textTheme,
          children: [
            _DropdownField(
              label: 'Notary Public Commission Status',
              value: _notaryStatus,
              items: const [
                'Commissioned Notary Public (Supreme Court Appointment)',
                'Advocate & Solicitor (Non-Notary)',
                'Senior Advocate of Nigeria (SAN)',
              ],
              colors: colors,
              textTheme: textTheme,
              onChanged: (value) {
                if (value == null) return;
                setState(() => _notaryStatus = value);
              },
            ),
            const SizedBox(height: 14),
            _FieldLabel(
              'Property Law Competencies',
              colors,
              textTheme,
            ),
            const SizedBox(height: 7),
            _buildChips(
              colors,
              textTheme,
              _legalCompetencies,
              const [
                'Probate & Estate Administration',
                'Real Estate Due Diligence Search',
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChips(
      ColorScheme colors,
      TextTheme textTheme,
      Set<String> selected,
      List<String> available,
      ) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        ...selected.map(
              (item) => _SelectedChip(
            label: item,
            colors: colors,
            textTheme: textTheme,
            onRemove: () {
              setState(() {
                selected.remove(item);
              });
            },
          ),
        ),
        ...available.map(
              (item) => _AddChip(
            label: item,
            colors: colors,
            textTheme: textTheme,
            onTap: () {
              setState(() {
                selected.add(item);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceNotice(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _AnimatedCard(
      delay: const Duration(milliseconds: 350),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
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
              Icons.policy_outlined,
              color: colors.outline,
              size: 19,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                child: Text.rich(
                  key: ValueKey(_isEstateManager),
                  TextSpan(

                    children: [
                      TextSpan(
                        text: _isEstateManager
                            ? 'Verification conducted in full alignment with the '
                            : 'Verification conducted under the mandate of the ',
                      ),
                      TextSpan(
                        text: _isEstateManager
                            ? 'Lagos State Real Estate Regulatory Authority (LASRERA)'
                            : 'Supreme Court of Nigeria',
                        style: TextStyle(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: _isEstateManager
                            ? ', '
                            : ', Nigerian Bar Association (NBA) Rules of Professional Conduct, and ',
                      ),
                      if (_isEstateManager)
                        TextSpan(
                          text: 'CAC corporate compliance, and SEC Nigeria '
                              'fintech guidelines.',
                          style: TextStyle(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      else
                        TextSpan(
                          text: 'CAC Business Name registry.',
                          style: TextStyle(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      const TextSpan(
                        text: ' Identity records remain encrypted.',
                      ),
                    ],
                  ),
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.55,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    final submitText = _isEstateManager
        ? 'Submit Estate Manager Credentials for Audit'
        : 'Submit Legal Counsel Credentials for Audit';

    return Column(
      children: [
        _PressableButton(
          onTap: _submit,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: colors.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: _isSubmitting
                  ? SizedBox(
                key: const ValueKey('loading'),
                height: 18,
                child: Center(
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(
                        colors.onPrimary,
                      ),
                    ),
                  ),
                ),
              )
                  : Row(
                key: ValueKey(submitText),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    color: colors.onPrimary,
                    size: 17,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      submitText,
                      textAlign: TextAlign.center,
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: colors.onPrimary,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        _PressableButton(
          onTap: widget.onSaveDraft,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: colors.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Text(
              'Save Draft & Continue Later',
              textAlign: TextAlign.center,
              style: textTheme.labelMedium?.copyWith(
               // color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            border: Border(
              top: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            children: [
              _BottomNavItem(
                icon: Icons.real_estate_agent_outlined,
                label: 'Properties',
                colors: colors,
                textTheme: textTheme,
              ),
              _BottomNavItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Portfolio',
                colors: colors,
                textTheme: textTheme,
              ),
              _BottomNavItem(
                icon: Icons.verified_user_rounded,
                label: 'Verify',
                active: true,
                colors: colors,
                textTheme: textTheme,
              ),
              _BottomNavItem(
                icon: Icons.person_outline_rounded,
                label: 'Account',
                colors: colors,
                textTheme: textTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(ColorScheme colors) {
    return BoxDecoration(
      color: colors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: colors.outlineVariant.withValues(alpha: 0.3),
      ),
      boxShadow: [
        BoxShadow(
          color: colors.shadow.withValues(alpha: 0.035),
          blurRadius: 7,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

// ============================================================
// ROLE TAB
// ============================================================

class _RoleTab extends StatelessWidget {
  const _RoleTab({
    required this.selected,
    required this.icon,
    required this.title,
    required this.colors,
    required this.textTheme,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String title;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected
                ? colors.surfaceContainerLowest
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? colors.outlineVariant.withValues(alpha: 0.4)
                  : Colors.transparent,
            ),
            boxShadow: selected
                ? [
              BoxShadow(
                color: colors.shadow.withValues(alpha: 0.06),
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: Icon(
                  icon,
                  key: ValueKey('$icon-$selected'),
                  size: 17,
                  color: selected
                      ? colors.secondary
                      : colors.outline,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall?.copyWith(
                    color: selected
                        ? colors.secondary
                        : colors.onSurfaceVariant,
                    fontWeight:
                    selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION CARD
// ============================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.number,
    required this.title,
    required this.colors,
    required this.textTheme,
    required this.children,
    this.badge,
    this.badgeColor,
    this.badgeTextColor,
    this.icon,
  });

  final String number;
  final String title;
  final String? badge;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final IconData? icon;
  final ColorScheme colors;
  final TextTheme textTheme;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return _AnimatedCard(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colors.outlineVariant.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.035),
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    number,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
                if (icon != null)
                  Icon(
                    icon,
                    size: 17,
                    color: colors.outline,
                  ),
                if (badge != null) ...[
                  const SizedBox(width: 6),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badge!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall?.copyWith(
                          //color: badgeTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 11),
            Divider(
              height: 1,
              color: colors.outlineVariant.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}

// ============================================================
// INPUT
// ============================================================

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.value,
    required this.colors,
    required this.textTheme,
    this.icon,
    this.trailing,
    this.accent = false,
    this.maxLines = 1,
  });

  final String label;
  final String value;
  final ColorScheme colors;
  final TextTheme textTheme;
  final IconData? icon;
  final String? trailing;
  final bool accent;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _FieldLabel(
                label,
                colors,
                textTheme,
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: textTheme.labelSmall?.copyWith(
                 // color: colors.onTertiary,
                  fontWeight: FontWeight.w700,
                  fontSize: 9,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: icon == null ? 12 : 9,
            right: 12,
            top: maxLines > 1 ? 10 : 9,
            bottom: maxLines > 1 ? 10 : 9,
          ),
          decoration: BoxDecoration(
            color: accent
                ? colors.surfaceContainerLowest
                : colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: accent
                  ? colors.secondary
                  : colors.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 17,
                  color: colors.outline,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  value,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                    height: maxLines > 1 ? 1.4 : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(
      this.text,
      this.colors,
      this.textTheme,
      );

  final String text;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textTheme.labelSmall?.copyWith(
        color: colors.onSurfaceVariant,
        fontWeight: FontWeight.w600,
        fontSize: 10.5,
      ),
    );
  }
}

// ============================================================
// DOCUMENT
// ============================================================

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({
    required this.label,
    required this.fileName,
    required this.meta,
    required this.colors,
    required this.textTheme,
    this.onReplace,
    this.verified = false,
  });

  final String label;
  final String fileName;
  final String meta;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback? onReplace;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label, colors, textTheme),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(
                  Icons.picture_as_pdf_outlined,
                  size: 16,
                  color: colors.onPrimary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      meta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              if (verified)
                Icon(
                  Icons.check_circle_rounded,
                  size: 17,
                  color: colors.tertiary,
                )
              else if (onReplace != null)
                GestureDetector(
                  onTap: onReplace,
                  child: Text(
                    'Replace',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// UPLOAD
// ============================================================

class _UploadBox extends StatelessWidget {
  const _UploadBox({
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.textTheme,
  });

  final String title;
  final String subtitle;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.65),
          width: 1.4,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.upload_file_rounded,
            color: colors.outline,
            size: 22,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DROPDOWN
// ============================================================

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.colors,
    required this.textTheme,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final ColorScheme colors;
  final TextTheme textTheme;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label, colors, textTheme),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: colors.outline,
            size: 19,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: colors.surfaceContainerLow,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 9,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
          ),
          style: textTheme.labelMedium?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w500,
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// ============================================================
// ACCOUNT NAME
// ============================================================

class _AccountName extends StatelessWidget {
  const _AccountName({
    required this.name,
    required this.colors,
    required this.textTheme,
  });

  final String name;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.account_balance_outlined,
            color: colors.secondary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CHOICE CARD
// ============================================================

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.colors,
    required this.textTheme,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected
              ? colors.surfaceContainerLow
              : colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? colors.secondary
                : colors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 17,
              height: 17,
              margin: const EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? colors.secondary
                      : colors.outline,
                  width: 1.5,
                ),
              ),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 180),
                scale: selected ? 1 : 0,
                child: Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: colors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontSize: 9,
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
}

// ============================================================
// CHIPS
// ============================================================

class _SelectedChip extends StatelessWidget {
  const _SelectedChip({
    required this.label,
    required this.colors,
    required this.textTheme,
    required this.onRemove,
  });

  final String label;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: GestureDetector(
        onTap: onRemove,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.close_rounded,
                size: 12,
                color: colors.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddChip extends StatelessWidget {
  const _AddChip({
    required this.label,
    required this.colors,
    required this.textTheme,
    required this.onTap,
  });

  final String label;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colors.outlineVariant.withValues(alpha: 0.6),
          ),
        ),
        child: Text(
          '+ $label',
          style: textTheme.labelSmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// STATUS BADGE
// ============================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.text,
    required this.colors,
    required this.textTheme,
  });

  final String text;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: colors.secondaryFixed,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: textTheme.labelSmall?.copyWith(
          color: colors.onSecondaryFixed,
          fontWeight: FontWeight.w700,
          fontSize: 9,
        ),
      ),
    );
  }
}

// ============================================================
// HELPER TEXT
// ============================================================

class _HelperText extends StatelessWidget {
  const _HelperText({
    required this.icon,
    required this.text,
    required this.colors,
    required this.textTheme,
  });

  final IconData icon;
  final String text;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 13,
          color: colors.tertiary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontSize: 9,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// ANIMATED CARD
// ============================================================

class _AnimatedCard extends StatefulWidget {
  const _AnimatedCard({
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    Future<void>.delayed(widget.delay, () {
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
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.025),
          end: Offset.zero,
        ).animate(animation),
        child: widget.child,
      ),
    );
  }
}

// ============================================================
// PRESSABLE BUTTON
// ============================================================

class _PressableButton extends StatefulWidget {
  const _PressableButton({
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap == null
          ? null
          : (_) {
        setState(() => _pressed = true);
      },
      onTapUp: widget.onTap == null
          ? null
          : (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: widget.onTap == null
          ? null
          : () {
        setState(() => _pressed = false);
      },
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

// ============================================================
// TOP ICON BUTTON
// ============================================================

class _AnimatedIconButton extends StatefulWidget {
  const _AnimatedIconButton({
    required this.icon,
    required this.tooltip,
    this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  State<_AnimatedIconButton> createState() =>
      _AnimatedIconButtonState();
}

class _AnimatedIconButtonState
    extends State<_AnimatedIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      button: true,
      label: widget.tooltip,
      child: GestureDetector(
        onTapDown: widget.onTap == null
            ? null
            : (_) => setState(() => _pressed = true),
        onTapCancel: widget.onTap == null
            ? null
            : () => setState(() => _pressed = false),
        onTapUp: widget.onTap == null
            ? null
            : (_) {
          setState(() => _pressed = false);
          widget.onTap?.call();
        },
        child: AnimatedScale(
          scale: _pressed ? 0.90 : 1,
          duration: const Duration(milliseconds: 100),
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: Icon(
                widget.icon,
                size: 23,
                color: colors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// BOTTOM NAVIGATION
// ============================================================

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.colors,
    required this.textTheme,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final ColorScheme colors;
  final TextTheme textTheme;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? colors.secondary
        : colors.onSurfaceVariant;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                key: ValueKey('$icon-$active'),
                size: 21,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 9.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}