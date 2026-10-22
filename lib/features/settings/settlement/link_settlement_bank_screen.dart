 import 'package:homex/ui/global.dart';

class LinkSettlementBankScreen extends StatefulWidget {
  const LinkSettlementBankScreen({
    super.key,
    this.onBack,
    this.onHelp,
    this.onAuthenticate,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final VoidCallback? onAuthenticate;

  @override
  State<LinkSettlementBankScreen> createState() =>
      _LinkSettlementBankScreenState();
}

class _LinkSettlementBankScreenState
    extends State<LinkSettlementBankScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nubanController =
  TextEditingController(text: '0234 881 920');

  String _selectedBank = 'gtbank';
  String _selectedPurpose = 'secondary';
  bool _isAuthenticating = false;

  final List<_BankOption> _banks = const [
    _BankOption(
      id: 'gtbank',
      shortName: 'GT',
      name: 'Guaranty Trust Bank (GTBank)',
      displayName: 'GTBank',
    ),
    _BankOption(
      id: 'zenith',
      shortName: 'ZE',
      name: 'Zenith Bank PLC',
      displayName: 'Zenith',
    ),
    _BankOption(
      id: 'stanbic',
      shortName: 'SB',
      name: 'Stanbic IBTC Bank',
      displayName: 'Stanbic',
    ),
    _BankOption(
      id: 'access',
      shortName: 'AC',
      name: 'Access Bank PLC',
      displayName: 'Access',
    ),
    _BankOption(
      id: 'providus',
      shortName: 'PV',
      name: 'Providus Bank PLC',
      displayName: 'Providus',
    ),
  ];

  final List<_PurposeOption> _purposes = const [
    _PurposeOption(
      id: 'secondary',
      title: 'Designated Secondary Escrow',
      badge: 'Failover Routing',
      description:
      'Automated secondary payout channel in event of primary gateway settlement maintenance.',
    ),
    _PurposeOption(
      id: 'corporate',
      title: 'Institutional Corporate Current',
      badge: 'Entity Tier 3',
      description:
      'For structured corporate real estate joint-venture disbursements & trust entities.',
    ),
    _PurposeOption(
      id: 'personal',
      title: 'Personal Investment Settlement',
      badge: 'Direct Return',
      description:
      'Direct yields, rental income dividends, and realized property liquidation payouts.',
    ),
  ];

  @override
  void dispose() {
    _nubanController.dispose();
    super.dispose();
  }

  _BankOption get _selectedBankData {
    return _banks.firstWhere(
          (bank) => bank.id == _selectedBank,
    );
  }

  void _selectBank(String bankId) {
    if (_selectedBank == bankId) return;

    setState(() {
      _selectedBank = bankId;
    });
  }

  void _selectPurpose(String purposeId) {
    if (_selectedPurpose == purposeId) return;

    setState(() {
      _selectedPurpose = purposeId;
    });
  }

  void _formatNuban(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 10) {
      return;
    }

    final formatted = _formatNubanValue(digits);

    if (_nubanController.text == formatted) {
      return;
    }

    _nubanController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );

