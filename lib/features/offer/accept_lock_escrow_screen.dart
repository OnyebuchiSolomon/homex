 import 'package:homex/ui/global.dart';

class AcceptLockEscrowScreen extends StatefulWidget {
  const AcceptLockEscrowScreen({
    super.key,
    this.onBack,
    this.onCancel,
    this.onViewContract,
    this.onDownloadReceipt,
    this.onReturnToDashboard,
    this.onBiometric,
  });

  final VoidCallback? onBack;
  final VoidCallback? onCancel;
  final VoidCallback? onViewContract;
  final VoidCallback? onDownloadReceipt;
  final VoidCallback? onReturnToDashboard;
  final VoidCallback? onBiometric;

  @override
  State<AcceptLockEscrowScreen> createState() =>
      _AcceptLockEscrowScreenState();
}

class _AcceptLockEscrowScreenState extends State<AcceptLockEscrowScreen> {
  static const String _propertyImage =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDdQWuuWT1kUFXYoCCuLkADlmlbeKP94oOCKZrI1zLdzMMsc17rJtGuc1atRsISZUzaOKQiCun_T9_jW3KxKSaFwFy3V1VGqVY4TbNgT21q1Nw_K2ILGEnKyWv1QNLc83WNDO-5TBU-HG7n4fYuY-gDc_Fe4cSLI5oPRo_E9SIR7GErnS3_Eu0C5aP5V6qyIPe3Iq8xQxsGG_KvDFcQIIeBwyCoYxGv_Y0nfePTf7oiipCrvw3wjMaX';

  final List<String> _pin = <String>[];
  bool _statutoryConsent = true;
  bool _isProcessing = false;
  bool _showSuccess = false;

  String get _pinValue => _pin.join();

  bool get _canConfirm =>
      _pin.length == 6 && _statutoryConsent && !_isProcessing;

  void _addDigit(String digit) {
    if (_pin.length >= 6) return;

    setState(() {
      _pin.add(digit);
    });
  }

  void _removeDigit() {
    if (_pin.isEmpty) return;

    setState(() {
      _pin.removeLast();
    });
  }

  void _useBiometric() {
    widget.onBiometric?.call();

    _showMessage('Biometric authentication requested.');
  }

  Future<void> _confirmEscrow() async {
    FocusScope.of(context).unfocus();

    if (!_statutoryConsent) {
      _showMessage('Please confirm the statutory authorization.');
      return;
    }

    if (_pin.length != 6) {
      _showMessage('Enter your 6-digit transaction PIN.');
      return;
    }

    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    await Future<void>.delayed(
      AppAnimations.mediumDelay,
    );

    if (!mounted) return;

    setState(() {
      _isProcessing = false;
      _showSuccess = true;
    });
  }

