 import 'package:homex/ui/global.dart';
class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({
    super.key,
    this.contact = '+234 803 ••• 4920',
    this.onBack,
    this.onHelp,
    this.onEditContact,
    this.onResendCode,
    this.onVerify,
    this.onBiometric,
  });

  final String contact;

  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final VoidCallback? onEditContact;
  final VoidCallback? onResendCode;
  final Future<void> Function(String otp)? onVerify;
  final VoidCallback? onBiometric;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  static const int _otpLength = 6;
  static const int _initialSeconds = 45;

  final List<String> _digits = List.filled(_otpLength, '');

  int _activeIndex = 0;
  int _remainingSeconds = _initialSeconds;

  Timer? _timer;

  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // TIMER
  // ---------------------------------------------------------------------------

  void _startTimer() {
    _timer?.cancel();

    setStateIfMounted(() {
      _remainingSeconds = _initialSeconds;
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (_remainingSeconds <= 1) {
          timer.cancel();

          setState(() {
            _remainingSeconds = 0;
          });

          return;
        }

        setState(() {
          _remainingSeconds--;
        });
      },
    );
  }

  void _resendCode() {
    if (_remainingSeconds > 0) return;

    widget.onResendCode?.call();

    _clearOtp();
    _startTimer();
  }

  // ---------------------------------------------------------------------------
  // OTP
  // ---------------------------------------------------------------------------

  String get _otp => _digits.join();

  bool get _isComplete {
    return _digits.every((digit) => digit.isNotEmpty);
  }

  void _enterDigit(String digit) {
    if (_isVerifying) return;

    if (_activeIndex >= _otpLength) return;

    setState(() {
      _digits[_activeIndex] = digit;

      if (_activeIndex < _otpLength - 1) {
        _activeIndex++;
      }
    });

    if (_isComplete) {
      FocusScope.of(context).unfocus();
    }
  }

  void _deleteDigit() {
    if (_isVerifying) return;

    setState(() {
      if (_digits[_activeIndex].isNotEmpty) {
        _digits[_activeIndex] = '';
      } else if (_activeIndex > 0) {
        _activeIndex--;
        _digits[_activeIndex] = '';
      }
    });
  }

  void _selectDigit(int index) {
    if (_isVerifying) return;

    setState(() {
      _activeIndex = index;
    });
  }

  void _clearOtp() {
    setState(() {
      for (var i = 0; i < _digits.length; i++) {
        _digits[i] = '';
      }

      _activeIndex = 0;
    });
  }

  Future<void> _verifyOtp(Set<String> role) async {
     if (_isVerifying) return;

    if (!_isComplete) {
      _showMessage('Please enter the complete 6-digit code.');
      return;
    }

    //if (widget.onVerify == null) return;

    setState(() {
      _isVerifying = true;
    });
     AppNavigator.pushAndStackNamed(AppRoutes.accountVerifiedScreen,arguments: {
       "role":role
     });
    try {
      await widget.onVerify!(_otp);

    } finally {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  void setStateIfMounted(VoidCallback callback) {
    if (mounted) {
      setState(callback);
    }
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
              color: colors.onPrimary,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  String get _formattedTimer {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
       // top: true,
        bottom: true,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 448,
            ),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
SizedBox(height: 20,),
                  _buildTopBar(colors),
                  Expanded(
                    child: _buildContent(colors,role),
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
  // TOP BAR
  // ---------------------------------------------------------------------------

  Widget _buildTopBar(ColorScheme colors) {
    return Container(
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(
      //  color: colors.surfaceContainerLow,
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _PressScale(
                  onTap: widget.onBack,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      onPressed: ()=> Navigator.of(context).maybePop(),
                      padding: EdgeInsets.zero,
                      splashRadius: 20,
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24,

                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _SoftFade(
                  delay: AppAnimations.shortDelay,
                  child: Text(
                    'HomeX',
                    style: AppTextStyles.headlineMedium.copyWith(
                      // color: colors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
            _PressScale(
              onTap: widget.onHelp,
              child: TextButton(
                onPressed: widget.onHelp,
                style: TextButton.styleFrom(
                  foregroundColor: colors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Text(
                  'Help',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
  // MAIN CONTENT
  // ---------------------------------------------------------------------------

  Widget _buildContent(ColorScheme colors, Set<String>role) {
    final width = MediaQuery.sizeOf(context).width;

    final horizontalPadding = width < 360 ? 16.0 : 20.0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          0,
          horizontalPadding,
          24,
        ),
        child: Column(
          children: [
            _SoftFade(
              delay: Duration.zero,
              child: _buildProgress(colors),
            ),

            const SizedBox(height: 24),

            _SoftFade(
              delay: const Duration(milliseconds: 70),
              child: _buildHeader(colors),
            ),

            const SizedBox(height: 24),

            _SoftFade(
              delay: const Duration(milliseconds: 130),
              child: _buildContactCard(colors),
            ),

            const SizedBox(height: 24),

            _SoftFade(
              delay: const Duration(milliseconds: 190),
              child: _buildOtpArea(colors),
            ),

            const SizedBox(height: 20),

            _SoftFade(
              delay: const Duration(milliseconds: 250),
              child: _buildKeypad(colors),
            ),

            const SizedBox(height: 20),

            _SoftFade(
              delay: const Duration(milliseconds: 290),
              child: _buildVerifyButton(colors,role),
            ),

            const SizedBox(height: 16),

            _SoftFade(
              delay: const Duration(milliseconds: 330),
              child: _buildTrustNotice(colors),
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step 3 of 3',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.secondary,
                fontSize: 11,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: colors.tertiaryFixed,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Final Stage',
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.onTertiaryFixed,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Container(
            height: 6,
            width: double.infinity,
            color: colors.surfaceContainerHighest,
            child: AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 700),
              curve: AppAnimations.smooth,
              widthFactor: 1,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------

  Widget _buildHeader(ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Verification Code',
          style: AppTextStyles.headlineMedium.copyWith(
            color: colors.onSurface,
            fontSize: 24,
            height: 32 / 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a 6-digit OTP code to your registered contact.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: colors.onSurfaceVariant,
            fontSize: 14,
            height: 21 / 14,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // CONTACT CARD
  // ---------------------------------------------------------------------------

  Widget _buildContactCard(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.04),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 20,
              // color: colors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'TARGET DESTINATION',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.onSurfaceVariant,
                        fontSize: 9,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: colors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  widget.contact,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          _PressScale(
            onTap: widget.onEditContact,
            child: TextButton(
              onPressed: widget.onEditContact,
              style: TextButton.styleFrom(
                foregroundColor: colors.secondary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Edit contact',
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.secondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // OTP
  // ---------------------------------------------------------------------------

  Widget _buildOtpArea(ColorScheme colors) {
    return Column(
      children: [
        _buildOtpBoxes(colors),

        const SizedBox(height: 20),

        _buildTimer(colors),

        const SizedBox(height: 8),

        _buildResendText(colors),
      ],
    );
  }

  Widget _buildOtpBoxes(ColorScheme colors) {
    return Row(
      children: List.generate(
        _otpLength,
            (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index == _otpLength - 1 ? 0 : 6,
              ),
              child: _OtpBox(
                key: ValueKey('otp_$index'),
                value: _digits[index],
                active: _activeIndex == index,
                onTap: () => _selectDigit(index),
                colors: colors,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimer(ColorScheme colors) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: AppAnimations.smooth,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 16,
            color: colors.onSurfaceVariant,
          ),
          const SizedBox(width: 6),
          Text(
            'Resend code in ',
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Text(
              _formattedTimer,
              key: ValueKey(_remainingSeconds),
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.secondary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResendText(ColorScheme colors) {
    final canResend = _remainingSeconds == 0;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          "Didn't receive code? ",
          style: AppTextStyles.labelSmall.copyWith(
            color: colors.onSurfaceVariant,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: canResend ? _resendCode : null,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            curve: AppAnimations.smooth,
            style: AppTextStyles.labelSmall.copyWith(
              color: canResend
                  ? colors.primary
                  : colors.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              decoration: canResend
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
            child: const Text(
              'Send via SMS / WhatsApp',
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // KEYPAD
  // ---------------------------------------------------------------------------

  Widget _buildKeypad(ColorScheme colors) {
    final keys = <_KeypadItem>[
      const _KeypadItem.number('1'),
      const _KeypadItem.number('2'),
      const _KeypadItem.number('3'),
      const _KeypadItem.number('4'),
      const _KeypadItem.number('5'),
      const _KeypadItem.number('6'),
      const _KeypadItem.number('7'),
      const _KeypadItem.number('8'),
      const _KeypadItem.number('9'),
      const _KeypadItem.icon(Icons.fingerprint),
      const _KeypadItem.number('0'),
      const _KeypadItem.icon(Icons.backspace_outlined),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 48,
      ),
      itemBuilder: (context, index) {
        final item = keys[index];

        return _KeypadButton(
          item: item,
          colors: colors,
          onTap: () {
            if (item.icon == Icons.fingerprint) {
              widget.onBiometric?.call();
              return;
            }

            if (item.icon == Icons.backspace_outlined) {
              _deleteDigit();
              return;
            }

            if (item.number != null) {
              _enterDigit(item.number!);
            }
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // VERIFY BUTTON
  // ---------------------------------------------------------------------------

  Widget _buildVerifyButton(ColorScheme colors, Set<String> role) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: _PressScale(
        onTap: /*_isVerifying ? null :*/ ()=>_verifyOtp(role),
        child: ElevatedButton(
          onPressed:  /*_isVerifying ? null :*/ ()=>_verifyOtp(role),
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
            side: BorderSide(
              color: colors.outlineVariant,
            ),
            disabledBackgroundColor:
            colors.primary.withValues(alpha: 0.55),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: _isVerifying
                ? SizedBox(
              key: const ValueKey('loading'),
              width: 19,
              height: 19,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  colors.onPrimary,
                ),
              ),
            )
                : Row(
              key: const ValueKey('verify'),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 19,
                  color: colors.onPrimary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Verify & Activate Account',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.onPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TRUST NOTICE
  // ---------------------------------------------------------------------------

  Widget _buildTrustNotice(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.verified_user,
            size: 15,
            color: colors.secondary,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              'Bank-grade encryption powered by NIBSS & SEC compliant gateway.',
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.onSurfaceVariant,
                fontSize: 9.5,
                height: 13 / 9.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// OTP BOX
// ============================================================================

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    super.key,
    required this.value,
    required this.active,
    required this.onTap,
    required this.colors,
  });

  final String value;
  final bool active;
  final VoidCallback onTap;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: AppAnimations.smooth,
        height: 56,
        decoration: BoxDecoration(
          color: value.isEmpty && !active
              ? colors.surfaceContainerLow
              : colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active
                ? colors.secondary
                : colors.outlineVariant,
            width: active ? 2 : 1.5,
          ),
          boxShadow: [
            if (active)
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.08),
                blurRadius: 0,
                spreadRadius: 2,
              )
            else
              BoxShadow(
                color: colors.shadow.withValues(alpha: 0.035),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            switchInCurve: AppAnimations.enter,
            switchOutCurve: AppAnimations.exit,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.92,
                    end: 1,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: value.isNotEmpty
                ? Text(
              value,
              key: ValueKey(value),
              style: AppTextStyles.headlineSmall.copyWith(
                color: colors.secondary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            )
                : active
                ? const _BlinkingCursor(
              key: ValueKey('cursor'),
            )
                : Container(
              key: const ValueKey('empty'),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: colors.outlineVariant,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// BLINKING CURSOR
// ============================================================================

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor({
    super.key,
  });

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.2,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      ),
      child: Container(
        width: 2,
        height: 24,
        color: colors.primary,
      ),
    );
  }
}

// ============================================================================
// KEYPAD
// ============================================================================

class _KeypadItem {
  const _KeypadItem.number(this.number) : icon = null;

  const _KeypadItem.icon(this.icon) : number = null;

  final String? number;
  final IconData? icon;
}

class _KeypadButton extends StatefulWidget {
  const _KeypadButton({
    required this.item,
    required this.colors,
    required this.onTap,
  });

  final _KeypadItem item;
  final ColorScheme colors;
  final VoidCallback onTap;

  @override
  State<_KeypadButton> createState() => _KeypadButtonState();
}

class _KeypadButtonState extends State<_KeypadButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isAction = widget.item.icon != null;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: isAction
                ? widget.colors.surfaceContainerLow
                : widget.colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
            border: isAction
                ? null
                : Border.all(
              color: widget.colors.outlineVariant,
            ),
          ),
          child: Center(
            child: widget.item.number != null
                ? Text(
              widget.item.number!,
              style: AppTextStyles.labelMedium.copyWith(
                color: widget.colors.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            )
                : Icon(
              widget.item.icon,
              size: 21,
              color: widget.colors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SUBTLE SCREEN ANIMATION
// ============================================================================

class _SoftFade extends StatefulWidget {
  const _SoftFade({
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 480),
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  State<_SoftFade> createState() => _SoftFadeState();
}

class _SoftFadeState extends State<_SoftFade>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.enter,
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.008),
      end: Offset.zero,
    ).animate(curve);

    _start();
  }

  Future<void> _start() async {
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }

    if (!mounted) return;

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ============================================================================
// PRESS FEEDBACK
// ============================================================================

class _PressScale extends StatefulWidget {
  const _PressScale({
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<_PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<_PressScale> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap == null
          ? null
          : (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: widget.onTap == null
          ? null
          : (_) {
        setState(() {
          _pressed = false;
        });
      },
      onTapCancel: widget.onTap == null
          ? null
          : () {
        setState(() {
          _pressed = false;
        });
      },
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}