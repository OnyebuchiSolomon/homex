import 'package:homex/res/app_strings.dart';
import 'package:homex/ui/global.dart';
class SecureLoginScreen extends StatefulWidget {
  const SecureLoginScreen({
    super.key,
    this.onBack,
    this.onHelp,
    this.onForgotPassword,
    this.onCreateAccount,
    this.onOtpLogin,
    this.onBiometricLogin,
    this.onGoogleLogin,
    this.onAppleLogin,
    this.onSignIn,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onCreateAccount;
  final VoidCallback? onOtpLogin;
  final VoidCallback? onBiometricLogin;
  final VoidCallback? onGoogleLogin;
  final VoidCallback? onAppleLogin;
  final VoidCallback? onSignIn;

  @override
  State<SecureLoginScreen> createState() => _SecureLoginScreenState();
}

class _SecureLoginScreenState extends State<SecureLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isEmailSelected = true;
  bool _obscurePassword = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  // ===========================================================================
  // RESPONSIVE HELPERS
  // ===========================================================================

  double get _screenWidth => context.widthPx;

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

  double get _contentMaxWidth {
    if (_isTablet) return 520;
    return 480;
  }

  double _font({
    required double base,
    double min = 10,
    double max = 32,
  }) {
    final scale = (_screenWidth / 375).clamp(0.88, 1.12);

    return (base * scale).clamp(min, max).toDouble();
  }

  double _height({
    required double base,
    double min = 1,
    double max = 100,
  }) {
    final scale = (_screenHeight / 812).clamp(0.88, 1.12);

    return (base * scale).clamp(min, max).toDouble();
  }

  double _spacing({
    required double base,
    double min = 1,
    double max = 60,
  }) {
    final scale = (_screenWidth / 375).clamp(0.90, 1.10);

    return (base * scale).clamp(min, max).toDouble();
  }

  // ===========================================================================
  // VALIDATION
  // ===========================================================================

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email address';
    }

