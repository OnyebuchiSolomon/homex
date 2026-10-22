 import 'package:homex/ui/global.dart';

class ResetTransactionPinOtpScreen extends StatefulWidget {
  const ResetTransactionPinOtpScreen({
    super.key,
    this.onBack,
    this.onHelp,
    this.onProceed,
    this.onEmailFallback,
    this.onSupport,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final ValueChanged<String>? onProceed;
  final VoidCallback? onEmailFallback;
  final VoidCallback? onSupport;

  @override
  State<ResetTransactionPinOtpScreen> createState() =>
      _ResetTransactionPinOtpScreenState();
}

class _ResetTransactionPinOtpScreenState
    extends State<ResetTransactionPinOtpScreen> {
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();

  Timer? _timer;
  int _secondsRemaining = 288;

  @override
  void initState() {
    super.initState();

    _startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _otpFocusNode.requestFocus();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (!mounted) return;

        if (_secondsRemaining <= 0) {
          _timer?.cancel();
          return;
        }

        setState(() => _secondsRemaining--);
      },
    );
  }

  String get _timerText {
    final minutes = (_secondsRemaining ~/ 60)
        .toString()
        .padLeft(2, '0');

    final seconds = (_secondsRemaining % 60)
        .toString()
        .padLeft(2, '0');

    return '$minutes:$seconds';
  }

  double get _progress {
    const total = 300;
    return (_secondsRemaining / total).clamp(0, 1);
  }

