 import 'package:homex/ui/global.dart';

class CounterOfferScreen extends StatefulWidget {
  const CounterOfferScreen({
    super.key,
    this.onBack,
    this.onHelp,
    this.onMore,
    this.onSaveDraft,
    this.onSubmitCounter,
    this.onDiscard,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final VoidCallback? onMore;
  final VoidCallback? onSaveDraft;
  final VoidCallback? onSubmitCounter;
  final VoidCallback? onDiscard;

  @override
  State<CounterOfferScreen> createState() => _CounterOfferScreenState();
}

class _CounterOfferScreenState extends State<CounterOfferScreen> {
  final TextEditingController _priceController =
  TextEditingController(text: '118,500,000');

  final TextEditingController _clauseController = TextEditingController(
    text:
    'Counter offer of ₦118,500,000 includes the upgraded 15kVA Solar Inverter setup and fully fitted kitchen appliances. Firm closing within 21 business days.',
  );

  double _earnestPercentage = 15;
  int _expiryHours = 48;
  int _closingDays = 21;

  bool _inspectionWindow = true;
  bool _smartFittings = true;
  bool _certifiedSolicitor = true;

  bool _isSaving = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _priceController.dispose();
    _clauseController.dispose();
    super.dispose();
  }

  int get _counterPrice {
    final value = _priceController.text.replaceAll(',', '').trim();
    return int.tryParse(value) ?? 0;
  }

  double get _earnestAmount => _counterPrice * (_earnestPercentage / 100);

  double get _closingBalance => _counterPrice - _earnestAmount;

  double get _netPayout => _counterPrice - 150000;

  String get _formattedPrice {
    return _formatCurrency(_counterPrice);
  }

  String get _formattedEarnest {
    return _formatCurrency(_earnestAmount.round());
  }

  String get _formattedBalance {
    return _formatCurrency(_closingBalance.round());
  }

  String get _formattedNetPayout {
    return _formatCurrency(_netPayout.round());
  }

  String get _amountInWords {
    if (_counterPrice == 118500000) {
      return 'One Hundred and Eighteen Million, Five Hundred Thousand Nigerian Naira Only';
    }

    return 'Nigerian Naira amount as entered above';
  }

  String _formatCurrency(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }

    return '₦$buffer';
  }

  void _setPrice(int price) {
    final formatted = _formatNumber(price);

    _priceController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );

