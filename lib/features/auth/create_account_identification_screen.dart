import 'package:homex/ui/global.dart';

class CreateAccountIdentificationScreen extends StatefulWidget {
  const CreateAccountIdentificationScreen({
    super.key,
    this.onContinue,
    this.onLogin,
    this.onHelp,
    this.onBack,
  });

  final VoidCallback? onContinue;
  final VoidCallback? onLogin;
  final VoidCallback? onHelp;
  final VoidCallback? onBack;

  @override
  State<CreateAccountIdentificationScreen> createState() =>
      _CreateAccountIdentificationScreenState();
}

class _CreateAccountIdentificationScreenState
    extends State<CreateAccountIdentificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  bool _isEmailSelected = true;
  bool _acceptedTerms = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // RESPONSIVE HELPERS
  // ---------------------------------------------------------------------------



  double get _screenHeight => context.heightPx;

  bool get _isVerySmallPhone => _screenWidth < 340;

  bool get _isSmallPhone => _screenWidth < 375;

  bool get _isLargePhone => _screenWidth >= 430;

  bool get _isTablet => _screenWidth >= 600;

  double get _horizontalPadding {
    if (_isTablet) return 32;
    if (_isLargePhone) return 22;
    if (_isVerySmallPhone) return 14;
    if (_isSmallPhone) return 16;
    return 20;
  }
  double get _screenWidth => context.widthPx;
  double get _contentMaxWidth => _isTablet ? 520 : 480;

  double _responsiveFont({
    required double base,
    double min = 10,
    double max = 32,
  }) {
    final scale = (_screenWidth / 375).clamp(0.88, 1.12);
    return (base * scale).clamp(min, max).toDouble();
  }

  double _responsiveHeight({
    required double base,
    double min = 1,
    double max = 100,
  }) {
    final scale = (_screenHeight / 812).clamp(0.88, 1.12);
    return (base * scale).clamp(min, max).toDouble();
  }

  double _responsiveSpacing({
    required double base,
    double min = 1,
    double max = 60,
  }) {
    final scale = (_screenWidth / 375).clamp(0.90, 1.10);
    return (base * scale).clamp(min, max).toDouble();
  }

  // ---------------------------------------------------------------------------
  // VALIDATION
  // ---------------------------------------------------------------------------

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email address';
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validatePhone(String? value) {
    final phone = value?.replaceAll(RegExp(r'\s+'), '') ?? '';

    if (phone.isEmpty) {
      return 'Please enter your phone number';
    }

    if (phone.length < 10) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // ACTIONS
  // ---------------------------------------------------------------------------

  Future<void> _continue(Set<String> role) async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptedTerms) {
      _showMessage(
        'Please accept the Terms of Service and Escrow Regulatory Disclosures.',
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });
    AppNavigator.pushAndStackNamed(AppRoutes.verifyOtpScreen,arguments: {
      "role":role
    });

    await Future<void>.delayed(const Duration(milliseconds: 350));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    widget.onContinue?.call();
  }

  void _showMessage(String message) {
    final colors = context.colors;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.labelMedium.copyWith(
              color: colors.onInverseSurface,
              fontSize: _responsiveFont(base: 13, min: 12, max: 15),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: colors.inverseSurface,
        ),
      );
  }

  void _selectEmail() {
    if (_isSubmitting || _isEmailSelected) return;

    setState(() {
      _isEmailSelected = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _emailFocusNode.requestFocus();
      }
    });
  }

  void _selectPhone() {
    if (_isSubmitting || !_isEmailSelected) return;

    setState(() {
      _isEmailSelected = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _phoneFocusNode.requestFocus();
      }
    });
  }

  // ---------------------------------------------------------------------------
  // INPUT DECORATION
  // ---------------------------------------------------------------------------

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? prefix,
  }) {
    final colors = context.colors;

    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        size: _responsiveFont(base: 21, min: 19, max: 23),
        color: colors.onSurfaceVariant,
      ),
      prefix: prefix,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        fontSize: _responsiveFont(base: 14, min: 13, max: 16),
        color: colors.onSurfaceVariant,
      ),
      filled: true,
      fillColor: colors.surfaceContainerLowest,
      contentPadding: EdgeInsets.symmetric(
        horizontal: _responsiveSpacing(base: 14),
        vertical: _responsiveHeight(base: 14, min: 12, max: 17),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          _responsiveSpacing(base: 12, min: 10, max: 14),
        ),
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          _responsiveSpacing(base: 12, min: 10, max: 14),
        ),
        borderSide: BorderSide(color: colors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          _responsiveSpacing(base: 12, min: 10, max: 14),
        ),
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          _responsiveSpacing(base: 12, min: 10, max: 14),
        ),
        borderSide: BorderSide(color: colors.error, width: 1.5),
      ),
      errorStyle: AppTextStyles.labelSmall.copyWith(
        color: colors.error,
        fontSize: _responsiveFont(base: 11, min: 10, max: 13),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
final roleMap = ModalRoute.of(context)?.settings.arguments as Map;
final role = roleMap['role'] as Set<String>;
    return Scaffold(
      backgroundColor: colors.surface,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: _contentMaxWidth),
            child: Column(
              children: [
                _buildAnimatedAppBar(colors),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.symmetric(
                      horizontal: _horizontalPadding,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: _responsiveSpacing(base: 14)),

                          _buildProgress(colors),

                          SizedBox(height: _responsiveSpacing(base: 24)),

                          _buildAnimatedHeading(colors),

                          SizedBox(height: _responsiveSpacing(base: 22)),

                          _buildAnimatedSegmentedControl(colors),

                          SizedBox(height: _responsiveSpacing(base: 16)),

                          _buildAnimatedFormFields(colors),

                          SizedBox(height: _responsiveSpacing(base: 18)),

                          _buildAnimatedEscrowCard(colors),

                          SizedBox(height: _responsiveSpacing(base: 16)),

                          _buildAnimatedTerms(colors),

                          SizedBox(height: _responsiveSpacing(base: 14)),

                          _buildAnimatedContinueButton(colors,role),

                          SizedBox(height: _responsiveSpacing(base: 18)),

                          _buildAnimatedDivider(colors),

                          SizedBox(height: _responsiveSpacing(base: 16)),

                          _buildAnimatedLogin(colors),

                          SizedBox(height: _responsiveSpacing(base: 28)),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildAnimatedSecurityFooter(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TOP APP BAR
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedAppBar(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.top,
      distance: AppAnimations.slideSmall,
      duration: AppAnimations.normal,
      delay: AppAnimations.noDelay,
      child: Container(
        height: _responsiveHeight(base: 62, min: 56, max: 70),
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        decoration: BoxDecoration(
          color: colors.surface.withValues(alpha: 0.96),
          border: Border(
            bottom: BorderSide(
              color: colors.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
        ),
        child: Row(
          children: [
            _HeaderIconButton(
              icon: Icons.arrow_back_rounded,
              onTap:
                  widget.onBack ??
                  () {
                    Navigator.of(context).maybePop();
                  },
            ),

            SizedBox(width: _responsiveSpacing(base: 12)),

            Expanded(
              child: Text(
                'HomeX',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: _responsiveFont(base: 19, min: 18, max: 22),
                  color: colors.onSurface,
                ),
              ),
            ),

            ScaleOnTap(
              onTap: widget.onHelp,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _responsiveSpacing(base: 8),
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.help_outline_rounded,
                      size: _responsiveFont(base: 18, min: 17, max: 20),
                      color: colors.onSurfaceVariant,
                    ),
                    SizedBox(width: _responsiveSpacing(base: 5)),
                    Text(
                      'Help',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontSize: _responsiveFont(base: 13, min: 12, max: 15),
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PROGRESS
  // ---------------------------------------------------------------------------

  Widget _buildProgress(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.bottom,
      duration: AppAnimations.normal,
      delay: AppAnimations.shortDelay,
      distance: AppAnimations.slideSmall,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _responsiveSpacing(base: 10),
                  vertical: _responsiveSpacing(base: 5),
                ),
                decoration: BoxDecoration(
                  color: colors.secondaryContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '2 of 3',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: _responsiveFont(base: 11, min: 10, max: 13),
                    color: colors.onSecondaryContainer,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Identification',
                style: AppTextStyles.labelMedium.copyWith(
                  fontSize: _responsiveFont(base: 12, min: 11, max: 14),
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: _responsiveSpacing(base: 9)),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.66,
              minHeight: _responsiveHeight(base: 5, min: 4, max: 6),
              backgroundColor: colors.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(colors.secondary),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADING
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedHeading(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.bottom,
      duration: AppAnimations.normal,
      delay: const Duration(milliseconds: 160),
      distance: AppAnimations.slideMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Your Account',
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: _responsiveFont(base: 24, min: 21, max: 28),
              color: colors.onSurface,
            ),
          ),
          SizedBox(height: _responsiveSpacing(base: 6)),
          Text(
            'Enter your details to securely create your HomeX account.',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: _responsiveFont(base: 14, min: 13, max: 16),
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SEGMENTED CONTROL
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedSegmentedControl(ColorScheme colors) {
    return FadeScaleIn(
      duration: AppAnimations.normal,
      delay: const Duration(milliseconds: 240),
      beginScale: AppAnimations.scaleStart,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(
            _responsiveSpacing(base: 12, min: 10, max: 14),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: _SegmentedTab(
                icon: Icons.alternate_email_rounded,
                label: 'Email Address',
                selected: _isEmailSelected,
                onTap: _selectEmail,
              ),
            ),
            Expanded(
              child: _SegmentedTab(
                icon: Icons.phone_outlined,
                label: 'Phone Number',
                selected: !_isEmailSelected,
                onTap: _selectPhone,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FORM FIELDS
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedFormFields(ColorScheme colors) {
    return AnimatedSwitcher(
      duration: AppAnimations.normal,
      reverseDuration: AppAnimations.fast,
      switchInCurve: AppAnimations.enter,
      switchOutCurve: AppAnimations.exit,
      transitionBuilder: (child, animation) {
        final offsetAnimation =
            Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: AppAnimations.enter),
            );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: offsetAnimation, child: child),
        );
      },
      child: _isEmailSelected
          ? _buildEmailFields(colors)
          : _buildPhoneFields(colors),
    );
  }

  Widget _buildEmailFields(ColorScheme colors) {
    return Column(
      key: const ValueKey('email-fields'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SlideFadeIn(
          direction: SlideDirection.bottom,
          duration: AppAnimations.normal,
          delay: const Duration(milliseconds: 300),
          distance: AppAnimations.slideSmall,
          child: TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.email],
            validator: _validateEmail,
            decoration: _inputDecoration(
              hint: 'e.g. name@domain.com',
              icon: Icons.alternate_email_rounded,
            ),
          ),
        ),
        SizedBox(height: _responsiveSpacing(base: 8)),
        FadeIn(
          duration: AppAnimations.fast,
          delay: const Duration(milliseconds: 420),
          child: _HintRow(
            icon: Icons.mark_email_read_outlined,
            text: 'We will send a one-time verification code to your email.',
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneFields(ColorScheme colors) {
    return Column(
      key: const ValueKey('phone-fields'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SlideFadeIn(
          direction: SlideDirection.bottom,
          duration: AppAnimations.normal,
          delay: const Duration(milliseconds: 100),
          distance: AppAnimations.slideSmall,
          child: TextFormField(
            controller: _phoneController,
            focusNode: _phoneFocusNode,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.telephoneNumber],
            validator: _validatePhone,
            decoration: _inputDecoration(
              hint: '801 234 5678',
              icon: Icons.phone_outlined,
              prefix: _NigeriaPrefix(
                fontSize: _responsiveFont(base: 14, min: 13, max: 16),
              ),
            ),
          ),
        ),
        SizedBox(height: _responsiveSpacing(base: 8)),
        FadeIn(
          duration: AppAnimations.fast,
          delay: const Duration(milliseconds: 220),
          child: _HintRow(
            icon: Icons.sms_outlined,
            text: 'We will send a one-time verification code by SMS.',
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // ESCROW CARD
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedEscrowCard(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.bottom,
      duration: AppAnimations.medium,
      delay: const Duration(milliseconds: 500),
      distance: AppAnimations.slideSmall,
      child: Container(
        padding: EdgeInsets.all(_responsiveSpacing(base: 14)),
        decoration: BoxDecoration(
          color: colors.secondaryContainer.withValues(alpha: 0.48),
          borderRadius: BorderRadius.circular(
            _responsiveSpacing(base: 12, min: 10, max: 14),
          ),
          border: Border.all(color: colors.secondary.withValues(alpha: 0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeScaleIn(
              duration: AppAnimations.medium,
              delay: const Duration(milliseconds: 560),
              beginScale: AppAnimations.scaleSmall,
              child: Container(
                width: _responsiveHeight(base: 40, min: 36, max: 44),
                height: _responsiveHeight(base: 40, min: 36, max: 44),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLowest,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  color: colors.secondary,
                  size: _responsiveFont(base: 21, min: 19, max: 24),
                ),
              ),
            ),
            SizedBox(width: _responsiveSpacing(base: 12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Institutional Escrow Protection',
                    style: AppTextStyles.labelMedium.copyWith(
                      fontSize: _responsiveFont(base: 13, min: 12, max: 15),
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
                  ),
                  SizedBox(height: _responsiveSpacing(base: 3)),
                  Text(
                    'Your identity and transaction information are protected by HomeX security controls.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: _responsiveFont(base: 12, min: 11, max: 14),
                      color: colors.onSurfaceVariant,
                      height: 1.4,
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

  // ---------------------------------------------------------------------------
  // TERMS
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedTerms(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.bottom,
      duration: AppAnimations.normal,
      delay: const Duration(milliseconds: 620),
      distance: AppAnimations.slideSmall,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _acceptedTerms = !_acceptedTerms;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedScale(
              scale: _acceptedTerms ? 1.05 : 1.0,
              duration: AppAnimations.fast,
              curve: AppAnimations.fastCurve,
              child: Checkbox(
                value: _acceptedTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptedTerms = value ?? false;
                  });
                },
                activeColor: colors.primary,
                checkColor: colors.onPrimary,
                side: BorderSide(color: colors.outlineVariant),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            SizedBox(width: _responsiveSpacing(base: 8)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text.rich(
                  TextSpan(
                    text: 'I agree to the HomeX ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: _responsiveFont(base: 12, min: 11, max: 14),
                      color: colors.onSurfaceVariant,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Escrow Regulatory Disclosures',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: '.'),
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

  // ---------------------------------------------------------------------------
  // CONTINUE BUTTON
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedContinueButton(ColorScheme colors,Set<String> role) {
    return FadeScaleIn(
      duration: AppAnimations.medium,
      delay: const Duration(milliseconds: 700),
      beginScale: AppAnimations.scaleStart,
      curve: AppAnimations.standard,
      child: ScaleOnTap(
        onTap: _isSubmitting ? null : ()=>_continue(role),
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          curve: AppAnimations.fastCurve,
          height: _responsiveHeight(base: 52, min: 48, max: 58),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(
              _responsiveSpacing(base: 12, min: 10, max: 14),

            ),
            border: Border.all(color: colors.surfaceContainer),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withValues(alpha: 0.10),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: AppAnimations.fast,
              switchInCurve: AppAnimations.enter,
              child: _isSubmitting
                  ? SizedBox(
                      key: const ValueKey('loading'),
                      width: _responsiveHeight(base: 52, min: 44, max: 58),
                      child: const Center(child: BounceDots()),
                    )
                  : Row(
                      key: const ValueKey('continue'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: _responsiveFont(base: 18, min: 17, max: 20),
                          color: colors.onPrimary,
                        ),
                        SizedBox(width: _responsiveSpacing(base: 8)),
                        Text(
                          'Continue & Send OTP',
                          style: AppTextStyles.labelMedium.copyWith(
                            fontSize: _responsiveFont(
                              base: 14,
                              min: 13,
                              max: 16,
                            ),
                            fontWeight: FontWeight.w600,
                            color: colors.onPrimary,
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
  // DIVIDER
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedDivider(ColorScheme colors) {
    return FadeIn(
      duration: AppAnimations.fast,
      delay: const Duration(milliseconds: 800),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 1,
            color: colors.outlineVariant.withValues(alpha: 0.7),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: _responsiveSpacing(base: 10),
            ),
            color: colors.surface,
            child: Text(
              'OR',
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: _responsiveFont(base: 10, min: 9, max: 12),
                letterSpacing: 1.2,
                color: colors.outline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LOGIN
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedLogin(ColorScheme colors) {
    return FadeIn(
      duration: AppAnimations.normal,
      delay: const Duration(milliseconds: 860),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: _responsiveFont(base: 12, min: 11, max: 14),
                fontWeight: FontWeight.w500,
                color: colors.onSurfaceVariant,
              ),
            ),
            ScaleOnTap(
              onTap: () =>
                  AppNavigator.pushAndStackNamed(AppRoutes.secureLoginScreen),
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  'Log in',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: _responsiveFont(base: 12, min: 11, max: 14),
                    fontWeight: FontWeight.w700,
                    color: colors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECURITY FOOTER
  // ---------------------------------------------------------------------------

  Widget _buildAnimatedSecurityFooter(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.bottom,
      duration: AppAnimations.medium,
      delay: const Duration(milliseconds: 900),
      distance: AppAnimations.slideSmall,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _responsiveSpacing(base: 14),
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          border: Border(
            top: BorderSide(
              color: colors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: _responsiveFont(base: 16, min: 15, max: 18),
                  color: colors.secondary,
                ),
                SizedBox(width: _responsiveSpacing(base: 7)),
                Flexible(
                  child: Text(
                    'SEC Nigeria Regulated Sub-Broker & NDIC Insured Partner',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: _responsiveFont(base: 10.5, min: 9.5, max: 12),
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: _responsiveSpacing(base: 3)),
            Text(
              'HomeX Fintech Solutions Ltd. Protected with 256-bit institutional encryption.',
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: _responsiveFont(base: 9.5, min: 8.5, max: 11),
                fontWeight: FontWeight.w400,
                color: colors.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// HEADER ICON BUTTON
// =============================================================================

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ScaleOnTap(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: colors.onSurface),
      ),
    );
  }
}

// =============================================================================
// SEGMENTED TAB
// =============================================================================

class _SegmentedTab extends StatelessWidget {
  const _SegmentedTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final screenWidth = context.widthPx;
    final fontSize = (screenWidth / 375 * 13).clamp(11.0, 15.0).toDouble();

    return ScaleOnTap(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.smooth,
        padding: EdgeInsets.symmetric(
          vertical: screenWidth < 340 ? 9 : 10,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: selected ? colors.surfaceContainerLowest : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: colors.shadow.withValues(alpha: 0.07),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: selected ? 1.0 : 0.94,
              duration: AppAnimations.fast,
              curve: AppAnimations.fastCurve,
              child: Icon(
                icon,
                size: screenWidth < 340 ? 16 : 18,
                color: selected ? colors.secondary : colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: AnimatedDefaultTextStyle(
                duration: AppAnimations.fast,
                curve: AppAnimations.fastCurve,
                style: AppTextStyles.labelMedium.copyWith(
                  fontSize: fontSize,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected ? colors.secondary : colors.onSurfaceVariant,
                ),
                child: Text(label, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// NIGERIA PREFIX
// =============================================================================

class _NigeriaPrefix extends StatelessWidget {
  const _NigeriaPrefix({required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🇳🇬', style: TextStyle(fontSize: 17)),
          const SizedBox(width: 5),
          Text(
            '+234',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(width: 7),
          Container(width: 1, height: 22, color: colors.outlineVariant),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

// =============================================================================
// HINT ROW
// =============================================================================

class _HintRow extends StatelessWidget {
  const _HintRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final fontSize = (context.widthPx / 375 * 11.5)
        .clamp(10.0, 13.0)
        .toDouble();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: colors.outline),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: colors.outline,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