  void _closeSuccess() {
    if (!mounted) return;

    setState(() {
      _showSuccess = false;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 448,
                ),
                child: Column(
                  children: [
                    _buildTopBar(
                      colors,
                      textTheme,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          12,
                          16,
                          40,
                        ),
                        child: Column(
                          children: [
                            _buildLegalProtocolCard(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 16),
                            _buildPropertyPreview(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 16),
                            _buildOfferTerms(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 16),
                            _buildCustodyRails(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 16),
                            _buildAuthorizationCard(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 12),
                            _buildStatutoryConsent(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 8),
                            _buildActions(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 10),
                            _buildRegulatoryFooter(
                              colors,
                              textTheme,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_showSuccess)
              Positioned.fill(
                child: _SuccessOverlay(
                  colors: colors,
                  textTheme: textTheme,
                  onClose: _closeSuccess,
                  onViewContract: widget.onViewContract,
                  onDownloadReceipt: widget.onDownloadReceipt,
                  onReturnToDashboard: () {
                    _closeSuccess();
                    widget.onReturnToDashboard?.call();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.94),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _IconButton(
            icon: Icons.arrow_back,
            tooltip: 'Back',
            onPressed: widget.onBack,
            colors: colors,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Accept & Lock Escrow',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.primary,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '#LX-1092 • Lekki Duplex',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_user,
                    size: 15,
                    color: colors.secondary,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      'SEC Regulated',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
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

  Widget _buildLegalProtocolCard(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.secondaryFixedDim.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 1),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colors.secondary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.gpp_good,
              size: 21,
              color: colors.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 250;

                    if (compact) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _protocolLabel(colors, textTheme),
                          const SizedBox(height: 5),
                          _ruleBadge(colors, textTheme),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: _protocolLabel(colors, textTheme),
                        ),
                        const SizedBox(width: 6),
                        _ruleBadge(colors, textTheme),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      height: 1.45,
                      color: colors.onSurfaceVariant,
                    ),
                    children: [
                      const TextSpan(
                        text:
                        'Accepting this offer locks the earnest deposit directly in the ',
                      ),
                      TextSpan(
                        text: 'Stanbic IBTC Escrow Vault',
                        style: TextStyle(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(
                        text:
                        '. This triggers immediate legal conveyancing and freezes secondary bidding.',
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

  Widget _protocolLabel(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Text(
      'Binding Legal Protocol',
      style: textTheme.labelMedium?.copyWith(
        color: colors.secondary,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _ruleBadge(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: colors.secondary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Rule 184(b)',
        style: textTheme.labelSmall?.copyWith(
          color: colors.secondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPropertyPreview(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _SurfaceCard(
      colors: colors,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: SizedBox(
              width: 64,
              height: 64,
              child: Image.network(
                _propertyImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: colors.surfaceContainer,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.home_work_outlined,
                      color: colors.onSurfaceVariant,
                    ),
                  );
                },
                loadingBuilder: (
                    context,
                    child,
                    loadingProgress,
                    ) {
                  if (loadingProgress == null) return child;

                  return Container(
                    color: colors.surfaceContainer,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.secondary,
                      ),
                    ),
                  );
                },
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
                        'LEKKI PHASE 1',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.secondary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        '• Outright Purchase',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.outline,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Contemporary 4-Bed Smart Detached Duplex',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Admiralty Way, Lekki Phase 1, Lagos State',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferTerms(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _SurfaceCard(
      colors: colors,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            icon: Icons.receipt_long_outlined,
            title: 'Agreed Offer Terms',
            badge: 'Verified Buyer',
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Agreed Purchase Price',
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 3),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '₦115,000,000.00',
                              style: textTheme.headlineSmall?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.6,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Gross Value',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _TermRow(
            label: 'Buyer Identity',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'Adeola Balogun',
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.check_circle,
                  size: 15,
                  color: colors.secondary,
                ),
              ],
            ),
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 8),
          _TermRow(
            label: 'Verification Metric',
            trailing: Text(
              'REAN Verified • 94% Trust Score • Tier 3',
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            colors: colors,
            textTheme: textTheme,
            compact: true,
          ),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: colors.surfaceContainerHigh,
          ),
          const SizedBox(height: 12),
          _TermRow(
            label: 'Earnest Deposit (10%)',
            subLabel: 'Escrow Lock Amount',
            trailing: Text(
              '₦11,500,000.00',
              style: textTheme.bodyMedium?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 12),
          _TermRow(
            label: 'Closing Balance (90%)',
            subLabel: "Upon Governor's Consent Handover",
            trailing: Text(
              '₦103,500,000.00',
              style: textTheme.labelMedium?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 12),
          _TermRow(
            label: 'Timeline to Final Close',
            trailing: Text(
              '14 Business Days',
              style: textTheme.labelMedium?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(6),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 280;

                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _commissionLabel(colors, textTheme),
                      const SizedBox(height: 4),
                      _commissionValue(colors, textTheme),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: _commissionLabel(colors, textTheme),
                    ),
                    _commissionValue(colors, textTheme),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _commissionLabel(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Row(
      children: [
        Icon(
          Icons.savings_outlined,
          size: 15,
          color: colors.secondary,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            'HomeX Direct Deal Commission',
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _commissionValue(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Text(
      '₦0.00 (0%)',
      style: textTheme.labelMedium?.copyWith(
        color: colors.tertiary,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildCustodyRails(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_outlined,
                size: 19,
                color: colors.secondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'DESIGNATED ESCROW CUSTODY RAILS',
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.65,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 320) {
                return Column(
                  children: [
                    _CustodyCard(
                      title: 'Escrow Trustee',
                      value: 'Stanbic IBTC Trustees',
                      subValue: 'Providus Bank Rail',
                      colors: colors,
                      textTheme: textTheme,
                    ),
                    const SizedBox(height: 8),
                    _CustodyCard(
                      title: 'Statutory Insurance',
                      value: 'NDIC Insured',
                      subValue: 'SEC Rule Safeguard',
                      highlight: true,
                      colors: colors,
                      textTheme: textTheme,
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _CustodyCard(
                      title: 'Escrow Trustee',
                      value: 'Stanbic IBTC Trustees',
                      subValue: 'Providus Bank Rail',
                      colors: colors,
                      textTheme: textTheme,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _CustodyCard(
                      title: 'Statutory Insurance',
                      value: 'NDIC Insured',
                      subValue: 'SEC Rule Safeguard',
                      highlight: true,
                      colors: colors,
                      textTheme: textTheme,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 9),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                size: 15,
                color: colors.outline,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '48-Hour structural walkthrough window included post-lock.',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorizationCard(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _SurfaceCard(
      colors: colors,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_person_outlined,
              size: 23,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Authorize Escrow Lock',
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 320,
            ),
            child: Text(
              'Enter your 6-digit transaction PIN or authenticate biometrically to legally execute and lock this agreement.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                height: 1.45,
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildPinIndicators(
            colors,
          ),
          const SizedBox(height: 14),
          _buildBiometricButton(
            colors,
            textTheme,
          ),
          const SizedBox(height: 14),
          _buildKeypad(
            colors,
            textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildPinIndicators(ColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
            (index) {
          final filled = index < _pin.length;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            width: 14,
            height: 14,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled
                  ? colors.primary
                  : colors.surfaceContainerHighest,
              border: filled
                  ? null
                  : Border.all(
                color: colors.outline,
              ),
              boxShadow: filled
                  ? [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.16),
                  blurRadius: 0,
                  spreadRadius: 2,
                ),
              ]
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBiometricButton(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Material(
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: _useBiometric,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 7,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fingerprint,
                size: 18,
                color: colors.secondary,
              ),
              const SizedBox(width: 7),
              Text(
                'Use Face ID / Touch ID',
                style: textTheme.labelMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    final keys = <_KeypadKey>[
      const _KeypadKey.number('1'),
      const _KeypadKey.number('2'),
      const _KeypadKey.number('3'),
      const _KeypadKey.number('4'),
      const _KeypadKey.number('5'),
      const _KeypadKey.number('6'),
      const _KeypadKey.number('7'),
      const _KeypadKey.number('8'),
      const _KeypadKey.number('9'),
      const _KeypadKey.biometric(),
      const _KeypadKey.number('0'),
      const _KeypadKey.backspace(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final keypadWidth = constraints.maxWidth.clamp(
          220.0,
          280.0,
        );

        return SizedBox(
          width: keypadWidth,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: keys.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.25,
            ),
            itemBuilder: (context, index) {
              final key = keys[index];

              return _KeypadButton(
                keyData: key,
                colors: colors,
                textTheme: textTheme,
                onPressed: () {
                  switch (key.type) {
                    case _KeypadType.number:
                      _addDigit(key.value!);
                    case _KeypadType.backspace:
                      _removeDigit();
                    case _KeypadType.biometric:
                      _useBiometric();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStatutoryConsent(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Checkbox(
              value: _statutoryConsent,
              onChanged: (value) {
                setState(() {
                  _statutoryConsent = value ?? false;
                });
              },
              activeColor: colors.primary,
              checkColor: colors.onPrimary,
              side: BorderSide(
                color: colors.outline,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _statutoryConsent = !_statutoryConsent;
                });
              },
              child: Text(
                'I confirm acceptance of ₦115M offer terms and authorize '
                    'Stanbic IBTC Escrow Custody to freeze earnest funds under '
                    'SEC Rule 184(b).',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  height: 1.45,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _canConfirm ? _confirmEscrow : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              disabledBackgroundColor:
              colors.surfaceContainerHighest,
              disabledForegroundColor: colors.outline,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              elevation: 2,
              shadowColor: colors.shadow.withValues(alpha: 0.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isProcessing
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
                Icon(
                  Icons.lock,
                  size: 19,
                  color: colors.onPrimary,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Confirm & Lock Escrow (₦115,000,000)',
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: widget.onCancel,
            style: TextButton.styleFrom(
              foregroundColor: colors.onSurfaceVariant,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 11,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancel & Return to Offer Review',
              textAlign: TextAlign.center,
              style: textTheme.labelMedium?.copyWith(
                color: colors.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegulatoryFooter(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        'HomeX Escrow Custody Network • Licensed by SEC Nigeria • '
            'NDIC Insured Partner Trust',
        textAlign: TextAlign.center,
        style: textTheme.labelSmall?.copyWith(
          color: colors.outline,
          fontSize: 10,
          height: 1.4,
          letterSpacing: -0.05,
        ),
      ),
    );
  }
}

// ============================================================
// SUCCESS OVERLAY
// ============================================================

class _SuccessOverlay extends StatefulWidget {
  const _SuccessOverlay({
    required this.colors,
    required this.textTheme,
    required this.onClose,
    required this.onViewContract,
    required this.onDownloadReceipt,
    required this.onReturnToDashboard,
  });

  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onClose;
  final VoidCallback? onViewContract;
  final VoidCallback? onDownloadReceipt;
  final VoidCallback onReturnToDashboard;

  @override
  State<_SuccessOverlay> createState() => _SuccessOverlayState();
}

class _SuccessOverlayState extends State<_SuccessOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.96,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;
    final textTheme = widget.textTheme;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        color: colors.scrim.withValues(alpha: 0.62),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 390,
            ),
            child: Material(
              color: colors.surfaceContainerLowest,
              elevation: 24,
              shadowColor: colors.shadow.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  18,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: widget.onClose,
                        tooltip: 'Close',
                        icon: Icon(
                          Icons.close,
                          size: 19,
                          color: colors.onSurfaceVariant,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor:
                          colors.surfaceContainer,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -4),
                      child: Column(
                        children: [
                          _SuccessIcon(colors: colors),
                          const SizedBox(height: 12),
                          _FrozenBadge(
                            colors: colors,
                            textTheme: textTheme,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Escrow Locked Successfully!',
                            textAlign: TextAlign.center,
                            style: textTheme.titleLarge?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text.rich(
                            TextSpan(
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 12,
                                height: 1.45,
                                color: colors.onSurfaceVariant,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Earnest deposit of ',
                                ),
                                TextSpan(
                                  text: '₦11,500,000',
                                  style: TextStyle(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                  ' is securely ring-fenced in Stanbic IBTC Trust Vault for Adeola Balogun (#LX-1092).',
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SuccessFinancialSummary(
                      colors: colors,
                      textTheme: textTheme,
                    ),
                    const SizedBox(height: 16),
                    _MilestoneTimeline(
                      colors: colors,
                      textTheme: textTheme,
                    ),
                    const SizedBox(height: 18),
                    _SuccessActions(
                      colors: colors,
                      textTheme: textTheme,
                      onViewContract: widget.onViewContract,
                      onDownloadReceipt: widget.onDownloadReceipt,
                      onReturnToDashboard:
                      widget.onReturnToDashboard,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final successColor = colors.tertiary;

    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: successColor.withValues(alpha: 0.12),
            ),
          ),
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: successColor,
              boxShadow: [
                BoxShadow(
                  color: successColor.withValues(alpha: 0.22),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              Icons.verified,
              size: 32,
              color: colors.onTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FrozenBadge extends StatelessWidget {
  const _FrozenBadge({
    required this.colors,
    required this.textTheme,
  });

  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 330,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colors.tertiaryFixed.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colors.tertiaryFixedDim.withValues(alpha: 0.65),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: colors.tertiary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              'SEC Regulated & Frozen',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: colors.onTertiaryFixed,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.45,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              '• #ESC-8942-01',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: colors.onTertiaryFixedVariant,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessFinancialSummary extends StatelessWidget {
  const _SuccessFinancialSummary({
    required this.colors,
    required this.textTheme,
  });

  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.30),
        ),
      ),
      child: Column(
        children: [
          _SummaryLine(
            label: 'Agreed Purchase Value',
            value: '₦115,000,000.00',
            colors: colors,
            textTheme: textTheme,
          ),
          _SummaryDivider(colors: colors),
          _SummaryLine(
            label: 'Locked Earnest Deposit (10%)',
            value: '₦11,500,000.00',
            valueColor: colors.tertiary,
            leadingDot: colors.tertiary,
            colors: colors,
            textTheme: textTheme,
          ),
          _SummaryDivider(colors: colors),
          _SummaryLine(
            label: 'Outstanding Balance (90%)',
            value: '₦103,500,000.00',
            colors: colors,
            textTheme: textTheme,
          ),
          _SummaryDivider(colors: colors),
          _SummaryLine(
            label: 'Custody Rail',
            value: 'Stanbic IBTC • Providus (NDIC)',
            compact: true,
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 7),
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Secondary Bidding',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.outline,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock,
                        size: 13,
                        color: colors.secondary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'Frozen',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.label,
    required this.value,
    required this.colors,
    required this.textTheme,
    this.valueColor,
    this.leadingDot,
    this.compact = false,
  });

  final String label;
  final String value;
  final ColorScheme colors;
  final TextTheme textTheme;
  final Color? valueColor;
  final Color? leadingDot;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              if (leadingDot != null) ...[
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: leadingDot,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    color: compact
                        ? colors.outline
                        : colors.onSurfaceVariant,
                    fontSize: compact ? 10.5 : 11,
                    fontWeight: compact
                        ? FontWeight.w500
                        : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelMedium?.copyWith(
              color: valueColor ?? colors.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: compact ? 10.5 : 11,
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryDivider extends StatelessWidget {
  const _SummaryDivider({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Divider(
        height: 1,
        color: colors.surfaceContainer,
      ),
    );
  }
}

class _MilestoneTimeline extends StatelessWidget {
  const _MilestoneTimeline({
    required this.colors,
    required this.textTheme,
  });

  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MILESTONE TIMELINE',
          style: textTheme.labelMedium?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.9,
          ),
        ),
        const SizedBox(height: 10),
        _TimelineItem(
          icon: Icons.check,
          title: '₦11.5M Earnest Locked',
          status: 'Done',
          iconBackground: colors.tertiary,
          iconForeground: colors.onTertiary,
          statusBackground:
          colors.tertiaryFixed.withValues(alpha: 0.55),
          statusColor: colors.onTertiaryFixed,
          colors: colors,
          textTheme: textTheme,
        ),
        const SizedBox(height: 8),
        _TimelineItem(
          icon: Icons.schedule,
          title: '48-Hour Structural Walkthrough',
          status: 'Next Step',
          iconBackground: colors.secondary,
          iconForeground: colors.onSecondary,
          statusBackground:
          colors.secondary.withValues(alpha: 0.10),
          statusColor: colors.secondary,
          colors: colors,
          textTheme: textTheme,
        ),
        const SizedBox(height: 8),
        _TimelineItem(
          icon: Icons.description_outlined,
          title: "Governor's Consent Handover",
          status: 'Pending',
          iconBackground: colors.surfaceContainerHighest,
          iconForeground: colors.outline,
          statusBackground: colors.surfaceContainerHighest,
          statusColor: colors.outline,
          muted: true,
          colors: colors,
          textTheme: textTheme,
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.icon,
    required this.title,
    required this.status,
    required this.iconBackground,
    required this.iconForeground,
    required this.statusBackground,
    required this.statusColor,
    required this.colors,
    required this.textTheme,
    this.muted = false,
  });

  final IconData icon;
  final String title;
  final String status;
  final Color iconBackground;
  final Color iconForeground;
  final Color statusBackground;
  final Color statusColor;
  final ColorScheme colors;
  final TextTheme textTheme;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: iconBackground,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 12,
            color: iconForeground,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: muted
                        ? colors.outline
                        : colors.onSurface,
                    fontWeight:
                    muted ? FontWeight.w500 : FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
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

class _SuccessActions extends StatelessWidget {
  const _SuccessActions({
    required this.colors,
    required this.textTheme,
    required this.onViewContract,
    required this.onDownloadReceipt,
    required this.onReturnToDashboard,
  });

  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback? onViewContract;
  final VoidCallback? onDownloadReceipt;
  final VoidCallback onReturnToDashboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onViewContract,
            icon: const Icon(
              Icons.visibility_outlined,
              size: 17,
            ),
            label: Text(
              'View Active Escrow Contract',
              style: textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 14,
              ),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onDownloadReceipt,
            icon: Icon(
              Icons.download_outlined,
              size: 17,
              color: colors.secondary,
            ),
            label: Flexible(
              child: Text(
                'Download Stamped Custody Receipt (PDF)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              padding: const EdgeInsets.symmetric(
                vertical: 11,
                horizontal: 14,
              ),
              side: BorderSide(
                color: colors.outlineVariant,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextButton(
          onPressed: onReturnToDashboard,
          child: Text(
            'Return to Deals Dashboard',
            style: textTheme.labelMedium?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SHARED COMPONENTS
// ============================================================

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({
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
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.50),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.035),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.badge,
    required this.colors,
    required this.textTheme,
  });

  final IconData icon;
  final String title;
  final String badge;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 290;

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 17,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              _verifiedBadge(),
            ],
          );
        }

        return Row(
          children: [
            Icon(
              icon,
              size: 17,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelLarge?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _verifiedBadge(),
          ],
        );
      },
    );
  }

  Widget _verifiedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: colors.tertiaryFixed,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        badge,
        style: textTheme.labelSmall?.copyWith(
          color: colors.onTertiaryFixed,
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _TermRow extends StatelessWidget {
  const _TermRow({
    required this.label,
    required this.trailing,
    required this.colors,
    required this.textTheme,
    this.subLabel,
    this.compact = false,
  });

  final String label;
  final Widget trailing;
  final ColorScheme colors;
  final TextTheme textTheme;
  final String? subLabel;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.labelMedium?.copyWith(
                  color: compact
                      ? colors.onSurfaceVariant
                      : colors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subLabel != null) ...[
                const SizedBox(height: 2),
                Text(
                  subLabel!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.outline,
                    fontSize: 10,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: trailing,
        ),
      ],
    );
  }
}

class _CustodyCard extends StatelessWidget {
  const _CustodyCard({
    required this.title,
    required this.value,
    required this.subValue,
    required this.colors,
    required this.textTheme,
    this.highlight = false,
  });

  final String title;
  final String value;
  final String subValue;
  final ColorScheme colors;
  final TextTheme textTheme;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelMedium?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: highlight
                  ? colors.secondary
                  : colors.outline,
              fontSize: 10,
              fontWeight:
              highlight ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.colors,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      icon: Icon(
        icon,
        color: colors.primary,
      ),
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(6),
        minimumSize: const Size(36, 36),
      ),
    );
  }
}

// ============================================================
// KEYPAD
// ============================================================

enum _KeypadType {
  number,
  biometric,
  backspace,
}

class _KeypadKey {
  const _KeypadKey._({
    required this.type,
    this.value,
  });

  const _KeypadKey.number(String value)
      : this._(
    type: _KeypadType.number,
    value: value,
  );

  const _KeypadKey.biometric()
      : this._(
    type: _KeypadType.biometric,
  );

  const _KeypadKey.backspace()
      : this._(
    type: _KeypadType.backspace,
  );

  final _KeypadType type;
  final String? value;
}

class _KeypadButton extends StatelessWidget {
  const _KeypadButton({
    required this.keyData,
    required this.colors,
    required this.textTheme,
    required this.onPressed,
  });

  final _KeypadKey keyData;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isBiometric =
        keyData.type == _KeypadType.biometric;
    final isBackspace =
        keyData.type == _KeypadType.backspace;

    return Material(
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(9),
        child: Center(
          child: isBiometric
              ? Icon(
            Icons.fingerprint,
            size: 22,
            color: colors.secondary,
          )
              : isBackspace
              ? Icon(
            Icons.backspace_outlined,
            size: 19,
            color: colors.onSurfaceVariant,
          )
              : Text(
            keyData.value!,
            style: textTheme.titleMedium?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}