    setState(() {});
  }

  String _formatNumber(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }

    return buffer.toString();
  }

  void _onPriceChanged(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) {
      if (_priceController.text.isNotEmpty) {
        _priceController.value = const TextEditingValue();
      }
      setState(() {});
      return;
    }

    final number = int.tryParse(digits);
    if (number == null) return;

    final formatted = _formatNumber(number);

    if (formatted != _priceController.text) {
      _priceController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    setState(() {});
  }

  void _setEarnest(double value) {
    setState(() {
      _earnestPercentage = value;
    });
  }

  void _setExpiry(int hours) {
    setState(() {
      _expiryHours = hours;
    });
  }

  void _setClosingDays(int days) {
    setState(() {
      _closingDays = days;
    });
  }

  Future<void> _saveDraft() async {
    if (_isSaving || _isSubmitting) return;

    FocusScope.of(context).unfocus();

    setState(() {
      _isSaving = true;
    });

    await Future<void>.delayed(AppAnimations.mediumDelay);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    widget.onSaveDraft?.call();

    _showMessage('Counter offer saved as draft.');
  }

  Future<void> _submitCounter() async {
    if (_isSubmitting || _isSaving) return;

    FocusScope.of(context).unfocus();

    if (_counterPrice <= 0) {
      _showMessage('Enter a valid counter offer amount.');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(AppAnimations.mediumDelay);

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    widget.onSubmitCounter?.call();

    _showMessage('Counter offer ready for submission.');
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
        top: false,
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildTopBar(
                    colors: colors,
                    textTheme: textTheme,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 672,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          20,
                          16,
                          180,
                        ),
                        child: Column(
                          children: [
                            _buildStepper(
                              colors: colors,
                              textTheme: textTheme,
                            ),
                            const SizedBox(height: 20),
                            _buildOriginalOfferCard(
                              colors: colors,
                              textTheme: textTheme,
                            ),
                            const SizedBox(height: 20),
                            _buildPricingSection(
                              colors: colors,
                              textTheme: textTheme,
                            ),
                            const SizedBox(height: 20),
                            _buildEarnestSection(
                              colors: colors,
                              textTheme: textTheme,
                            ),
                            const SizedBox(height: 20),
                            _buildClosingSchedule(
                              colors: colors,
                              textTheme: textTheme,
                            ),
                            const SizedBox(height: 20),
                            _buildClausesSection(
                              colors: colors,
                              textTheme: textTheme,
                            ),
                            const SizedBox(height: 20),
                            _buildComplianceNotice(
                              colors: colors,
                              textTheme: textTheme,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _buildBottomDock(
              colors: colors,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(
            color: colors.surfaceContainerHigh,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 672),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onBack,
                  tooltip: 'Back',
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.arrow_back,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'Counter Offer',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2,
                            ),
                          ),
                          _StatusBadge(
                            label: 'In Negotiation',
                            backgroundColor: colors.secondaryFixed,
                            foregroundColor:
                            colors.onSecondaryFixed,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '#LX-1092 • Contemporary 4-Bed Duplex, Lekki Phase 1',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: widget.onHelp,
                  tooltip: 'Legal & Offer Advisory Guidelines',
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.help_outline,
                    color: colors.onSurfaceVariant,
                  ),
                ),
                IconButton(
                  onPressed: widget.onMore,
                  tooltip: 'More',
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.more_vert,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepper({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return _SurfaceCard(
      colors: colors,
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 460;

          final content = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '2',
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step 2 of 2: Terms Re-specification',
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Adjust price, earnest vault threshold, and settlement schedule',
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

          final secured = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shield,
                size: 16,
                color: colors.secondary,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  'Secured by Stanbic Escrow',
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                content,
                const SizedBox(height: 12),
                secured,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: content),
              const SizedBox(width: 16),
              Flexible(child: secured),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOriginalOfferCard({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return _SurfaceCard(
      colors: colors,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 430;

              final buyer = Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InitialAvatar(
                    initials: 'AB',
                    colors: colors,
                    size: 40,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            Text(
                              'Adeola Balogun',
                              style: textTheme.labelLarge?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            _StatusBadge(
                              label: '✓  Pre-Approved Buyer',
                              backgroundColor: colors.primaryFixed,
                              foregroundColor:
                              colors.onPrimaryFixed,
                              compact: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Offer #LX-1092 received 6 hours ago via Stanbic Trustee',
                          style: textTheme.labelMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              final variance = Column(
                crossAxisAlignment: compact
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text(
                    'VARIANCE',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.outline,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '-4.17% (₦5,000,000)',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );

              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buyer,
                    const SizedBox(height: 12),
                    variance,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: buyer),
                  const SizedBox(width: 12),
                  variance,
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: colors.surfaceContainer,
          ),
          const SizedBox(height: 12),
          _buildOfferReferenceGrid(
            colors: colors,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildOfferReferenceGrid({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 390;

        final items = [
          _ReferenceItem(
            title: "Buyer's Offer",
            value: '₦115,000,000',
            caption: '10% Earnest Included',
          ),
          _ReferenceItem(
            title: 'Original List Price',
            value: '₦120,000,000',
            caption: 'Published Lekki Market',
          ),
          _ReferenceItem(
            title: 'Closing Request',
            value: '14 Bus. Days',
            caption: 'Expedited Transfer',
          ),
        ];

        if (compact) {
          return Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                _buildReferenceItem(
                  item: items[i],
                  colors: colors,
                  textTheme: textTheme,
                ),
                if (i != items.length - 1)
                  Divider(
                    color: colors.surfaceContainerHigh,
                    height: 16,
                  ),
              ],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < items.length; i++) ...[
              Expanded(
                child: _buildReferenceItem(
                  item: items[i],
                  colors: colors,
                  textTheme: textTheme,
                  compact: true,
                ),
              ),
              if (i != items.length - 1)
                Container(
                  width: 1,
                  height: 64,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: colors.surfaceContainerHigh,
                ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildReferenceItem({
    required _ReferenceItem item,
    required ColorScheme colors,
    required TextTheme textTheme,
    bool compact = false,
  }) {
    return Padding(
      padding: compact
          ? const EdgeInsets.symmetric(horizontal: 2)
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.value,
            style: textTheme.labelLarge?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.caption,
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return _SectionCard(
      colors: colors,
      title: 'Counter Offer Amount',
      description:
      'Input revised sales price. This will legally supersede prior offers upon submission.',
      icon: Icons.payments_outlined,
      child: Column(
        children: [
          _buildPriceInput(
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 16),
          _buildQuickAdjustments(
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 16),
          _buildAmountWords(
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 12),
          _buildFinancialSummary(
            colors: colors,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInput({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colors.primaryContainer,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TARGET SETTLEMENT PRICE (NGN)',
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '₦',
                style: textTheme.headlineMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  onChanged: _onPriceChanged,
                  style: textTheme.headlineMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: '0',
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAdjustments({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK ADJUSTMENT PRESETS',
          style: textTheme.labelSmall?.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _PresetChip(
              label: 'Split the Difference (₦117.5M)',
              selected: false,
              colors: colors,
              onTap: () => _setPrice(117500000),
            ),
            _PresetChip(
              label: 'Target ₦118,500,000',
              selected: _counterPrice == 118500000,
              colors: colors,
              onTap: () => _setPrice(118500000),
            ),
            _PresetChip(
              label: 'Full List Price (₦120.0M)',
              selected: false,
              colors: colors,
              onTap: () => _setPrice(120000000),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAmountWords({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: colors.primary,
            width: 4,
          ),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STATUTORY AMOUNT IN WORDS',
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '"$_amountInWords"',
            style: textTheme.labelMedium?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.35),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _SummaryRow(
            label: 'Gross Counter Value',
            value: _formattedPrice,
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            label: 'HomeX 0% Direct Seller Commission',
            value: '₦0.00',
            colors: colors,
            textTheme: textTheme,
            highlighted: true,
            icon: Icons.check_circle,
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            label: 'Est. Legal & Deed Conveyancing Verification',
            value: '-₦150,000',
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 10),
          Divider(
            height: 1,
            color: colors.surfaceContainer,
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 360;

              final amount = Text(
                _formattedNetPayout,
                style: textTheme.titleMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              );

              final title = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimated Net Payout',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Disbursed directly into Stanbic Seller Account',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.outline,
                    ),
                  ),
                ],
              );

              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    const SizedBox(height: 8),
                    amount,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: title),
                  const SizedBox(width: 12),
                  amount,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEarnestSection({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return _SectionCard(
      colors: colors,
      title: 'Earnest Deposit & Vault Terms',
      description:
      'Funds locked in Stanbic IBTC Custodial Vault within 24 hours of buyer signature.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REQUIRED EARNEST DEPOSIT',
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          _buildEarnestOptions(
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 16),
          Divider(
            height: 1,
            color: colors.surfaceContainer,
          ),
          const SizedBox(height: 12),
          _buildExpiryOptions(
            colors: colors,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildEarnestOptions({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 380;

        final options = [
          (10.0, '10%', '₦11.85M'),
          (15.0, '15% (Recommended)', '₦17.775M'),
          (20.0, '20%', '₦23.70M'),
        ];

        if (compact) {
          return Column(
            children: [
              for (var i = 0; i < options.length; i++) ...[
                _EarnestOption(
                  percentage: options[i].$1,
                  label: options[i].$2,
                  amount: options[i].$3,
                  selected: _earnestPercentage == options[i].$1,
                  colors: colors,
                  textTheme: textTheme,
                  onTap: () => _setEarnest(options[i].$1),
                ),
                if (i != options.length - 1)
                  const SizedBox(height: 8),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (var i = 0; i < options.length; i++) ...[
              Expanded(
                child: _EarnestOption(
                  percentage: options[i].$1,
                  label: options[i].$2,
                  amount: options[i].$3,
                  selected: _earnestPercentage == options[i].$1,
                  colors: colors,
                  textTheme: textTheme,
                  onTap: () => _setEarnest(options[i].$1),
                ),
              ),
              if (i != options.length - 1)
                const SizedBox(width: 8),
            ],
          ],
        );
      },
    );
  }

  Widget _buildExpiryOptions({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 400;

            final label = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COUNTER OFFER EXPIRY WINDOW',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.outline,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: colors.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Prompt response requirement',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            );

            if (compact) {
              return label;
            }

            return Row(
              children: [
                Expanded(child: label),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 380;

            final options = [
              (24, '24 Hours (Fast-Track)'),
              (48, '48 Hours (Standard)'),
              (72, '72 Hours'),
            ];

            if (compact) {
              return Column(
                children: [
                  for (var i = 0; i < options.length; i++) ...[
                    _ExpiryButton(
                      hours: options[i].$1,
                      label: options[i].$2,
                      selected: _expiryHours == options[i].$1,
                      colors: colors,
                      textTheme: textTheme,
                      onTap: () => _setExpiry(options[i].$1),
                    ),
                    if (i != options.length - 1)
                      const SizedBox(height: 8),
                  ],
                ],
              );
            }

            return Row(
              children: [
                for (var i = 0; i < options.length; i++) ...[
                  Expanded(
                    child: _ExpiryButton(
                      hours: options[i].$1,
                      label: options[i].$2,
                      selected: _expiryHours == options[i].$1,
                      colors: colors,
                      textTheme: textTheme,
                      onTap: () => _setExpiry(options[i].$1),
                    ),
                  ),
                  if (i != options.length - 1)
                    const SizedBox(width: 8),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildClosingSchedule({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return _SectionCard(
      colors: colors,
      title: 'Closing Schedule & Cadastral Handover',
      description:
      "Specify timeframe for final balance disbursement and Governor's Consent filing.",
      icon: Icons.event_available,
      child: Column(
        children: [
          _buildClosingOptions(
            colors: colors,
            textTheme: textTheme,
          ),
          const SizedBox(height: 16),
          _buildMilestonePreview(
            colors: colors,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildClosingOptions({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 380;

        final options = [
          (14, '14 Days', "Buyer's request"),
          (21, '21 Days', 'Suggested realistic'),
          (30, '30 Days', 'Extended clearance'),
        ];

        if (compact) {
          return Column(
            children: [
              for (var i = 0; i < options.length; i++) ...[
                _ClosingOption(
                  days: options[i].$1,
                  title: options[i].$2,
                  subtitle: options[i].$3,
                  selected: _closingDays == options[i].$1,
                  colors: colors,
                  textTheme: textTheme,
                  onTap: () => _setClosingDays(options[i].$1),
                ),
                if (i != options.length - 1)
                  const SizedBox(height: 8),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (var i = 0; i < options.length; i++) ...[
              Expanded(
                child: _ClosingOption(
                  days: options[i].$1,
                  title: options[i].$2,
                  subtitle: options[i].$3,
                  selected: _closingDays == options[i].$1,
                  colors: colors,
                  textTheme: textTheme,
                  onTap: () => _setClosingDays(options[i].$1),
                ),
              ),
              if (i != options.length - 1)
                const SizedBox(width: 8),
            ],
          ],
        );
      },
    );
  }

  Widget _buildMilestonePreview({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MILESTONE DISBURSEMENT PREVIEW',
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          _TimelineItem(
            colors: colors,
            textTheme: textTheme,
            title:
            'Milestone 1: Earnest Hold ($_formattedEarnest)',
            day: 'Day 2',
            description:
            'Deposited in Stanbic Vault; contract binding and search starts.',
            active: true,
          ),
          _TimelineItem(
            colors: colors,
            textTheme: textTheme,
            title:
            'Milestone 2: Deed & Cadastral Handover (${_formattedBalance})',
            day: 'Day $_closingDays',
            description:
            'Final balance released on physical key handover and signed deed execution.',
            active: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildClausesSection({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return _SectionCard(
      colors: colors,
      title: 'Clauses & Contingency Controls',
      description:
      'Protect transaction terms before locking the counter proposal.',
      icon: Icons.gavel_outlined,
      child: Column(
        children: [
          _ClauseToggle(
            title: 'Inspection Window',
            description:
            'Limit physical structural review to 48 hours post-acceptance',
            value: _inspectionWindow,
            colors: colors,
            textTheme: textTheme,
            onChanged: (value) {
              setState(() {
                _inspectionWindow = value;
              });
            },
          ),
          const SizedBox(height: 10),
          _ClauseToggle(
            title: 'Smart Fittings Schedule',
            description:
            'Include installed automation hub; exclude designer loose furnishings',
            value: _smartFittings,
            colors: colors,
            textTheme: textTheme,
            onChanged: (value) {
              setState(() {
                _smartFittings = value;
              });
            },
          ),
          const SizedBox(height: 10),
          _ClauseToggle(
            title: 'HomeX Certified Solicitor',
            description:
            'Appoint platform-vetted conveyancing legal counsel (Lagos Land Registry)',
            value: _certifiedSolicitor,
            colors: colors,
            textTheme: textTheme,
            onChanged: (value) {
              setState(() {
                _certifiedSolicitor = value;
              });
            },
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'SELLER ADDENDUM & NOTES FOR ADEOLA BALOGUN',
              style: textTheme.labelSmall?.copyWith(
                color: colors.outline,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 7),
          TextField(
            controller: _clauseController,
            maxLines: 4,
            maxLength: 300,
            onChanged: (_) => setState(() {}),
            style: textTheme.labelMedium?.copyWith(
              color: colors.onSurface,
            ),
            decoration: InputDecoration(
              hintText:
              'E.g., Price revised to ₦118.5M factoring brand new automated solar inverter battery installation.',
              hintStyle: textTheme.labelMedium?.copyWith(
                color: colors.outline,
              ),
              filled: true,
              fillColor: colors.surfaceContainerLowest,
              counterStyle: textTheme.labelSmall?.copyWith(
                color: colors.outline,
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
                  color: colors.outlineVariant.withValues(
                    alpha: 0.6,
                  ),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colors.primary,
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "This note will appear directly in the Buyer's Offer Notification dossier.",
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.outline,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${_clauseController.text.length} / 300',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceNotice({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_user,
            size: 20,
            color: colors.secondary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Legal Implication Notice: ',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text:
                    'Submitting this counter offer constitutes a formal rejection of the original ₦115,000,000 offer and legally binds this property at ₦118,500,000 for $_expiryHours hours under SEC Nigeria & NDIC trustee frameworks. Adeola Balogun may accept, reject, or let this counter expire.',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.5,
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

  Widget _buildBottomDock({
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            border: Border(
              top: BorderSide(
                color: colors.surfaceContainerHigh,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 672,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  10,
                  16,
                  10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final compact = constraints.maxWidth < 370;

                        if (compact) {
                          return Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: _DraftButton(
                                  colors: colors,
                                  textTheme: textTheme,
                                  isLoading: _isSaving,
                                  onPressed: _saveDraft,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: _SubmitButton(
                                  colors: colors,
                                  textTheme: textTheme,
                                  isLoading: _isSubmitting,
                                  amount: _formattedPrice,
                                  onPressed: _submitCounter,
                                ),
                              ),
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: _DraftButton(
                                colors: colors,
                                textTheme: textTheme,
                                isLoading: _isSaving,
                                onPressed: _saveDraft,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: _SubmitButton(
                                colors: colors,
                                textTheme: textTheme,
                                isLoading: _isSubmitting,
                                amount: _formattedPrice,
                                onPressed: _submitCounter,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 7),
                    TextButton(
                      onPressed: widget.onDiscard,
                      style: TextButton.styleFrom(
                        foregroundColor: colors.outline,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        minimumSize: const Size(0, 32),
                      ),
                      child: Text(
                        'Discard Counter & Return to Offer Details #LX-1092',
                        textAlign: TextAlign.center,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.outline,
                          decoration: TextDecoration.underline,
                          decorationColor:
                          colors.outlineVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.035),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.colors,
    required this.title,
    required this.description,
    required this.child,
    this.icon,
  });

  final ColorScheme colors;
  final String title;
  final String description;
  final Widget child;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return _SurfaceCard(
      colors: colors,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 12),
                Icon(
                  icon,
                  color: colors.secondary,
                  size: 22,
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.compact = false,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 7 : 8,
        vertical: compact ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          compact ? 999 : 4,
        ),
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InitialAvatar extends StatelessWidget {
  const _InitialAvatar({
    required this.initials,
    required this.colors,
    required this.size,
  });

  final String initials;
  final ColorScheme colors;
  final double size;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: textTheme.labelLarge?.copyWith(
          color: colors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ReferenceItem {
  const _ReferenceItem({
    required this.title,
    required this.value,
    required this.caption,
  });

  final String title;
  final String value;
  final String caption;
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({
    required this.label,
    required this.selected,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final ColorScheme colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: selected
                ? colors.primaryContainer
                : colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(999),
            border: selected
                ? null
                : Border.all(
              color: colors.outlineVariant.withValues(
                alpha: 0.4,
              ),
            ),
          ),
          child: Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              color: selected
                  ? colors.onPrimary
                  : colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.colors,
    required this.textTheme,
    this.highlighted = false,
    this.icon,
  });

  final String label;
  final String value;
  final ColorScheme colors;
  final TextTheme textTheme;
  final bool highlighted;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 15,
                  color: colors.onTertiaryContainer,
                ),
                const SizedBox(width: 4),
              ],
              Expanded(
                child: Text(
                  label,
                  style: textTheme.labelMedium?.copyWith(
                    color: highlighted
                        ? colors.onTertiaryContainer
                        : colors.onSurfaceVariant,
                    fontWeight:
                    highlighted ? FontWeight.w500 : null,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: textTheme.labelMedium?.copyWith(
              color: highlighted
                  ? colors.onTertiaryContainer
                  : colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _EarnestOption extends StatelessWidget {
  const _EarnestOption({
    required this.percentage,
    required this.label,
    required this.amount,
    required this.selected,
    required this.colors,
    required this.textTheme,
    required this.onTap,
  });

  final double percentage;
  final String label;
  final String amount;
  final bool selected;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 11,
          ),
          decoration: BoxDecoration(
            color: selected
                ? colors.primaryContainer
                : colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? colors.primary
                  : colors.outlineVariant.withValues(alpha: 0.5),
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: textTheme.labelMedium?.copyWith(
                  color: selected
                      ? colors.onPrimary
                      : colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                amount,
                textAlign: TextAlign.center,
                style: textTheme.labelSmall?.copyWith(
                  color: selected
                      ? colors.onInverseSurface
                      : colors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpiryButton extends StatelessWidget {
  const _ExpiryButton({
    required this.hours,
    required this.label,
    required this.selected,
    required this.colors,
    required this.textTheme,
    required this.onTap,
  });

  final int hours;
  final String label;
  final bool selected;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          constraints: const BoxConstraints(
            minHeight: 42,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: selected
                ? colors.primary
                : colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? colors.primary
                  : colors.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: textTheme.labelMedium?.copyWith(
              color: selected
                  ? colors.onPrimary
                  : colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _ClosingOption extends StatelessWidget {
  const _ClosingOption({
    required this.days,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.colors,
    required this.textTheme,
    required this.onTap,
  });

  final int days;
  final String title;
  final String subtitle;
  final bool selected;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected
                ? colors.primaryContainer
                : colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? colors.primary
                  : colors.outlineVariant.withValues(alpha: 0.4),
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: textTheme.labelMedium?.copyWith(
                  color: selected
                      ? colors.onPrimary
                      : colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: textTheme.labelSmall?.copyWith(
                  color: selected
                      ? colors.onInverseSurface
                      : colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.colors,
    required this.textTheme,
    required this.title,
    required this.day,
    required this.description,
    required this.active,
    this.isLast = false,
  });

  final ColorScheme colors;
  final TextTheme textTheme;
  final String title;
  final String day;
  final String description;
  final bool active;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 16,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: active
                        ? colors.primary
                        : colors.surfaceTint,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.surfaceContainerLowest,
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: colors.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: textTheme.labelMedium?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        day,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.outline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.45,
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
}

class _ClauseToggle extends StatelessWidget {
  const _ClauseToggle({
    required this.title,
    required this.description,
    required this.value,
    required this.colors,
    required this.textTheme,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final ColorScheme colors;
  final TextTheme textTheme;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: colors.onPrimary,
            activeTrackColor: colors.primary,
            inactiveThumbColor: colors.surfaceContainerLowest,
            inactiveTrackColor: colors.surfaceContainerHigh,
          ),
        ],
      ),
    );
  }
}

class _DraftButton extends StatelessWidget {
  const _DraftButton({
    required this.colors,
    required this.textTheme,
    required this.isLoading,
    required this.onPressed,
  });

  final ColorScheme colors;
  final TextTheme textTheme;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: colors.surfaceContainerLow,
          foregroundColor: colors.onSurface,
          side: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colors.primary,
          ),
        )
            : FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.save_outlined,
                size: 17,
                color: colors.onSurface,
              ),
              const SizedBox(width: 6),
              Text(
                'Save Draft',
                style: textTheme.labelMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.colors,
    required this.textTheme,
    required this.isLoading,
    required this.amount,
    required this.onPressed,
  });

  final ColorScheme colors;
  final TextTheme textTheme;
  final bool isLoading;
  final String amount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.primary.withValues(
            alpha: 0.6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 3,
        ),
        child: isLoading
            ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colors.onPrimary,
          ),
        )
            : FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.send,
                size: 17,
                color: colors.onPrimary,
              ),
              const SizedBox(width: 7),
              Text(
                'Submit Counter ($amount)',
                style: textTheme.labelMedium?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}