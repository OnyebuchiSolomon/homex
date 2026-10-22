import 'package:homex/ui/global.dart';

class ResetTransactionPinScreen extends StatefulWidget {
  const ResetTransactionPinScreen({
    super.key,
    this.onBack,
    this.onHelp,
    this.onVerificationRequested,
    this.onTrusteeSupport,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final VoidCallback? onVerificationRequested;
  final VoidCallback? onTrusteeSupport;

  @override
  State<ResetTransactionPinScreen> createState() =>
      _ResetTransactionPinScreenState();
}

class _ResetTransactionPinScreenState extends State<ResetTransactionPinScreen> {
  final _formKey = GlobalKey<FormState>();

  final _bvnController = TextEditingController();
  final _dobController = TextEditingController(text: '14 / 08 / 1984');

  int _verificationMethod = 0;
  int _otpChannel = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _bvnController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _sendVerificationCode() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    setState(() => _isSubmitting = true);

    await Future<void>.delayed(const Duration(milliseconds: 650));

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    widget.onVerificationRequested?.call();

    if (widget.onVerificationRequested == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification code requested.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
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
            _ResetHeader(
              title: 'Reset Transaction PIN',
              subtitle: 'SEC & NDIC Escrow Custody',
              onBack: widget.onBack,
              onHelp: widget.onHelp,
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _ResetProgressCard(),
                        const SizedBox(height: 16),
                        const _SecurityAdvisoryCard(),
                        const SizedBox(height: 16),
                        _CredentialCard(
                          verificationMethod: _verificationMethod,
                          onMethodChanged: (value) {
                            setState(() => _verificationMethod = value);
                          },
                          bvnController: _bvnController,
                          dobController: _dobController,
                        ),
                        const SizedBox(height: 16),
                        _OtpChannelCard(
                          selectedChannel: _otpChannel,
                          onChanged: (value) {
                            setState(() => _otpChannel = value);
                          },
                        ),
                        const SizedBox(height: 16),
                        const _SafetyLockNotice(),
                        const SizedBox(height: 18),
                        _PrimaryButton(
                          loading: _isSubmitting,
                          icon: Icons.lock_reset,
                          label: 'Send Verification Code',
                          onPressed: _sendVerificationCode,
                        ),
                        const SizedBox(height: 10),
                        _SupportButton(
                          label:
                              'Need Escrow Trustee Assistance? Contact Diamond Concierge',
                          onPressed: widget.onTrusteeSupport,
                        ),
                        const SizedBox(height: 22),
                        const _ResetFooter(),
                      ],
                    ),
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

class _ResetHeader extends StatelessWidget {
  const _ResetHeader({
    required this.title,
    required this.subtitle,
    this.onBack,
    this.onHelp,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withValues(alpha: .3),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Go back',
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
            //color: colors.primary,
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                        color: colors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      subtitle,
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .6,
                        color: colors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Escrow support',
            onPressed: onHelp,
            icon: const Icon(Icons.help_outline),
            color: colors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PROGRESS
// ---------------------------------------------------------------------------

class _ResetProgressCard extends StatelessWidget {
  const _ResetProgressCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _Card(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Step 1 of 3',
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.secondary,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '•',
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Identity Reverification',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
                ),
              ),
              _Tag(
                text: 'Strict Multi-Factor',
                background: colors.tertiaryFixed,
                foreground: colors.onTertiaryFixed,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _ProgressSegment(active: true)),
              const SizedBox(width: 6),
              Expanded(child: _ProgressSegment(active: false)),
              const SizedBox(width: 6),
              Expanded(child: _ProgressSegment(active: false)),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StepLabel('1. BVN/NIN Auth', active: true),
              _StepLabel('2. OTP Clearance'),
              _StepLabel('3. Set New Key'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressSegment extends StatelessWidget {
  const _ProgressSegment({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: active ? colors.secondary : colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _StepLabel extends StatelessWidget {
  const _StepLabel(this.text, {this.active = false});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Flexible(
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.labelSmall.copyWith(
          fontSize: 10,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          color: active ? colors.secondary : colors.onSurfaceVariant,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECURITY ADVISORY
// ---------------------------------------------------------------------------

class _SecurityAdvisoryCard extends StatelessWidget {
  const _SecurityAdvisoryCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _Card(
      color: colors.surfaceContainerLow,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBox(
            icon: Icons.shield,
            background: colors.primaryContainer,
            foreground: colors.inversePrimary,
            size: 32,
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
                        'Tier 3 Multi-Factor Recovery',
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                    _Tag(
                      text: 'SEC-REG#714',
                      background: colors.surfaceContainer,
                      foreground: colors.onSurfaceVariant,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'To prevent unauthorized takeovers on active escrow accounts '
                  '(e.g. ₦450M limits & deed clearances), resetting your '
                  'cryptographic transaction key requires re-validating '
                  'statutory identity credentials.',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 11,
                    height: 1.55,
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Divider(
                  height: 1,
                  color: colors.outlineVariant.withValues(alpha: .4),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.verified, size: 15, color: colors.secondary),
                    const SizedBox(width: 6),
                    Text(
                      'Alexander Magnus',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.onSurface,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'ID: INV-NG-883920',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: colors.onSurfaceVariant,
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

// ---------------------------------------------------------------------------
// CREDENTIAL FORM
// ---------------------------------------------------------------------------

class _CredentialCard extends StatelessWidget {
  const _CredentialCard({
    required this.verificationMethod,
    required this.onMethodChanged,
    required this.bvnController,
    required this.dobController,
  });

  final int verificationMethod;
  final ValueChanged<int> onMethodChanged;
  final TextEditingController bvnController;
  final TextEditingController dobController;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Select Statutory Authority Method',
            style: AppTextStyles.labelSmall.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _MethodButton(
                    icon: Icons.account_balance,
                    label: 'BVN (Linked)',
                    selected: verificationMethod == 0,
                    onTap: () => onMethodChanged(0),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _MethodButton(
                    icon: Icons.badge_outlined,
                    label: 'NIMC (NIN)',
                    selected: verificationMethod == 1,
                    onTap: () => onMethodChanged(1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _FieldHeader(
            label: verificationMethod == 0
                ? 'Linked BVN Number'
                : 'Linked NIN Number',
            trailing: 'Central Bank Vault Synced',
            icon: Icons.lock,
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colors.outlineVariant.withValues(alpha: .6),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '2234',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: colors.primary,
                      ),
                    ),
                    Text(
                      '• • • •',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '8291',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter the missing 4 middle digits to confirm credential ownership:',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 11,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: bvnController,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 4,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: AppTextStyles.labelMedium.copyWith(
              fontFamily: 'monospace',
              color: colors.onSurface,
            ),
            decoration: _inputDecoration(
              context,
              hint: 'Enter middle 4 digits (e.g. 5942)',
              icon: Icons.pin,
            ).copyWith(counterText: ''),
            validator: (value) {
              if (value == null || value.length != 4) {
                return 'Enter the 4 missing digits';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          _FieldHeader(
            label: 'Date of Birth',
            trailing: 'Must match KYC record',
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: dobController,
            readOnly: true,
            onTap: () => _pickDate(context),
            style: AppTextStyles.labelMedium.copyWith(color: colors.onSurface),
            decoration: _inputDecoration(
              context,
              icon: Icons.calendar_today,
              suffix: Icon(
                Icons.check_circle,
                size: 18,
                color: colors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final initial = DateTime(1984, 8, 14);

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date == null) return;

    dobController.text =
        '${date.day.toString().padLeft(2, '0')} / '
        '${date.month.toString().padLeft(2, '0')} / '
        '${date.year}';
  }
}

// ---------------------------------------------------------------------------
// OTP CHANNEL
// ---------------------------------------------------------------------------

class _OtpChannelCard extends StatelessWidget {
  const _OtpChannelCard({
    required this.selectedChannel,
    required this.onChanged,
  });

  final int selectedChannel;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Security OTP Dispatch Channel',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
                ),
              ),
              Text(
                'Multi-Channel Protected',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _OtpChannelOption(
            selected: selectedChannel == 0,
            onTap: () => onChanged(0),
            title: 'Primary Verified Phone',
            tag: '~15s SMS',
            destination: '+234 803 ••• 4920',
            description:
                'Encrypted telco token delivery via MTN Tier-1 Gateway',
          ),
          const SizedBox(height: 8),
          _OtpChannelOption(
            selected: selectedChannel == 1,
            onTap: () => onChanged(1),
            title: 'Institutional Secure Email',
            tag: 'PGP Ready',
            destination: 'a•••••••s@homex.ng',
            description:
                'Dual-envelope authorization code sent to institutional address',
          ),
        ],
      ),
    );
  }
}

class _OtpChannelOption extends StatelessWidget {
  const _OtpChannelOption({
    required this.selected,
    required this.onTap,
    required this.title,
    required this.tag,
    required this.destination,
    required this.description,
  });

  final bool selected;
  final VoidCallback onTap;
  final String title;
  final String tag;
  final String destination;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: AppAnimations.standard,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? colors.primaryFixed.withValues(alpha: .2)
              : colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? colors.primary
                : colors.outlineVariant.withValues(alpha: .6),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<int>(
              value: selected ? 1 : 0,
              groupValue: 1,
              onChanged: (_) => onTap(),
              activeColor: colors.primary,
              visualDensity: VisualDensity.compact,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.labelSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colors.onSurface,
                          ),
                        ),
                      ),
                      _Tag(
                        text: tag,
                        background: colors.surfaceContainer,
                        foreground: colors.onSurfaceVariant,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    destination,
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? colors.primary
                          : colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 10.5,
                      height: 1.4,
                      color: colors.onSurfaceVariant,
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

// ---------------------------------------------------------------------------
// SAFETY NOTICE
// ---------------------------------------------------------------------------

class _SafetyLockNotice extends StatelessWidget {
  const _SafetyLockNotice();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.secondaryFixed.withValues(alpha: .3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.secondaryFixedDim.withValues(alpha: .6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_rounded, size: 20, color: colors.secondary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Escrow Security Notice: 12-Hour Safety Lock',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSecondaryFixed,
                  ),
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text:
                        'Upon successful PIN reset, all property milestone '
                        'disbursements over ',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 11,
                      height: 1.5,
                      color: colors.onSecondaryFixedVariant,
                    ),
                    children: [
                      TextSpan(
                        text: '₦10,000,000',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                          color: colors.onSecondaryFixed,
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' will be placed in a mandatory 12-hour '
                            'cooling-off safety lock unless manually '
                            'authorized via secondary trustee biometric override.',
                      ),
                    ],
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
// FOOTER
// ---------------------------------------------------------------------------

class _ResetFooter extends StatelessWidget {
  const _ResetFooter();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        Divider(color: colors.outlineVariant.withValues(alpha: .3)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_user, size: 14, color: colors.onSurfaceVariant),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'Protected by NDIC Escrow Custody Regulations & SEC Nigeria Digital Asset Guidelines',
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          'Zero plain-text credential retention • Cryptographic HSM isolation',
          textAlign: TextAlign.center,
          style: AppTextStyles.labelSmall.copyWith(
            fontSize: 9.5,
            fontFamily: 'monospace',
            color: colors.outline,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SHARED WIDGETS
// ---------------------------------------------------------------------------

class _Card extends StatelessWidget {
  const _Card({required this.child, this.color});

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: .45)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 1),
            color: Color(0x0A000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
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
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({
    required this.icon,
    required this.background,
    required this.foreground,
    this.size = 36,
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
      child: Icon(icon, size: size * .55, color: foreground),
    );
  }
}

class _MethodButton extends StatelessWidget {
  const _MethodButton({
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

    return Material(
      color: selected ? colors.surfaceContainerLowest : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 17,
                color: selected ? colors.primary : colors.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? colors.onSurface
                        : colors.onSurfaceVariant,
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

class _FieldHeader extends StatelessWidget {
  const _FieldHeader({required this.label, this.trailing, this.icon});

  final String label;
  final String? trailing;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
            ),
          ),
        ),
        if (trailing != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) Icon(icon, size: 12, color: colors.secondary),
              if (icon != null) const SizedBox(width: 3),
              Text(
                trailing!,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: colors.secondary,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

InputDecoration _inputDecoration(
  BuildContext context, {
  String? hint,
  IconData? icon,
  Widget? suffix,
}) {
  final colors = context.colors;

  return InputDecoration(
    hintText: hint,
    prefixIcon: icon == null ? null : Icon(icon, size: 18),
    suffixIcon: suffix,
    filled: true,
    fillColor: colors.surfaceContainerLowest,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colors.outlineVariant),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colors.outlineVariant),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colors.primary, width: 1.5),
    ),
  );
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: loading
            ? null
            : () => AppNavigator.pushAndStackNamed(
                AppRoutes.resetTransactionPinOtpScreen,
              ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.primary.withValues(alpha: .7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: colors.outlineVariant,),
          elevation: 2,
        ),
        child: loading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.onPrimary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    label,
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

class _SupportButton extends StatelessWidget {
  const _SupportButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.support_agent, size: 17, color: colors.secondary),
      label: Text(
        label,
        textAlign: TextAlign.center,
        style: AppTextStyles.labelSmall.copyWith(
          fontWeight: FontWeight.w600,
          color: colors.onSurfaceVariant,
        ),
      ),
    );
  }
}