  void _resendCode() {
    if (_secondsRemaining > 0) return;

    setState(() => _secondsRemaining = 300);
    _startTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new verification code has been sent.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _verifyOtp() {
    final otp = _otpController.text;

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter the complete 6-digit verification token.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
AppNavigator.pushAndStackNamed(AppRoutes.changeTransactionPinScreen);
    widget.onProceed?.call(otp);

    if (widget.onProceed == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP verified. Proceeding to set your new PIN.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _OtpHeader(
              onBack: widget.onBack,
              onHelp: widget.onHelp,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _OtpIdentityCard(),
                      const SizedBox(height: 16),
                      const _DispatchCard(),
                      const SizedBox(height: 16),
                      _OtpEntryCard(
                        controller: _otpController,
                        focusNode: _otpFocusNode,
                        timerText: _timerText,
                        progress: _progress,
                        canResend: _secondsRemaining <= 0,
                        onResend: _resendCode,
                      ),
                      const SizedBox(height: 16),
                      const _OtpSafetyCard(),
                      const SizedBox(height: 18),
                      _OtpPrimaryButton(
                        onPressed: _verifyOtp,
                      ),
                      const SizedBox(height: 8),
                      _OtpSupportButton(
                        onPressed: widget.onSupport,
                      ),
                      const SizedBox(height: 18),
                      const _OtpFooter(),
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
}

// ---------------------------------------------------------------------------
// HEADER
// ---------------------------------------------------------------------------

class _OtpHeader extends StatelessWidget {
  const _OtpHeader({
    this.onBack,
    this.onHelp,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: .96),
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withValues(alpha: .3),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            child: Row(
              children: [
                IconButton(
                  onPressed:
                  onBack ?? () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back),
                  color: colors.onSurface,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Reset Transaction PIN',
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colors.onTertiaryContainer,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'SEC & NDIC ESCROW CUSTODY',
                            style: AppTextStyles.labelSmall.copyWith(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onHelp,
                  icon: const Icon(Icons.help_outline),
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const _OtpStepper(),
        ],
      ),
    );
  }
}

class _OtpStepper extends StatelessWidget {
  const _OtpStepper();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      color: colors.surfaceContainerLowest.withValues(alpha: .65),
      child: Row(
        children: [
          Expanded(
            child: _OtpStep(
              number: '✓',
              title: '1. BVN/NIN',
              subtitle: 'Verified',
              complete: true,
            ),
          ),
          Container(
            width: 16,
            height: 2,
            color: colors.onTertiaryContainer,
          ),
          Expanded(
            child: _OtpStep(
              number: '2',
              title: '2. OTP Clearance',
              subtitle: 'In Progress',
              active: true,
            ),
          ),
          Container(
            width: 16,
            height: 2,
            color: colors.outlineVariant.withValues(alpha: .4),
          ),
          Expanded(
            child: Opacity(
              opacity: .45,
              child: _OtpStep(
                number: '3',
                title: '3. New Key',
                subtitle: 'Upcoming',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpStep extends StatelessWidget {
  const _OtpStep({
    required this.number,
    required this.title,
    required this.subtitle,
    this.active = false,
    this.complete = false,
  });

  final String number;
  final String title;
  final String subtitle;
  final bool active;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final background = complete
        ? colors.onTertiaryContainer
        : active
        ? colors.primary
        : colors.surfaceContainerHigh;

    final foreground = complete || active
        ? colors.surfaceContainerLowest
        : colors.onSurfaceVariant;

    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
            boxShadow: active
                ? [
              BoxShadow(
                color: colors.primary.withValues(alpha: .2),
                blurRadius: 0,
                spreadRadius: 2,
              ),
            ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: AppTextStyles.labelSmall.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: foreground,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10,
                  fontWeight: active || complete
                      ? FontWeight.w700
                      : FontWeight.w600,
                  color: active
                      ? colors.primary
                      : colors.onSurface,
                ),
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w600,
                  color: complete
                      ? colors.onTertiaryContainer
                      : active
                      ? colors.onPrimaryContainer
                      : colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// IDENTITY
// ---------------------------------------------------------------------------

class _OtpIdentityCard extends StatelessWidget {
  const _OtpIdentityCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _OtpCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'AM',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.onPrimary,
              ),
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
                        'Alexander Magnus',
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.verified,
                      size: 15,
                      color: colors.onTertiaryContainer,
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'ID: INV-NG-883920 • Tier 3 Institutional',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 10,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          _OtpTag(
            text: 'DIAMOND CUSTODY',
            background: colors.secondaryFixed,
            foreground: colors.onSecondaryFixed,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// DISPATCH
// ---------------------------------------------------------------------------

class _DispatchCard extends StatelessWidget {
  const _DispatchCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _OtpCard(
      radius: 16,
      child: Column(
        children: [
          Row(
            children: [
              _SmallIconBox(
                icon: Icons.mark_email_read,
                background: colors.tertiaryFixed,
                foreground: colors.onTertiaryFixed,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Encrypted OTP Dispatched',
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.labelMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colors.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: colors.onTertiaryContainer,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Statutory Multi-Factor Clearance',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 10.5,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _OtpTag(
                text: '#SEC-OTP-88219',
                background: colors.surfaceContainerHigh,
                foreground: colors.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colors.outlineVariant.withValues(alpha: .2),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.sms,
                      size: 15,
                      color: colors.onSurface,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Primary Verified Mobile:',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 10.5,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Text(
                      '+234 803 ••• 4920',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        color: colors.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Divider(
                  height: 1,
                  color: colors.outlineVariant.withValues(alpha: .2),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      size: 13,
                      color: colors.onTertiaryContainer,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'MTN Tier-1 Encrypted Gateway',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 9.5,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.bolt,
                      size: 12,
                      color: colors.onTertiaryContainer,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '~12s latency',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 9.5,
                        color: colors.onTertiaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Didn't receive SMS?",
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10.5,
                  color: colors.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward, size: 13),
                label: const Text('Send to institutional email'),
                style: TextButton.styleFrom(
                  foregroundColor: colors.primary,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// OTP ENTRY
// ---------------------------------------------------------------------------

class _OtpEntryCard extends StatelessWidget {
  const _OtpEntryCard({
    required this.controller,
    required this.focusNode,
    required this.timerText,
    required this.progress,
    required this.canResend,
    required this.onResend,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String timerText;
  final double progress;
  final bool canResend;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _OtpCard(
      radius: 16,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Enter 6-Digit Verification Token',
            textAlign: TextAlign.center,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Enter the one-time cryptographic code sent to your registered statutory channel.',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall.copyWith(
              fontSize: 10.5,
              height: 1.45,
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 1,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              maxLength: 6,
              textAlign: TextAlign.center,
              obscureText: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: const TextStyle(
                fontSize: 1,
                color: Colors.transparent,
              ),
              cursorColor: Colors.transparent,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (_) {},
            ),
          ),
          _OtpBoxes(controller: controller),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: 16,
                      color: colors.secondary,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Token validity window',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        timerText,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: colors.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(
                      colors.onTertiaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'No token received after countdown?',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 9.5,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: canResend ? onResend : null,
                      icon: const Icon(Icons.sync, size: 13),
                      label: Text(
                        canResend
                            ? 'Resend code'
                            : 'Resend in ${_resendSeconds()}s',
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor:
                        canResend
                            ? colors.primary
                            : colors.outlineVariant,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
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

  int _resendSeconds() {
    final seconds = (progress * 300).round();
    return seconds.clamp(0, 300);
  }
}

class _OtpBoxes extends StatelessWidget {
  const _OtpBoxes({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final value = controller.text;

    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = constraints.maxWidth < 350 ? 6.0 : 8.0;
        final width =
        ((constraints.maxWidth - (gap * 5)) / 6).clamp(38.0, 52.0);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
                (index) {
              final filled = index < value.length;
              final active = index == value.length;

              return Padding(
                padding: EdgeInsets.only(
                  right: index == 5 ? 0 : gap,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  curve: AppAnimations.standard,
                  width: width,
                  height: 56,
                  decoration: BoxDecoration(
                    color: filled
                        ? colors.surfaceContainerLowest
                        : colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: filled || active
                          ? colors.primary
                          : colors.outlineVariant,
                      width: filled || active ? 2 : 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    filled ? '•' : active ? '|' : '•',
                    style: TextStyle(
                      fontSize: filled ? 28 : 20,
                      fontWeight: FontWeight.w700,
                      color: filled
                          ? colors.onSurface
                          : active
                          ? colors.primary
                          : colors.outlineVariant,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// SAFETY
// ---------------------------------------------------------------------------

class _OtpSafetyCard extends StatelessWidget {
  const _OtpSafetyCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _OtpCard(
      color: colors.surfaceContainerLow,
      radius: 16,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SmallIconBox(
                icon: Icons.lock_clock,
                background: colors.secondaryFixed,
                foreground: colors.onSecondaryFixed,
                size: 26,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mandatory 12-Hour Escrow Safety Lock',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Upon PIN reset completion, statutory protection '
                          'automatically places a 12-hour cooling delay on real '
                          'estate disbursement withdrawals exceeding ₦10,000,000 '
                          'to prevent unauthorized account takeover attempts.',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 10.5,
                        height: 1.5,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            color: colors.outlineVariant.withValues(alpha: .2),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.enhanced_encryption,
                size: 13,
                color: colors.onTertiaryContainer,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'FIPS 140-2 Level 3 HSM Enclave',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 9.5,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                'Zero Plain-text Retention',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BUTTONS / FOOTER
// ---------------------------------------------------------------------------

class _OtpPrimaryButton extends StatelessWidget {
  const _OtpPrimaryButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: colors.outlineVariant,),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 18),
            const SizedBox(width: 8),
            Text(
              'Verify OTP & Proceed to Set Key',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.onPrimary,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 16),
          ],
        ),
      ),
    );
  }
}

class _OtpSupportButton extends StatelessWidget {
  const _OtpSupportButton({
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        Icons.support_agent,
        size: 16,
        color: colors.secondary,
      ),
      label: Text(
        'Having trouble? Contact Diamond Escrow Concierge',
        style: AppTextStyles.labelSmall.copyWith(
          fontWeight: FontWeight.w600,
          color: colors.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _OtpFooter extends StatelessWidget {
  const _OtpFooter();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        Divider(
          color: colors.outlineVariant.withValues(alpha: .2),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 5,
          children: [
            _FooterItem(
              icon: Icons.shield,
              text: 'NDIC Custody',
            ),
            _FooterItem(
              icon: Icons.account_balance,
              text: 'SEC Nigeria',
            ),
            _FooterItem(
              icon: Icons.verified,
              text: 'CBN Regulated Gateway',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Protected under NDIC Escrow Custody Regulations & SEC Nigeria Digital Asset Guidelines.',
          textAlign: TextAlign.center,
          style: AppTextStyles.labelSmall.copyWith(
            fontSize: 9.5,
            height: 1.4,
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _FooterItem extends StatelessWidget {
  const _FooterItem({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 12,
          color: colors.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.labelSmall.copyWith(
            fontSize: 9.5,
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// HELPERS
// ---------------------------------------------------------------------------

class _OtpCard extends StatelessWidget {
  const _OtpCard({
    required this.child,
    this.color,
    this.radius = 12,
    this.padding = const EdgeInsets.all(12),
  });

  final Widget child;
  final Color? color;
  final double radius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: .4),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 1),
            color: Color(0x08000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _OtpTag extends StatelessWidget {
  const _OtpTag({
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          fontSize: 8.5,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}

class _SmallIconBox extends StatelessWidget {
  const _SmallIconBox({
    required this.icon,
    required this.background,
    required this.foreground,
    this.size = 32,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: size * .55,
        color: foreground,
      ),
    );
  }
}