import 'package:homex/ui/global.dart';
class ChangeTransactionPinScreen extends StatefulWidget {
  const ChangeTransactionPinScreen({
    super.key,
    this.onBack,
    this.onHelp,
    this.onBiometric,
    this.onForgotPin,
    this.onPinUpdated,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final VoidCallback? onBiometric;
  final VoidCallback? onForgotPin;
  final ValueChanged<String>? onPinUpdated;

  @override
  State<ChangeTransactionPinScreen> createState() =>
      _ChangeTransactionPinScreenState();
}

class _ChangeTransactionPinScreenState
    extends State<ChangeTransactionPinScreen> {
  String _pin = '';
  bool _showPin = false;
  bool _isUpdating = false;

  bool get _hasSixDigits => _pin.length == 6;

  bool get _hasSequentialDigits {
    if (_pin.length < 6) return false;

    var ascending = true;
    var descending = true;

    for (var i = 1; i < _pin.length; i++) {
      final current = int.parse(_pin[i]);
      final previous = int.parse(_pin[i - 1]);

      if (current != previous + 1) {
        ascending = false;
      }

      if (current != previous - 1) {
        descending = false;
      }
    }

    return ascending || descending;
  }

  void _addDigit(String digit) {
    if (_pin.length >= 6) return;

    setState(() {
      _pin += digit;
    });
  }

  void _deleteDigit() {
    if (_pin.isEmpty) return;

    setState(() {
      _pin = _pin.substring(0, _pin.length - 1);
    });
  }

  Future<void> _updatePin() async {
    if (!_hasSixDigits) {
      _showMessage('Your new PIN must contain 6 digits.');
      return;
    }

    if (_hasSequentialDigits) {
      _showMessage('Sequential PINs such as 123456 are not allowed.');
      return;
    }

    setState(() => _isUpdating = true);

    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() => _isUpdating = false);

    widget.onPinUpdated?.call(_pin);
AppNavigator.pushAndStackNamed(AppRoutes.pinVerificationSuccessScreen);
    if (widget.onPinUpdated == null) {
      _showMessage('Transaction PIN updated successfully.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _biometric() {
    widget.onBiometric?.call();

    if (widget.onBiometric == null) {
      _showMessage('Biometric verification requested.');
    }
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
            _ChangePinHeader(
              onBack: widget.onBack,
              onHelp: widget.onHelp,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _ChangePinProgress(),
                      const SizedBox(height: 16),
                      const _ReauthenticationCard(),
                      const SizedBox(height: 12),
                      _BiometricButton(
                        onPressed: _biometric,
                      ),
                      const SizedBox(height: 16),
                      _PinInterfaceCard(
                        pin: _pin,
                        showPin: _showPin,
                        onToggleVisibility: () {
                          setState(() => _showPin = !_showPin);
                        },
                        onForgotPin: widget.onForgotPin,
                        hasSixDigits: _hasSixDigits,
                        hasSequentialDigits: _hasSequentialDigits,
                      ),
                      const SizedBox(height: 12),
                      _ChangePinButton(
                        loading: _isUpdating,
                        onPressed: _updatePin,
                      ),
                      const SizedBox(height: 12),
                      _NumericKeypad(
                        onDigit: _addDigit,
                        onDelete: _deleteDigit,
                        onBiometric: _biometric,
                      ),
                      const SizedBox(height: 14),
                      const _ChangePinFooter(),
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

class _ChangePinHeader extends StatelessWidget {
  const _ChangePinHeader({
    this.onBack,
    this.onHelp,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            IconButton(
              onPressed:
              onBack ?? () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back),
              color: colors.primary,
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Transaction PIN',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: colors.secondaryContainer,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'TIER 3 ESCROW SECURITY',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .8,
                          color: colors.secondary,
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
    );
  }
}

// ---------------------------------------------------------------------------
// PROGRESS
// ---------------------------------------------------------------------------

class _ChangePinProgress extends StatelessWidget {
  const _ChangePinProgress();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _ChangeCard(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Step 2 of 3',
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '• Enter New 6-Digit PIN',
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              _ChangeTag(
                icon: Icons.check_circle,
                text: 'Step 1 Verified',
                background: colors.tertiaryFixed,
                foreground: colors.onTertiaryFixed,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _Bar(
                  color: colors.primaryContainer,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _Bar(
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _Bar(
                  color: colors.surfaceContainerHigh,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1. Current PIN',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
              ),
              Text(
                '2. New Key',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  color: colors.primary,
                ),
              ),
              Text(
                '3. Confirm',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 9.5,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECURITY CARD
// ---------------------------------------------------------------------------

class _ReauthenticationCard extends StatelessWidget {
  const _ReauthenticationCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 2),
            color: Color(0x16000000),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest.withValues(
                alpha: .1,
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colors.onPrimary.withValues(alpha: .15),
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.shield,
              size: 23,
              color: colors.secondaryFixedDim,
            ),
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
                        'Re-authentication Required',
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colors.secondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'HSM 256',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: colors.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'To update your 6-digit escrow authorization key for '
                      'Lagos & Abuja milestone disbursements, authenticate your identity.',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 10.5,
                    height: 1.5,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BIOMETRIC
// ---------------------------------------------------------------------------

class _BiometricButton extends StatelessWidget {
  const _BiometricButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.fingerprint,
                  size: 21,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instant Biometric Unlock',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Auto-verify with Face ID / Touch ID',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 10,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Tap to verify',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: colors.secondary,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: colors.secondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PIN INTERFACE
// ---------------------------------------------------------------------------

class _PinInterfaceCard extends StatelessWidget {
  const _PinInterfaceCard({
    required this.pin,
    required this.showPin,
    required this.onToggleVisibility,
    required this.onForgotPin,
    required this.hasSixDigits,
    required this.hasSequentialDigits,
  });

  final String pin;
  final bool showPin;
  final VoidCallback onToggleVisibility;
  final VoidCallback? onForgotPin;
  final bool hasSixDigits;
  final bool hasSequentialDigits;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _ChangeCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colors.outlineVariant.withValues(alpha: .4),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.verified,
                  size: 19,
                  color: colors.onTertiaryContainer,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Escrow PIN Authenticated',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '• • • • • •',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontFamily: 'monospace',
                          letterSpacing: 2,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: onForgotPin,
                  child: Text(
                    'Change',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurfaceVariant,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Set New 6-Digit Escrow PIN',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'This authorizes all Land Title releases & milestone payments',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall.copyWith(
              fontSize: 10.5,
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          _PinDots(
            pin: pin,
            showPin: showPin,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton.icon(
                onPressed: onToggleVisibility,
                icon: Icon(
                  showPin
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 15,
                ),
                label: Text(
                  showPin ? 'Hide PIN' : 'Show PIN',
                ),
                style: TextButton.styleFrom(
                  foregroundColor: colors.onSurfaceVariant,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const Spacer(),
              Flexible(
                child: TextButton(
                  onPressed: onForgotPin,
                  child: Text(
                    'Forgot Current PIN?',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: colors.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _PinRequirements(
            hasSixDigits: hasSixDigits,
            hasSequentialDigits: hasSequentialDigits,
          ),
        ],
      ),
    );
  }
}

class _PinDots extends StatelessWidget {
  const _PinDots({
    required this.pin,
    required this.showPin,
  });

  final String pin;
  final bool showPin;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
            (index) {
          final filled = index < pin.length;
          final digit = filled ? pin[index] : '';

          return Padding(
            padding: EdgeInsets.only(
              right: index == 5 ? 0 : 10,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: AppAnimations.standard,
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: filled
                    ? colors.primary
                    : colors.surfaceContainerHigh,
                border: filled
                    ? null
                    : Border.all(
                  color: colors.outlineVariant,
                ),
                boxShadow: filled
                    ? [
                  BoxShadow(
                    color: colors.primaryFixed,
                    blurRadius: 0,
                    spreadRadius: 4,
                  ),
                ]
                    : null,
              ),
              alignment: Alignment.center,
              child: showPin && filled
                  ? Text(
                digit,
                style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w700,
                  color: colors.onPrimary,
                ),
              )
                  : null,
            ),
          );
        },
      ),
    );
  }
}

class _PinRequirements extends StatelessWidget {
  const _PinRequirements({
    required this.hasSixDigits,
    required this.hasSequentialDigits,
  });

  final bool hasSixDigits;
  final bool hasSequentialDigits;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: .4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.checklist,
                size: 15,
                color: colors.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                'ESCROW PIN REQUIREMENTS',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .5,
                  color: colors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          _Requirement(
            text: 'Minimum 6 numeric digits',
            satisfied: hasSixDigits,
          ),
          const SizedBox(height: 6),
          _Requirement(
            text: 'No sequential digits (123456)',
            satisfied: hasSixDigits && !hasSequentialDigits,
          ),
          const SizedBox(height: 6),
          const _Requirement(
            text: 'Different from BVN, NIN, birth year',
            satisfied: true,
          ),
          const SizedBox(height: 6),
          const _Requirement(
            text: 'Distinct from last 3 PINs',
            satisfied: false,
          ),
        ],
      ),
    );
  }
}

class _Requirement extends StatelessWidget {
  const _Requirement({
    required this.text,
    required this.satisfied,
  });

  final String text;
  final bool satisfied;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Icon(
          satisfied
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
          size: 15,
          color: satisfied
              ? colors.onTertiaryContainer
              : colors.outlineVariant,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: satisfied
                  ? colors.onSurface
                  : colors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// CTA
// ---------------------------------------------------------------------------

class _ChangePinButton extends StatelessWidget {
  const _ChangePinButton({
    required this.loading,
    required this.onPressed,
  });

  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: loading
            ? SizedBox(
          width: 19,
          height: 19,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colors.onPrimary,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 17),
            const SizedBox(width: 8),
            Text(
              'Verify & Update Transaction PIN',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// KEYPAD
// ---------------------------------------------------------------------------

class _NumericKeypad extends StatelessWidget {
  const _NumericKeypad({
    required this.onDigit,
    required this.onDelete,
    required this.onBiometric,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onDelete;
  final VoidCallback onBiometric;

  static const _keys = [
    ('1', ''),
    ('2', 'ABC'),
    ('3', 'DEF'),
    ('4', 'GHI'),
    ('5', 'JKL'),
    ('6', 'MNO'),
    ('7', 'PQRS'),
    ('8', 'TUV'),
    ('9', 'WXYZ'),
    ('', ''),
    ('0', '+'),
    ('', ''),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _ChangeCard(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _keys.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2.2,
        ),
        itemBuilder: (context, index) {
          final item = _keys[index];

          if (index == 9) {
            return _KeyButton(
              background: colors.surface,
              border: null,
              child: Icon(
                Icons.fingerprint,
                size: 24,
                color: colors.primary,
              ),
              onPressed: onBiometric,
            );
          }

          if (index == 11) {
            return _KeyButton(
              background: colors.surface,
              border: null,
              child: Icon(
                Icons.backspace,
                size: 23,
                color: colors.onSurfaceVariant,
              ),
              onPressed: onDelete,
            );
          }

          return _KeyButton(
            background: colors.surfaceContainerLow,
            border: BorderSide(
              color: colors.outlineVariant.withValues(alpha: .3),
            ),
            onPressed: () => onDigit(item.$1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.$1,
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
                ),
                Text(
                  item.$2.isEmpty ? '\u00A0' : item.$2,
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 8,
                    letterSpacing: 1,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _KeyButton extends StatelessWidget {
  const _KeyButton({
    required this.child,
    required this.onPressed,
    this.background,
    this.border,
  });

  final Widget child;
  final VoidCallback onPressed;
  final Color? background;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: border == null
                ? null
                : Border.fromBorderSide(border!),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// FOOTER
// ---------------------------------------------------------------------------

class _ChangePinFooter extends StatelessWidget {
  const _ChangePinFooter();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified,
                size: 13,
                color: colors.secondaryContainer,
              ),
              const SizedBox(width: 6),
              Text(
                'NDIC Escrow Custody Protected & SEC Nigeria Regulated',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'All cryptographic keys are isolated in Hardware Security Modules '
              '(FIPS 140-2 Level 3) with zero plain-text cloud logging.',
          textAlign: TextAlign.center,
          style: AppTextStyles.labelSmall.copyWith(
            fontSize: 9.5,
            height: 1.4,
            color: colors.outline,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// HELPERS
// ---------------------------------------------------------------------------

class _ChangeCard extends StatelessWidget {
  const _ChangeCard({
    required this.child,
    this.padding = const EdgeInsets.all(14),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: .5),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 1),
            color: Color(0x09000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ChangeTag extends StatelessWidget {
  const _ChangeTag({
    required this.icon,
    required this.text,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: foreground,
          ),
          const SizedBox(width: 3),
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}