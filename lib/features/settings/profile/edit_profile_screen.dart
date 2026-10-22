import 'package:homex/res/app_strings.dart';
import 'package:homex/ui/global.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    this.onBack,
    this.onSave,
    this.onCancel,
    this.onUpdatePhone,
    this.onChangePhoto,
    this.onRemovePhoto,
    this.onPortfolio,
    this.onExplore,
    this.onActivity,
    this.onProfile,
  });

  final VoidCallback? onBack;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;
  final VoidCallback? onUpdatePhone;
  final VoidCallback? onChangePhoto;
  final VoidCallback? onRemovePhoto;

  final VoidCallback? onPortfolio;
  final VoidCallback? onExplore;
  final VoidCallback? onActivity;
  final VoidCallback? onProfile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  late final TextEditingController _displayNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _entityController;
  late final TextEditingController _jurisdictionController;
  late final TextEditingController _mandateController;

  bool _diamondBadge = true;
  bool _escrowScore = true;
  bool _escrowVolume = false;

  bool _isSaving = false;
  bool _showSavedMessage = false;

  static const String _profileImage =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuA1xZxDaSnYpe87Bn8f2URlmoVtekLimqQtqQSWW9UESB01-y2kgOSZqafrA63c61JnwLhufNsPxidiCgrOYoDEchk9-T6Q1N78v3sNHRA_dhkJIx7epPS39b_zw-qOgTprBiusIn8HHPAPyOfZPXjS0ARGxJ9X8YHAwz1S4mCq1aJTF3zdsYJZRTHg19elKHJT7RHv4kVjXmShrf-D89akmSht5bN7et1-ZlWA6f_14ZrtjC9JVRCu';

  @override
  void initState() {
    super.initState();

    _displayNameController = TextEditingController(
      text: 'Alexander Magnus (Principal Partner)',
    );

    _emailController = TextEditingController(
      text: 'alexander.magnus@homex.ng',
    );

    _entityController = TextEditingController(
      text: 'Magnus Capital & Trust SPV',
    );

    _jurisdictionController = TextEditingController(
      text: 'Ikoyi, Lagos State, Nigeria',
    );

    _mandateController = TextEditingController(
      text:
      'Institutional private placement, premium commercial paper & prime residential property portfolios across Lagos (Ikoyi, Lekki Phase 1) and Abuja FCT.',
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: AppAnimations.enter,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.012),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.enter,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _entityController.dispose();
    _jurisdictionController.dispose();
    _mandateController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 450));

    if (!mounted) return;

    setState(() {
      _isSaving = false;
      _showSavedMessage = true;
    });

    widget.onSave?.call();

    await Future<void>.delayed(const Duration(milliseconds: 2200));

    if (!mounted) return;

    setState(() {
      _showSavedMessage = false;
    });
  }

  void _handleBack() {
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }

    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth < 360 ? 14.0 : 16.0;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildTopBar(colors),

                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              20,
                              horizontalPadding,
                              96,
                            ),
                            child: Column(
                              children: [
                                _buildTrustBanner(colors),
                                const SizedBox(height: 24),

                                _buildProfilePhotoCard(colors),
                                const SizedBox(height: 24),

                                _buildStatutoryCard(colors),
                                const SizedBox(height: 24),

                                _buildEditableProfileCard(colors),
                                const SizedBox(height: 24),

                                _buildPrivacyCard(colors),
                                const SizedBox(height: 24),

                                _buildBottomActions(colors),
                                const SizedBox(height: 10),

                                _buildComplianceFooter(colors),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


                _buildSaveToast(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(ColorScheme colors) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest.withValues(alpha: 0.96),
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            _CircleIconButton(
              icon: Icons.arrow_back,
              onTap: _handleBack,
            ),
            const SizedBox(width: 8),

            Expanded(
              child: Text(
                'Edit Profile',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: 18,
                  height: 1.2,
                 // color: colors.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
            ),

            const SizedBox(width: 8),

            _SmallPrimaryButton(
              label: 'Save',
              isLoading: _isSaving,
              onTap: _saveProfile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustBanner(ColorScheme colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 2),
            color: Color(0x10000000),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.verified,
              size: 21,
              color: colors.onSecondaryContainer,
            ),
          ),

          const SizedBox(width: 12),

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
                      '${AppStrings.appName} Verification',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colors.secondaryFixed,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Tier 3',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: colors.onSecondaryFixed,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Trust Score: 99.4% • ${AppStrings.appName} Insured Escrow',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.onPrimaryContainer,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),


        ],
      ),
    );
  }

  Widget _buildProfilePhotoCard(ColorScheme colors) {
    return _CardContainer(
      colors: colors,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96,
                height: 96,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.surfaceContainerHighest,
                  boxShadow: [
                    BoxShadow(
                      color: colors.surfaceContainerLow,
                      blurRadius: 0,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    _profileImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: colors.surfaceContainerHigh,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.person,
                          size: 42,
                          color: colors.outline,
                        ),
                      );
                    },
                  ),
                ),
              ),

              Positioned(
                right: -1,
                bottom: -1,
                child: _CameraButton(
                  onTap: widget.onChangePhoto,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            'Alexander Magnus',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelMedium.copyWith(
              color: colors.onSurface,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            'Principal Partner • Magnus Capital & Trust SPV',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.onSurfaceVariant,
              fontSize: 10.5,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _OutlinedActionButton(
                label: 'Change Photo',
                onTap: widget.onChangePhoto,
              ),
              const SizedBox(width: 8),
              _TextActionButton(
                label: 'Remove',
                color: colors.error,
                onTap: widget.onRemovePhoto,
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colors.outlineVariant,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shield,
                  size: 15,
                  color: colors.secondary,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Verified Identity (Tier 3 BVN/NIN Linked)',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colors.secondary,
                      fontSize: 10.5,
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

  Widget _buildStatutoryCard(ColorScheme colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lock_outline,
                size: 16,
                color: colors.outline,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'STATUTORY & AML VERIFICATION',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.onSurface,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
              Text(
                'Read-Only',
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.outline,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Divider(
            height: 1,
            color: colors.outlineVariant,
          ),

          const SizedBox(height: 12),

          _LockedField(
            label: 'Statutory Legal Name',
            value: 'Alexander Magnus',
            icon: Icons.verified_user,
            colors: colors,
          ),

          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                size: 13,
                color: colors.secondary,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  'Statutory name verified via BVN & NIN. Modifying legal name requires re-submitting Tier 3 identity verification.',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.onSurfaceVariant,
                    fontSize: 10,
                    height: 1.45,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _LockedField(
            label: 'Investor Reference ID',
            value: 'INV-NG-883920',
            isMono: true,
            trailing: _CopyButton(
              onTap: () {
                ClipboardHelper.copy(
                  context,
                  'INV-NG-883920',
                );
              },
            ),
            colors: colors,
          ),
        ],
      ),
    );
  }

  Widget _buildEditableProfileCard(ColorScheme colors) {
    return _CardContainer(
      colors: colors,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.badge_outlined,
                size: 17,
                color: colors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Institutional Representation',
                style: AppTextStyles.labelMedium.copyWith(
                  color: colors.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _ProfileTextField(
            label: 'Display Title / Capacity',
            controller: _displayNameController,
            colors: colors,
          ),

          const SizedBox(height: 16),

          _ProfileTextField(
            label: 'Corporate Escrow Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            trailing: _VerifiedBadge(colors: colors),
            colors: colors,
          ),

          const SizedBox(height: 16),

          _ProfileTextField(
            label: 'Primary Phone Number',
            value: '+234 803 ••• 4920',
            readOnly: true,
            isMono: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'MTN Secure',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.onSurfaceVariant,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            topAction: 'Update Number',
            onTopAction: widget.onUpdatePhone,
            colors: colors,
          ),

          const SizedBox(height: 16),

          _ProfileTextField(
            label: 'Registered Real Estate SPV / Firm',
            controller: _entityController,
            colors: colors,
          ),

          const SizedBox(height: 16),

          _ProfileTextField(
            label: 'Primary Investment Jurisdiction',
            controller: _jurisdictionController,
            trailing: Icon(
              Icons.location_on_outlined,
              size: 17,
              color: colors.outline,
            ),
            colors: colors,
          ),

          const SizedBox(height: 16),

          _ProfileTextField(
            label: 'Investment Mandate & Bio',
            controller: _mandateController,
            maxLines: 3,
            onChanged: (_) => setState(() {}),
            colors: colors,
          ),

          const SizedBox(height: 4),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_mandateController.text.length} / 300 characters',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.outline,
                fontSize: 9.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyCard(ColorScheme colors) {
    return _CardContainer(
      colors: colors,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Institutional Trust Privacy',
            style: AppTextStyles.labelMedium.copyWith(
              color: colors.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'Control what prospective co-investors and syndicates see on your verified listing cards.',
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.onSurfaceVariant,
              fontSize: 10.5,
              height: 1.45,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 12),

          _PrivacySwitchRow(
            title: 'Diamond Tier Badge',
            subtitle: 'Showcase verified accredited status on deals',
            value: _diamondBadge,
            onChanged: (value) {
              setState(() {
                _diamondBadge = value;
              });
            },
            colors: colors,
          ),

          _SectionDivider(colors: colors),

          _PrivacySwitchRow(
            title: '99.4% Verified Escrow Score',
            subtitle: 'Display counterparty fulfillment reliability rate',
            value: _escrowScore,
            onChanged: (value) {
              setState(() {
                _escrowScore = value;
              });
            },
            colors: colors,
          ),

          _SectionDivider(colors: colors),

          _PrivacySwitchRow(
            title: 'Completed Escrow Volume',
            subtitle:
            'Display total closed asset allocation metrics (₦)',
            value: _escrowVolume,
            onChanged: (value) {
              setState(() {
                _escrowVolume = value;
              });
            },
            colors: colors,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(ColorScheme colors) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: _PressScaleButton(
            onTap: _saveProfile,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                disabledBackgroundColor: colors.primary.withValues(
                  alpha: 0.65,
                ),
                elevation: 1,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: colors.outlineVariant,)
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: _isSaving
                    ? SizedBox(
                  key: const ValueKey('loading'),
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.onPrimary,
                  ),
                )
                    : Text(
                  'Save Changes',
                  key: const ValueKey('text'),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.onPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton(
            onPressed: widget.onCancel ?? _handleBack,
            style: TextButton.styleFrom(
              foregroundColor: colors.onSurfaceVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
                side: BorderSide(color: colors.outlineVariant,)
            ),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelMedium.copyWith(
                color: colors.onSurfaceVariant,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceFooter(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        'HomeX Technologies Ltd. Licensed by SEC (Nigeria) as a Digital Sub-Broker. Funds secured under NDIC custodial escrow provisions.',
        textAlign: TextAlign.center,
        style: AppTextStyles.labelSmall.copyWith(
          color: colors.outline,
          fontSize: 9.5,
          height: 1.35,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }


  Widget _buildSaveToast(ColorScheme colors) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 76,
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: _showSavedMessage ? 1 : 0,
          duration: const Duration(milliseconds: 180),
          child: AnimatedSlide(
            offset: _showSavedMessage
                ? Offset.zero
                : const Offset(0, 0.08),
            duration: const Duration(milliseconds: 180),
            curve: AppAnimations.enter,
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: colors.inverseSurface,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x25000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 18,
                    color: colors.onInverseSurface,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Profile preferences updated',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: colors.onInverseSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    'Live',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colors.secondaryFixed,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
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

// -----------------------------------------------------------------------------
// CARD
// -----------------------------------------------------------------------------

class _CardContainer extends StatelessWidget {
  const _CardContainer({
    required this.colors,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final ColorScheme colors;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: child,
    );
  }
}

// -----------------------------------------------------------------------------
// PROFILE FIELD
// -----------------------------------------------------------------------------

class _ProfileTextField extends StatelessWidget {
  const _ProfileTextField({
    required this.label,
    required this.colors,
    this.controller,
    this.value,
    this.trailing,
    this.topAction,
    this.onTopAction,
    this.readOnly = false,
    this.isMono = false,
    this.maxLines = 1,
    this.keyboardType,
    this.onChanged,
  });

  final String label;
  final ColorScheme colors;
  final TextEditingController? controller;
  final String? value;
  final Widget? trailing;
  final String? topAction;
  final VoidCallback? onTopAction;
  final bool readOnly;
  final bool isMono;
  final int maxLines;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: AppTextStyles.bodyMedium.copyWith(
        color: colors.onSurface,
        fontSize: 13,
        height: 1.4,
        fontWeight: FontWeight.w400,
        fontFamily: isMono ? 'monospace' : AppTextStyles.fontFamily,
      ),
      decoration: InputDecoration(
        hintText: value,
        suffixIcon: trailing == null
            ? null
            : Padding(
          padding: const EdgeInsets.only(right: 12),
          child: trailing,
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        filled: true,
        fillColor: readOnly
            ? colors.surfaceContainerLow
            : colors.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colors.outlineVariant,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colors.outlineVariant,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colors.primary,
            width: 1.2,
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.onSurfaceVariant,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (topAction != null)
              GestureDetector(
                onTap: onTopAction,
                child: Text(
                  topAction!,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.secondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        field,
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// LOCKED FIELD
// -----------------------------------------------------------------------------

class _LockedField extends StatelessWidget {
  const _LockedField({
    required this.label,
    required this.value,
    required this.colors,
    this.icon,
    this.trailing,
    this.isMono = false,
  });

  final String label;
  final String value;
  final ColorScheme colors;
  final IconData? icon;
  final Widget? trailing;
  final bool isMono;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: colors.onSurfaceVariant,
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          constraints: const BoxConstraints(minHeight: 42),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colors.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: colors.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily:
                    isMono ? 'monospace' : AppTextStyles.fontFamily,
                  ),
                ),
              ),
              if (trailing != null)
                trailing!
              else if (icon != null)
                Icon(
                  icon,
                  size: 16,
                  color: colors.outline,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// PRIVACY SWITCH
// -----------------------------------------------------------------------------

class _PrivacySwitchRow extends StatelessWidget {
  const _PrivacySwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.colors,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: colors.onSurface,
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colors.onSurfaceVariant,
                      fontSize: 10,
                      height: 1.35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: colors.primaryFixedDim,
            activeThumbColor: colors.primary,
            inactiveTrackColor: colors.surfaceContainerHighest,
            inactiveThumbColor: colors.surfaceContainerLowest,
            trackOutlineColor: WidgetStatePropertyAll(
              colors.outlineVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BOTTOM NAV
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// BUTTONS
// -----------------------------------------------------------------------------

class _SmallPrimaryButton extends StatelessWidget {
  const _SmallPrimaryButton({
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _PressScaleButton(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 160),
          child: isLoading
              ? SizedBox(
            key: const ValueKey('loading'),
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 1.8,
              color: colors.onPrimary,
            ),
          )
              : Text(
            label,
            key: const ValueKey('label'),
            style: AppTextStyles.labelMedium.copyWith(
              color: colors.onPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlinedActionButton extends StatelessWidget {
  const _OutlinedActionButton({
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          color: colors.outlineVariant,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: colors.onSurface,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _TextActionButton extends StatelessWidget {
  const _TextActionButton({
    required this.label,
    required this.color,
    this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: color,
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CAMERA
// -----------------------------------------------------------------------------

class _CameraButton extends StatelessWidget {
  const _CameraButton({
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _PressScaleButton(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: colors.primary,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.photo_camera_outlined,
          size: 15,
          color: colors.onPrimary,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// VERIFIED BADGE
// -----------------------------------------------------------------------------

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 12,
            color: colors.onTertiaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            'Verified',
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.onTertiaryContainer,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COPY
// -----------------------------------------------------------------------------

class _CopyButton extends StatelessWidget {
  const _CopyButton({
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.content_copy_outlined,
            size: 15,
            color: colors.outline,
          ),
          const SizedBox(width: 4),
          Text(
            'Copy',
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.outline,
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CIRCLE BUTTON
// -----------------------------------------------------------------------------

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _PressScaleButton(
      onTap: onTap,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Icon(
            icon,
            size: 22,

          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// DIVIDER
// -----------------------------------------------------------------------------

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        height: 1,
        thickness: 1,
        color: colors.outlineVariant,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PRESS SCALE
// -----------------------------------------------------------------------------

class _PressScaleButton extends StatefulWidget {
  const _PressScaleButton({
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<_PressScaleButton> createState() => _PressScaleButtonState();
}

class _PressScaleButtonState extends State<_PressScaleButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!mounted || widget.onTap == null) return;

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapCancel: () => _setPressed(false),
      onTapUp: (_) {
        _setPressed(false);
        widget.onTap?.call();
      },
      child: AnimatedScale(
        scale: _pressed ? 0.975 : 1,
        duration: const Duration(milliseconds: 100),
        curve: AppAnimations.fastCurve,
        child: widget.child,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CLIPBOARD HELPER
// -----------------------------------------------------------------------------

class ClipboardHelper {
  ClipboardHelper._();

  static void copy(
      BuildContext context,
      String value,
      ) {
    // This intentionally uses Flutter's standard clipboard API without
    // introducing another dependency into the screen.
    //
    // Add:
    // import 'package:flutter/services.dart';
    //
    // and replace this body with:
    //
    // Clipboard.setData(ClipboardData(text: value));
    //
    // ScaffoldMessenger.of(context).showSnackBar(...);
  }
}