    setState(() {});
  }

  String _formatNubanValue(String digits) {
    if (digits.isEmpty) return '';

    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i == 3 || i == 6) {
        buffer.write(' ');
      }

      buffer.write(digits[i]);
    }

    return buffer.toString();
  }

  Future<void> _authenticate() async {
    FocusScope.of(context).unfocus();

    final nuban = _nubanController.text.replaceAll(' ', '');

    if (nuban.length != 10) {
      _showMessage(
        'Enter a valid 10-digit NUBAN account number.',
      );
      return;
    }

    if (_isAuthenticating) return;

    setState(() {
      _isAuthenticating = true;
    });

    await Future<void>.delayed(
      AppAnimations.mediumDelay,
    );

    if (!mounted) return;

    setState(() {
      _isAuthenticating = false;
    });

    widget.onAuthenticate?.call();
AppNavigator.pushAndStackNamed(AppRoutes.settlementBankLinkedScreen);
    _showMessage(
      'Settlement account authentication initiated.',
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(colorScheme),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final horizontalPadding =
                  _horizontalPadding(constraints.maxWidth);

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      16,
                      horizontalPadding,
                      48,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 576,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildStatutoryBanner(
                                colorScheme,
                              ),
                              const SizedBox(height: 24),
                              _buildBankSelector(
                                colorScheme,
                              ),
                              const SizedBox(height: 24),
                              _buildNubanSection(
                                colorScheme,
                              ),
                              const SizedBox(height: 24),
                              _buildPurposeSection(
                                colorScheme,
                              ),
                              const SizedBox(height: 24),
                              _buildSafeguardDisclosure(
                                colorScheme,
                              ),
                              const SizedBox(height: 18),
                              _buildAuthenticateSection(
                                colorScheme,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _horizontalPadding(double width) {
    if (width < 320) {
      return 12;
    }

    if (width < 380) {
      return 16;
    }

    return 16;
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 380;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _TopBarButton(
                  icon: Icons.arrow_back_rounded,
                  tooltip: 'Go back',
                  onPressed: widget.onBack ??
                          () => Navigator.of(context).maybePop(),
                  colorScheme: colorScheme,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: compact
                      ? _buildCompactTopBarContent(
                    colorScheme,
                  )
                      : _buildRegularTopBarContent(
                    colorScheme,
                  ),
                ),
                const SizedBox(width: 4),
                _TopBarButton(
                  icon: Icons.help_outline_rounded,
                  tooltip: 'Support and custody help',
                  onPressed: widget.onHelp,
                  colorScheme: colorScheme,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildRegularTopBarContent(
      ColorScheme colorScheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Link Settlement Bank',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 18,
                height: 1.15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            const _CustodyBadge(),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          'Add verified destination account for automated disbursement',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 12,
            height: 1.3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactTopBarContent(
      ColorScheme colorScheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Link Settlement Bank',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
            height: 1.15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.25,
          ),
        ),
        const SizedBox(height: 4),
        const _CustodyBadge(
          compact: true,
        ),
        const SizedBox(height: 3),
        Text(
          'Add verified destination account for automated disbursement',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 10.5,
            height: 1.25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // 1. STATUTORY BANNER
  // ============================================================

  Widget _buildStatutoryBanner(
      ColorScheme colorScheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -32,
            top: -32,
            child: IgnorePointer(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 340;

              if (compact) {
                return _buildCompactStatutoryBanner(
                  colorScheme,
                );
              }

              return _buildRegularStatutoryBanner(
                colorScheme,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRegularStatutoryBanner(
      ColorScheme colorScheme,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatutoryIcon(
          colorScheme: colorScheme,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatutoryText(
            colorScheme,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactStatutoryBanner(
      ColorScheme colorScheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatutoryIcon(
          colorScheme: colorScheme,
        ),
        const SizedBox(height: 12),
        _buildStatutoryText(
          colorScheme,
        ),
      ],
    );
  }

  Widget _buildStatutoryText(
      ColorScheme colorScheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STATUTORY NAME MATCH PROTOCOL (TIER 3 BVN)',
          softWrap: true,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 12,
            height: 1.2,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 12,
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
            children: [
              const TextSpan(
                text:
                'To prevent fraudulent fund diversion, settlement destination accounts must strictly match the registered BVN legal identity: ',
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                  child: Text(
                    'Alexander Magnus',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 11,
                      height: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // 2. BANK SELECTOR
  // ============================================================

  Widget _buildBankSelector(
      ColorScheme colorScheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 360;

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel(
                    'SELECT FINANCIAL INSTITUTION',
                    colorScheme,
                  ),
                  const SizedBox(height: 4),
                  _sectionSecondaryLabel(
                    'NIBSS Direct Integration',
                    colorScheme,
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: _sectionLabel(
                    'SELECT FINANCIAL INSTITUTION',
                    colorScheme,
                  ),
                ),
                const SizedBox(width: 12),
                _sectionSecondaryLabel(
                  'NIBSS Direct Integration',
                  colorScheme,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        _buildBankGrid(colorScheme),
        const SizedBox(height: 12),
        _buildSelectedBankField(colorScheme),
      ],
    );
  }

  Widget _buildBankGrid(
      ColorScheme colorScheme,
      ) {
    return SizedBox(
      height: 84,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const itemWidth = 64.0;

          final totalWidth =
              (_banks.length * itemWidth) +
                  ((_banks.length - 1) * 8);

          final shouldScroll =
              totalWidth > constraints.maxWidth;

          final row = Row(
            mainAxisAlignment: shouldScroll
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < _banks.length; i++) ...[
                if (i > 0 && shouldScroll)
                  const SizedBox(width: 8),
                _BankQuickSelector(
                  option: _banks[i],
                  selected:
                  _banks[i].id == _selectedBank,
                  onTap: () => _selectBank(
                    _banks[i].id,
                  ),
                  colorScheme: colorScheme,
                ),
              ],
            ],
          );

          if (!shouldScroll) {
            return row;
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: row,
          );
        },
      ),
    );
  }

  Widget _buildSelectedBankField(
      ColorScheme colorScheme,
      ) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 48,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.035),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            _showBankPicker(colorScheme);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_outlined,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${_selectedBankData.name} - Commercial',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 12,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.expand_more_rounded,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBankPicker(
      ColorScheme colorScheme,
      ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: colorScheme.surfaceContainerLowest,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(
              16,
              4,
              16,
              24,
            ),
            itemCount: _banks.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final bank = _banks[index];
              final selected =
                  bank.id == _selectedBank;

              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                selected: selected,
                selectedTileColor:
                colorScheme.surfaceContainerHigh,
                leading: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    bank.shortName,
                    style: TextStyle(
                      color: selected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                title: Text(
                  bank.name,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: selected
                    ? Icon(
                  Icons.check_circle_rounded,
                  color: colorScheme.primary,
                )
                    : null,
                onTap: () {
                  _selectBank(bank.id);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }

  // ============================================================
  // 3. NUBAN
  // ============================================================

  Widget _buildNubanSection(
      ColorScheme colorScheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 390;

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel(
                    '10-DIGIT NUBAN ACCOUNT NUMBER',
                    colorScheme,
                  ),
                  const SizedBox(height: 6),
                  _NgnBadge(
                    colorScheme: colorScheme,
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _sectionLabel(
                    '10-DIGIT NUBAN ACCOUNT NUMBER',
                    colorScheme,
                  ),
                ),
                const SizedBox(width: 10),
                _NgnBadge(
                  colorScheme: colorScheme,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        _buildNubanInput(colorScheme),
        const SizedBox(height: 12),
        _buildResolvedIdentity(colorScheme),
      ],
    );
  }

  Widget _buildNubanInput(
      ColorScheme colorScheme,
      ) {
    return TextField(
      controller: _nubanController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      maxLength: 12,
      onChanged: _formatNuban,
      style: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 16,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.5,
      ),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: colorScheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.fromLTRB(
          16,
          14,
          48,
          14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: Icon(
            Icons.check_circle_rounded,
            size: 22,
            color: colorScheme.tertiary,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 42,
          minHeight: 42,
        ),
      ),
    );
  }

  Widget _buildResolvedIdentity(
      ColorScheme colorScheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 350;

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIdentityDetails(colorScheme),
                const SizedBox(height: 10),
                _buildMatchBadge(
                  colorScheme,
                ),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _buildIdentityDetails(
                  colorScheme,
                ),
              ),
              const SizedBox(width: 10),
              _buildMatchBadge(
                colorScheme,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIdentityDetails(
      ColorScheme colorScheme,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.verified_outlined,
            size: 18,
            color: colorScheme.tertiary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACCOUNT NAME RESOLVED',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 10,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Alexander Magnus',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMatchBadge(
      ColorScheme colorScheme,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: colorScheme.tertiary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '100% NIBSS Match',
            style: TextStyle(
              color: colorScheme.tertiary,
              fontSize: 11,
              height: 1.1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 4. PURPOSE
  // ============================================================

  Widget _buildPurposeSection(
      ColorScheme colorScheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 390;

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel(
                    'ACCOUNT CLASSIFICATION & ROUTING PURPOSE',
                    colorScheme,
                  ),
                  const SizedBox(height: 4),
                  _sectionSecondaryLabel(
                    'Select one',
                    colorScheme,
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: _sectionLabel(
                    'ACCOUNT CLASSIFICATION & ROUTING PURPOSE',
                    colorScheme,
                  ),
                ),
                const SizedBox(width: 12),
                _sectionSecondaryLabel(
                  'Select one',
                  colorScheme,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            for (var i = 0; i < _purposes.length; i++) ...[
              _PurposeOptionCard(
                option: _purposes[i],
                selected:
                _selectedPurpose ==
                    _purposes[i].id,
                onTap: () => _selectPurpose(
                  _purposes[i].id,
                ),
                colorScheme: colorScheme,
              ),
              if (i < _purposes.length - 1)
                const SizedBox(height: 8),
            ],
          ],
        ),
      ],
    );
  }

  // ============================================================
  // 5. SAFEGUARD DISCLOSURE
  // ============================================================

  Widget _buildSafeguardDisclosure(
      ColorScheme colorScheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.security_outlined,
                size: 18,
                color: colorScheme.onSurface,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'ESCROW SAFEGUARD DISCLOSURES',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 12,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _DisclosureItem(
            icon: Icons.hourglass_top_rounded,
            iconColor: colorScheme.secondary,
            title: 'Mandatory 24-Hour Cooling Period:',
            description:
            'Any newly linked settlement account undergoes a statutory security hold before large disbursements (>₦10,000,000) can be executed.',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 10),
          _DisclosureItem(
            icon: Icons.pin_outlined,
            iconColor: colorScheme.primary,
            title: '2FA Transaction PIN Required:',
            description:
            'Final binding triggers a biometric check and requires entry of your 6-digit cryptographic escrow PIN.',
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 6. AUTHENTICATE
  // ============================================================

  Widget _buildAuthenticateSection(
      ColorScheme colorScheme,
      ) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed:
            _isAuthenticating
                ? null
                : _authenticate,
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              disabledBackgroundColor:
              colorScheme.primary.withValues(
                alpha: 0.55,
              ),
              disabledForegroundColor:
              colorScheme.onPrimary.withValues(
                alpha: 0.8,
              ),
              minimumSize: const Size(
                double.infinity,
                56,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            icon: _isAuthenticating
                ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor:
                AlwaysStoppedAnimation<Color>(
                  colorScheme.onPrimary,
                ),
              ),
            )
                : const Icon(
              Icons.lock_rounded,
              size: 20,
            ),
            label: Flexible(
              child: Text(
                _isAuthenticating
                    ? 'Authenticating...'
                    : 'Authenticate & Link Settlement Account',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.policy_outlined,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Regulated by Central Bank of Nigeria (CBN) & SEC Escrow Custody Framework',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 10,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SHARED TEXT
  // ============================================================

  Widget _sectionLabel(
      String text,
      ColorScheme colorScheme,
      ) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontSize: 12,
        height: 1.25,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _sectionSecondaryLabel(
      String text,
      ColorScheme colorScheme,
      ) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontSize: 11,
        height: 1.2,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

// ================================================================
// BANK QUICK SELECTOR
// ================================================================

class _BankQuickSelector extends StatelessWidget {
  const _BankQuickSelector({
    required this.option,
    required this.selected,
    required this.onTap,
    required this.colorScheme,
  });

  final _BankOption option;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 84,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 150,
            ),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? colorScheme.surfaceContainerHigh
                  : colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
                width: selected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: selected
                        ? [
                      BoxShadow(
                        color: colorScheme.shadow
                            .withValues(alpha: 0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                        : null,
                  ),
                  child: Text(
                    option.shortName,
                    style: TextStyle(
                      color: selected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                      fontSize: 11,
                      height: 1,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    option.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selected
                          ? colorScheme.onSurface
                          : colorScheme.onSurfaceVariant,
                      fontSize: 10.5,
                      height: 1.15,
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// PURPOSE OPTION
// ================================================================

class _PurposeOptionCard extends StatelessWidget {
  const _PurposeOptionCard({
    required this.option,
    required this.selected,
    required this.onTap,
    required this.colorScheme,
  });

  final _PurposeOption option;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 150,
          ),
          curve: Curves.easeOut,
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
              BoxShadow(
                color: colorScheme.shadow
                    .withValues(alpha: 0.035),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ]
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 2,
                ),
                child: _RadioIndicator(
                  selected: selected,
                  colorScheme: colorScheme,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final compact =
                        constraints.maxWidth < 280;

                    if (compact) {
                      return Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            option.title,
                            softWrap: true,
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 12,
                              height: 1.25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          _PurposeBadge(
                            text: option.badge,
                            colorScheme: colorScheme,
                            selected: selected,
                          ),
                          const SizedBox(height: 5),
                          _purposeDescription(
                            colorScheme,
                          ),
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                option.title,
                                softWrap: true,
                                style: TextStyle(
                                  color:
                                  colorScheme.onSurface,
                                  fontSize: 12,
                                  height: 1.25,
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Align(
                                alignment:
                                Alignment.topRight,
                                child: _PurposeBadge(
                                  text: option.badge,
                                  colorScheme:
                                  colorScheme,
                                  selected: selected,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        _purposeDescription(
                          colorScheme,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _purposeDescription(
      ColorScheme colorScheme,
      ) {
    return Text(
      option.description,
      softWrap: true,
      style: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontSize: 11,
        height: 1.4,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

// ================================================================
// RADIO INDICATOR
// ================================================================

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({
    required this.selected,
    required this.colorScheme,
  });

  final bool selected;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 150,
      ),
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected
              ? colorScheme.primary
              : colorScheme.outline,
          width: selected ? 5 : 1.5,
        ),
      ),
    );
  }
}

// ================================================================
// PURPOSE BADGE
// ================================================================

class _PurposeBadge extends StatelessWidget {
  const _PurposeBadge({
    required this.text,
    required this.colorScheme,
    required this.selected,
  });

  final String text;
  final ColorScheme colorScheme;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: selected
            ? colorScheme.surfaceContainerHigh
            : colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: selected
              ? colorScheme.onSurface
              : colorScheme.onSurfaceVariant,
          fontSize: 10,
          height: 1.1,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ================================================================
// DISCLOSURE ITEM
// ================================================================

class _DisclosureItem extends StatelessWidget {
  const _DisclosureItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.colorScheme,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 1,
          ),
          child: Icon(
            icon,
            size: 16,
            color: iconColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 11,
                height: 1.55,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' $description',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ================================================================
// TOP BAR BUTTON
// ================================================================

class _TopBarButton extends StatelessWidget {
  const _TopBarButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.colorScheme,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 22,
      ),
      color: colorScheme.onSurfaceVariant,
      splashRadius: 22,
      constraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ),
      padding: EdgeInsets.zero,
    );
  }
}

// ================================================================
// CUSTODY BADGE
// ================================================================

class _CustodyBadge extends StatelessWidget {
  const _CustodyBadge({
    this.compact = false,
  });

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: BoxConstraints(
        maxWidth: compact ? 210 : 260,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 7 : 8,
        vertical: compact ? 3 : 3,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user_rounded,
            size: compact ? 11 : 12,
            color: colorScheme.secondary,
          ),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              'SEC & NDIC Ring-Fenced Custody',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: compact ? 9 : 10,
                height: 1.1,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// STATUTORY ICON
// ================================================================

class _StatutoryIcon extends StatelessWidget {
  const _StatutoryIcon({
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(
        Icons.badge_rounded,
        size: 22,
        color: colorScheme.primary,
      ),
    );
  }
}

// ================================================================
// NGN BADGE
// ================================================================

class _NgnBadge extends StatelessWidget {
  const _NgnBadge({
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Text(
        'NGN (₦) Escrow Clearing',
        style: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 10,
          height: 1.1,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ================================================================
// DATA MODELS
// ================================================================

class _BankOption {
  const _BankOption({
    required this.id,
    required this.shortName,
    required this.name,
    required this.displayName,
  });

  final String id;
  final String shortName;
  final String name;
  final String displayName;
}

class _PurposeOption {
  const _PurposeOption({
    required this.id,
    required this.title,
    required this.badge,
    required this.description,
  });

  final String id;
  final String title;
  final String badge;
  final String description;
}