    final regex = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!regex.hasMatch(email)) {
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

  String? _validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < 6) {
      return 'Password must contain at least 6 characters';
    }

    return null;
  }

  // ===========================================================================
  // ACTIONS
  // ===========================================================================

  Future<void> _signIn() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    widget.onSignIn?.call();
  }

  void _switchToEmail() {
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

  void _switchToPhone() {
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

  void _togglePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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
              fontSize: _font(
                base: 13,
                min: 12,
                max: 15,
              ),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: colors.inverseSurface,
        ),
      );
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surface,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: _contentMaxWidth,
            ),
            child: Column(
              children: [
                _buildTopBar(colors),

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
                          SizedBox(
                            height: _spacing(base: 20),
                          ),

                          _buildHeader(colors),

                          SizedBox(
                            height: _spacing(base: 22),
                          ),

                          _buildModeToggle(colors),

                          SizedBox(
                            height: _spacing(base: 20),
                          ),

                          _buildAuthenticationForm(colors),

                          SizedBox(
                            height: _spacing(base: 22),
                          ),

                          _buildDivider(colors),

                          SizedBox(
                            height: _spacing(base: 18),
                          ),

                          _buildSocialLogin(colors),

                          SizedBox(
                            height: _spacing(base: 16),
                          ),

                          _buildRegistrationPrompt(colors),

                          SizedBox(
                            height: _spacing(base: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //_buildSecurityFooter(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP BAR
  // ===========================================================================

  Widget _buildTopBar(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.top,
      distance: AppAnimations.slideSmall,
      duration: AppAnimations.normal,
      delay: AppAnimations.noDelay,
      child: Container(
        height: _height(
          base: 64,
          min: 58,
          max: 70,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
        ),
        decoration: BoxDecoration(
         // color: colors.surfaceContainerLow,
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.07),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _HeaderButton(
              icon: Icons.arrow_back_rounded,
              onTap: widget.onBack ??
                      () {
                    Navigator.of(context).maybePop();
                  },
            ),

            SizedBox(
              width: _spacing(base: 10),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${AppStrings.appName} ',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontSize: _font(
                      base: 20,
                      min: 18,
                      max: 23,
                    ),
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                   // color: colors.primary,
                  ),
                ),

                SizedBox(
                  width: _spacing(base: 6),
                ),

                Container(
                  width: _spacing(
                    base: 6,
                    min: 5,
                    max: 7,
                  ),
                  height: _spacing(
                    base: 6,
                    min: 5,
                    max: 7,
                  ),
                  decoration: BoxDecoration(
                    color: colors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),

            const Spacer(),

            ScaleOnTap(
              onTap: widget.onHelp,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                child: Text(
                  'Help',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontSize: _font(
                      base: 13,
                      min: 12,
                      max: 15,
                    ),
                    fontWeight: FontWeight.w500,
                   // color: colors.primary,
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

  Widget _buildHeader(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.bottom,
      distance: AppAnimations.slideMedium,
      duration: AppAnimations.normal,
      delay: AppAnimations.shortDelay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeScaleIn(
            duration: AppAnimations.normal,
            delay: const Duration(
              milliseconds: 130,
            ),
            beginScale: AppAnimations.scaleSmall,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _spacing(base: 10),
                vertical: _spacing(base: 6),
              ),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_user_rounded,
                    size: _font(
                      base: 15,
                      min: 14,
                      max: 17,
                    ),
                    color: colors.secondary,
                  ),
                  SizedBox(
                    width: _spacing(base: 5),
                  ),
                  Text(
                    'Enterprise Security',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: _font(
                        base: 11,
                        min: 10,
                        max: 13,
                      ),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: _spacing(base: 12),
          ),

          Text(
            'Welcome Back',
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: _font(
                base: 26,
                min: 22,
                max: 30,
              ),
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              height: 1.15,
              color: colors.primary,
            ),
          ),

          SizedBox(
            height: _spacing(base: 6),
          ),

          Text(
            'Log in to manage your property portfolio, escrow settlements, and verified inquiries.',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: _font(
                base: 14,
                min: 13,
                max: 16,
              ),
              height: 1.55,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // EMAIL / PHONE TOGGLE
  // ===========================================================================

  Widget _buildModeToggle(ColorScheme colors) {
    return FadeScaleIn(
      duration: AppAnimations.normal,
      delay: const Duration(
        milliseconds: 230,
      ),
      beginScale: AppAnimations.scaleStart,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(
            _spacing(
              base: 12,
              min: 10,
              max: 14,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: _ModeTab(
                icon: Icons.mail_outline_rounded,
                label: 'Email Address',
                selected: _isEmailSelected,
                onTap: _switchToEmail,
              ),
            ),

            Expanded(
              child: _ModeTab(
                icon: Icons.call_outlined,
                label: 'Phone Number',
                selected: !_isEmailSelected,
                onTap: _switchToPhone,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // AUTHENTICATION FORM
  // ===========================================================================

  Widget _buildAuthenticationForm(ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedSwitcher(
          duration: AppAnimations.normal,
          reverseDuration: AppAnimations.fast,
          switchInCurve: AppAnimations.enter,
          switchOutCurve: AppAnimations.exit,
          transitionBuilder: (child, animation) {
            final slide = Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: AppAnimations.enter,
              ),
            );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: slide,
                child: child,
              ),
            );
          },
          child: _isEmailSelected
              ? _buildEmailField(colors)
              : _buildPhoneField(colors),
        ),

        SizedBox(
          height: _spacing(base: 17),
        ),

        _buildPasswordField(colors),

        SizedBox(
          height: _spacing(base: 12),
        ),

        _buildAlternativeAccess(colors),

        SizedBox(
          height: _spacing(base: 14),
        ),

        _buildSignInButton(colors),
      ],
    );
  }

  // ===========================================================================
  // EMAIL FIELD
  // ===========================================================================

  Widget _buildEmailField(ColorScheme colors) {
    return SlideFadeIn(
      key: const ValueKey('login-email'),
      direction: SlideDirection.bottom,
      distance: AppAnimations.slideSmall,
      duration: AppAnimations.normal,
      delay: const Duration(
        milliseconds: 300,
      ),
      child: _buildFieldContainer(
        colors: colors,
        label: 'Email Address',
        child: TextFormField(
          controller: _emailController,
          focusNode: _emailFocusNode,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [
            AutofillHints.email,
          ],
          validator: _validateEmail,
          onFieldSubmitted: (_) {
            _passwordFocusNode.requestFocus();
          },
          decoration: _inputDecoration(
            colors: colors,
            icon: Icons.alternate_email_rounded,
            hint: 'e.g. name@domain.com',
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // PHONE FIELD
  // ===========================================================================

  Widget _buildPhoneField(ColorScheme colors) {
    return SlideFadeIn(
      key: const ValueKey('login-phone'),
      direction: SlideDirection.right,
      distance: AppAnimations.slideSmall,
      duration: AppAnimations.normal,
      delay: AppAnimations.noDelay,
      child: _buildFieldContainer(
        colors: colors,
        label: 'Phone Number',
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _height(
                base: 52,
                min: 48,
                max: 58,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: _spacing(base: 12),
              ),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(
                  _spacing(
                    base: 12,
                    min: 10,
                    max: 14,
                  ),
                ),
                border: Border.all(
                  color: colors.outlineVariant,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '🇳🇬',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: _spacing(base: 5),
                    ),
                    Text(
                      '+234',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontSize: _font(
                          base: 13,
                          min: 12,
                          max: 15,
                        ),
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              width: _spacing(base: 8),
            ),

            Expanded(
              child: TextFormField(
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
                validator: _validatePhone,
                decoration: _inputDecoration(
                  colors: colors,
                  hint: '801 234 5678',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // FIELD CONTAINER
  // ===========================================================================

  Widget _buildFieldContainer({
    required ColorScheme colors,
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: _spacing(base: 7),
          ),
          child: Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              fontSize: _font(
                base: 12,
                min: 11,
                max: 14,
              ),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: colors.onSurface,
            ),
          ),
        ),
        child,
      ],
    );
  }

  // ===========================================================================
  // PASSWORD FIELD
  // ===========================================================================

  Widget _buildPasswordField(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.bottom,
      distance: AppAnimations.slideSmall,
      duration: AppAnimations.normal,
      delay: const Duration(
        milliseconds: 390,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Password',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontSize: _font(
                      base: 12,
                      min: 11,
                      max: 14,
                    ),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                    color: colors.onSurface,
                  ),
                ),
              ),

              ScaleOnTap(
                onTap: widget.onForgotPassword,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 2,
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: _font(
                        base: 11.5,
                        min: 10,
                        max: 14,
                      ),
                      fontWeight: FontWeight.w500,
                      color: colors.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: _spacing(base: 7),
          ),

          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [
              AutofillHints.password,
            ],
            validator: _validatePassword,
            onFieldSubmitted: (_) => _signIn(),
            decoration: _inputDecoration(
              colors: colors,
              icon: Icons.lock_outline_rounded,
              hint: 'Enter your secure password',
              suffixIcon: ScaleOnTap(
                onTap: _togglePassword,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: AnimatedSwitcher(
                    duration: AppAnimations.fast,
                    transitionBuilder: (child, animation) {
                      return FadeScaleIn(
                        duration: AppAnimations.fast,
                        child: child,
                      );
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      key: ValueKey<bool>(_obscurePassword),
                      size: _font(
                        base: 20,
                        min: 18,
                        max: 22,
                      ),
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // INPUT DECORATION
  // ===========================================================================

  InputDecoration _inputDecoration({
    required ColorScheme colors,
    IconData? icon,
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,

      prefixIcon: icon == null
          ? null
          : Icon(
        icon,
        size: _font(
          base: 20,
          min: 18,
          max: 22,
        ),
        color: colors.onSurfaceVariant,
      ),

      suffixIcon: suffixIcon,

      hintStyle: AppTextStyles.bodyMedium.copyWith(
        fontSize: _font(
          base: 13.5,
          min: 12.5,
          max: 16,
        ),
        color: colors.outline,
      ),

      filled: true,
      fillColor: colors.surfaceContainerLowest,

      contentPadding: EdgeInsets.symmetric(
        horizontal: _spacing(base: 14),
        vertical: _height(
          base: 15,
          min: 13,
          max: 17,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          _spacing(
            base: 12,
            min: 10,
            max: 14,
          ),
        ),
        borderSide: BorderSide(
          color: colors.surfaceContainerHighest,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          _spacing(
            base: 12,
            min: 10,
            max: 14,
          ),
        ),
        borderSide: BorderSide(
          color: colors.primary,
          width: 1.2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          _spacing(
            base: 12,
            min: 10,
            max: 14,
          ),
        ),
        borderSide: BorderSide(
          color: colors.error,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          _spacing(
            base: 12,
            min: 10,
            max: 14,
          ),
        ),
        borderSide: BorderSide(
          color: colors.error,
          width: 1.2,
        ),
      ),

      errorStyle: AppTextStyles.labelSmall.copyWith(
        color: colors.error,
        fontSize: _font(
          base: 10.5,
          min: 9.5,
          max: 12,
        ),
      ),
    );
  }

  // ===========================================================================
  // ALTERNATIVE ACCESS
  // ===========================================================================

  Widget _buildAlternativeAccess(ColorScheme colors) {
    return FadeIn(
      duration: AppAnimations.normal,
      delay: const Duration(
        milliseconds: 500,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ScaleOnTap(
              onTap: widget.onOtpLogin,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.pin_outlined,
                      size: _font(
                        base: 16,
                        min: 15,
                        max: 18,
                      ),
                      color: colors.secondary,
                    ),

                    SizedBox(
                      width: _spacing(base: 5),
                    ),

                    Flexible(
                      child: Text(
                        'Log in with One-Time Passcode',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: _font(
                            base: 11,
                            min: 9.5,
                            max: 13,
                          ),
                          fontWeight: FontWeight.w500,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            width: _spacing(base: 8),
          ),

          ScaleOnTap(
            onTap: widget.onBiometricLogin,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _spacing(base: 10),
                vertical: _spacing(base: 7),
              ),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.fingerprint_rounded,
                    size: _font(
                      base: 17,
                      min: 16,
                      max: 20,
                    ),
                    //color: colors.primary,
                  ),

                  SizedBox(
                    width: _spacing(base: 5),
                  ),

                  Text(
                    'Face ID',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: _font(
                        base: 11,
                        min: 10,
                        max: 13,
                      ),
                      fontWeight: FontWeight.w600,
                      color: colors.primary,
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

  // ===========================================================================
  // SIGN IN BUTTON
  // ===========================================================================

  Widget _buildSignInButton(ColorScheme colors) {
    return FadeScaleIn(
      duration: AppAnimations.medium,
      delay: const Duration(
        milliseconds: 570,
      ),
      beginScale: AppAnimations.scaleStart,
      child: ScaleOnTap(
        onTap: _isSubmitting ? null : _signIn,
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          height: _height(
            base: 56,
            min: 50,
            max: 60,
          ),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(
              _spacing(
                base: 12,
                min: 10,
                max: 14,
              ),
            ),
            border: Border.all(color: colors.outlineVariant),
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
          child: Center(
            child: AnimatedSwitcher(
              duration: AppAnimations.fast,
              switchInCurve: AppAnimations.enter,
              child: _isSubmitting
                  ? const SizedBox(
                key: ValueKey('login-loading'),
                child: BounceDots(),
              )
                  : Row(
                key: const ValueKey('login-button'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sign In to HomeX',
                    style: AppTextStyles.labelMedium.copyWith(
                      fontSize: _font(
                        base: 14,
                        min: 13,
                        max: 16,
                      ),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15,
                      color: colors.onPrimary,
                    ),
                  ),

                  SizedBox(
                    width: _spacing(base: 8),
                  ),

                  Icon(
                    Icons.lock_open_outlined,
                    size: _font(
                      base: 18,
                      min: 17,
                      max: 21,
                    ),
                    color: colors.onPrimary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // DIVIDER
  // ===========================================================================

  Widget _buildDivider(ColorScheme colors) {
    return FadeIn(
      duration: AppAnimations.normal,
      delay: const Duration(
        milliseconds: 650,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 1,
            color: colors.surfaceContainerHigh,
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: _spacing(base: 12),
            ),
            color: colors.surface,
            child: Text(
              'OR CONTINUE WITH',
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: _font(
                  base: 10,
                  min: 9,
                  max: 11.5,
                ),
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: colors.outline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SOCIAL LOGIN
  // ===========================================================================

  Widget _buildSocialLogin(ColorScheme colors) {
    return FadeScaleIn(
      duration: AppAnimations.medium,
      delay: const Duration(
        milliseconds: 700,
      ),
      beginScale: AppAnimations.scaleStart,
      child: Row(
        children: [
          Expanded(
            child: _SocialButton(
              icon: const _GoogleIcon(),
              label: 'Google',
              onTap: widget.onGoogleLogin,
            ),
          ),

          SizedBox(
            width: _spacing(base: 12),
          ),

          Expanded(
            child: _SocialButton(
              icon: Icon(
                Icons.apple,
                size: _font(
                  base: 20,
                  min: 18,
                  max: 22,
                ),
                color: colors.primary,
              ),
              label: 'Apple ID',
              onTap: widget.onAppleLogin,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // CREATE ACCOUNT
  // ===========================================================================

  Widget _buildRegistrationPrompt(ColorScheme colors) {
    return FadeIn(
      duration: AppAnimations.normal,
      delay: const Duration(
        milliseconds: 790,
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: _font(
                  base: 12,
                  min: 11,
                  max: 14,
                ),
                fontWeight: FontWeight.w500,
                color: colors.onSurfaceVariant,
              ),
            ),

            ScaleOnTap(
              onTap: widget.onCreateAccount,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 6,
                ),
                child: Text(
                  'Create Account',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: _font(
                      base: 12,
                      min: 11,
                      max: 14,
                    ),
                    fontWeight: FontWeight.w700,
                    color: colors.secondary,
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

  // ===========================================================================
  // SECURITY FOOTER
  // ===========================================================================

  Widget _buildSecurityFooter(ColorScheme colors) {
    return SlideFadeIn(
      direction: SlideDirection.bottom,
      distance: AppAnimations.slideSmall,
      duration: AppAnimations.medium,
      delay: const Duration(
        milliseconds: 850,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _spacing(base: 17),
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          border: Border(
            top: BorderSide(
              color: colors.outlineVariant.withValues(
                alpha: 0.30,
              ),
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shield_rounded,
                  size: _font(
                    base: 16,
                    min: 15,
                    max: 18,
                  ),
                  color: colors.secondary,
                ),

                SizedBox(
                  width: _spacing(base: 7),
                ),

                Flexible(
                  child: Text(
                    'SEC Regulated Partner',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: _font(
                        base: 10.5,
                        min: 9,
                        max: 12,
                      ),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.65,
                      color: colors.primary,
                    ),
                  ),
                ),

                SizedBox(
                  width: _spacing(base: 8),
                ),

                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.outlineVariant,
                    shape: BoxShape.circle,
                  ),
                ),

                SizedBox(
                  width: _spacing(base: 8),
                ),

                Flexible(
                  child: Text(
                    'NDIC Insured',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: _font(
                        base: 10.5,
                        min: 9,
                        max: 12,
                      ),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.65,
                      color: colors.primary,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: _spacing(base: 5),
            ),

            Text(
              'SEC Nigeria Regulated Sub-Broker & NDIC Insured Partner. HomeX Fintech Solutions Ltd. Protected with 256-bit institutional encryption.',
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: _font(
                  base: 9.5,
                  min: 8.5,
                  max: 11,
                ),
                height: 1.4,
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// HEADER BUTTON
// =============================================================================

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.icon,
    this.onTap,
  });

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
          color: colors.surfaceContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 22,
         // color: colors.primary,
        ),
      ),
    );
  }
}

// =============================================================================
// MODE TAB
// =============================================================================

class _ModeTab extends StatelessWidget {
  const _ModeTab({
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

    final width = context.widthPx;

    final fontSize = (width / 375 * 12.5)
        .clamp(10.5, 14.5)
        .toDouble();

    return ScaleOnTap(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.smooth,
        padding: EdgeInsets.symmetric(
          horizontal: 7,
          vertical: width < 340 ? 9 : 10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colors.surfaceContainerLowest
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: selected
              ? [
            BoxShadow(
              color: colors.shadow.withValues(
                alpha: 0.08,
              ),
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
                size: width < 340 ? 16 : 18,
                color: selected
                    ? colors.secondary
                    : colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(width: 6),

            Flexible(
              child: AnimatedDefaultTextStyle(
                duration: AppAnimations.fast,
                curve: AppAnimations.fastCurve,
                style: AppTextStyles.labelMedium.copyWith(
                  fontSize: fontSize,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: selected
                      ? colors.secondary
                      : colors.onSurfaceVariant,
                ),
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SOCIAL BUTTON
// =============================================================================

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final width = context.widthPx;

    return ScaleOnTap(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 48,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width < 340 ? 8 : 12,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(
            width < 340 ? 10 : 12,
          ),
          border: Border.all(
            color: colors.surfaceContainerHigh,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(
                alpha: 0.05,
              ),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,

            const SizedBox(width: 8),

            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelMedium.copyWith(
                  fontSize: (width / 375 * 12)
                      .clamp(10.5, 14.0)
                      .toDouble(),
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// GOOGLE ICON
// =============================================================================

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    final width = context.widthPx;

    return SizedBox(
      width: width < 340 ? 17 : 18,
      height: width < 340 ? 17 : 18,
      child: Center(
        child: Text(
          'G',
          style: TextStyle(
            fontSize: width < 340 ? 16 : 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }
}