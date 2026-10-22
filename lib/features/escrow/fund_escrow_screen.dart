import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homex/ui/global.dart';

class FundEscrowScreen extends StatefulWidget {
  const FundEscrowScreen({super.key});

  @override
  State<FundEscrowScreen> createState() => _FundEscrowScreenState();
}

class _FundEscrowScreenState extends State<FundEscrowScreen> {
  static const List<int> _percentAmounts = [
    3750000,
    7500000,
    11250000,
    15000000,
  ];
  static const List<String> _percentLabels = ['25%', '50%', '75%', '100% Full'];

  int _selectedPercentIndex = 3; // 100% selected by default
  int _selectedChannelIndex = 0; // Dynamic Escrow Wire selected by default

  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: _formatAmount(15000000));
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String _formatAmount(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }

  void _selectPercent(int index) {
    setState(() {
      _selectedPercentIndex = index;
      _amountController.text = _formatAmount(_percentAmounts[index]);
    });
  }

  void _copyToClipboard(String value, String label) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label copied'), duration: const Duration(seconds: 1)),
    );
  }

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final hPad = _hPad(context);

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 20, hPad, 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeIn(child: _buildPropertyCard(context)),
                    const SizedBox(height: 24),
                    SlideFadeIn(child: _buildFundingAmountSection(context)),
                    const SizedBox(height: 24),
                    SlideFadeIn(
                      delay: AppAnimations.shortDelay,
                      child: _buildPaymentChannelsSection(context),
                    ),
                    const SizedBox(height: 24),
                    _buildRegulatoryFootnote(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionTray(context, hPad),
    );
  }

  // ---------------------------------------------------------------------
  // STICKY TOP HEADER
  // ---------------------------------------------------------------------
  Widget _buildHeader(BuildContext context, double hPad) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    return Container(
      color: context.theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 12),
      child: Row(
        children: [
          ScaleOnTap(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(Icons.close, size: 20, color: colors.onSurface),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fund Escrow',
                  style: textTheme.headlineSmall?.copyWith(fontSize: 19),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Transaction ID: #ESC-8942',
                  style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: colors.outlineVariant),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, size: 16, color: colors.secondary),
                const SizedBox(width: 4),
                Text(
                  'Verified Trust',
                  style: textTheme.labelSmall?.copyWith(color: colors.secondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // PROPERTY CONTEXT CARD
  // ---------------------------------------------------------------------
  Widget _buildPropertyCard(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: ImageView.networkCached(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCkzHSQHxEznVUGhtZ5AOEkCTjA59R0Mmks37Si3ZuIosalUg32nOfz2EaeGiDjChHcusZyu7ef74iwyQNuHP5YuE3W177W_N87litKmfziEokDLW94ZN4kkDlFfvaNmXlmZhV1HGPgIDa2PtuTeO42Y9j8wd7H3Dtf7y3hqLybrHKMgNXeDf5RVbCuqhbi_FKkSujjW0hVFpT5sErOWRmQizsA2aIgIsMbgJwhBSuhHq-TNBt4hyAU',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorWidget: Container(
                      color: colors.surfaceContainer,
                      child: Icon(Icons.image_not_supported_outlined, color: colors.onSurfaceVariant),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Milestone 2 of 4',
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'The Ikoyi Pearl - Lekki Phase 1',
                      style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 13, color: colors.outline),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            'Block B, Waterfront Avenue, Lagos',
                            style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              ScaleOnTap(
                onTap: () {},
                child: Text(
                  'Change',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: colors.surfaceContainerHigh),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Outstanding Escrow Balance',
                    style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '₦15,000,000.00',
                      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Due Date',
                    style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 2),
                  Text('Oct 28, 2024', style: textTheme.labelMedium),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // FUNDING AMOUNT SECTION
  // ---------------------------------------------------------------------
  Widget _buildFundingAmountSection(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Enter Funding Amount', style: textTheme.labelMedium),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shield, size: 14, color: colors.onTertiaryContainer),
                const SizedBox(width: 4),
                Text(
                  'SEC Regulated',
                  style: textTheme.labelSmall?.copyWith(color: colors.onTertiaryContainer),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextEditView(
          controller: _amountController,
          prefixText: '₦',
          hintText: '0.00',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          suffixIcon: ScaleOnTap(
            onTap: () => setState(() => _amountController.clear()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Clear', style: textTheme.labelSmall),
            ),
          ),
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final gap = 8.0;
            final itemWidth = (constraints.maxWidth - gap * 3) / 4;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: List.generate(_percentLabels.length, (index) {
                final selected = _selectedPercentIndex == index;
                return SizedBox(
                  width: itemWidth,
                  child: ScaleOnTap(
                    onTap: () => _selectPercent(index),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? colors.primary : colors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selected ? colors.primary : colors.outlineVariant,
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        _percentLabels[index],
                        style: textTheme.labelSmall?.copyWith(
                          color: selected ? colors.onPrimary : colors.onSurfaceVariant,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info, size: 18, color: colors.secondary),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'Escrow Processing: ',
                        style: TextStyle(fontWeight: FontWeight.w600, color: colors.onSurface),
                      ),
                      const TextSpan(text: '0.5% standard fee (₦75,000) is '),
                      TextSpan(
                        text: '100% Waived',
                        style: TextStyle(fontWeight: FontWeight.w600, color: colors.onTertiaryContainer),
                      ),
                      const TextSpan(text: ' for Diamond Tier Corporate Investors. Net payable is strictly '),
                      TextSpan(
                        text: '₦15,000,000.00',
                        style: TextStyle(fontWeight: FontWeight.w600, color: colors.primary),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // PAYMENT CHANNELS SECTION
  // ---------------------------------------------------------------------
  Widget _buildPaymentChannelsSection(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Payment Channel', style: textTheme.labelMedium),
        const SizedBox(height: 10),
        _buildDynamicWireChannel(context),
        const SizedBox(height: 10),
        _buildSimpleChannel(
          context,
          index: 1,
          icon: Icons.account_balance_wallet,
          title: 'HomeX Digital Wallet',
          subtitle: 'Direct settlement from your verified corporate wallet',
          badge: 'Balance: ₦45,250,000',
        ),
        const SizedBox(height: 10),
        _buildSimpleChannel(
          context,
          index: 2,
          icon: Icons.credit_card,
          title: 'Institutional Corporate Card',
          subtitle: 'Mastercard / Visa Corporate Direct Clearing',
        ),
      ],
    );
  }

  Widget _buildDynamicWireChannel(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    final selected = _selectedChannelIndex == 0;

    return ScaleOnTap(
      onTap: () => setState(() => _selectedChannelIndex = 0),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.account_balance, size: 22, color: colors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Text(
                            'Dynamic Escrow Wire (NIP / RTGS)',
                            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: colors.secondaryFixed,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Instant',
                              style: textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                color: colors.onSecondaryFixed,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Dedicated reserve account for Stanbic IBTC Trustees',
                        style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _radioDot(context, selected: selected),
              ],
            ),
            if (selected) ...[
              const SizedBox(height: 14),
              Container(height: 1, color: colors.outlineVariant.withValues(alpha: 0.3)),
              const SizedBox(height: 12),
              _buildKeyValueRow(context, 'Bank Name', 'Stanbic IBTC Bank Plc / Providus'),
              const SizedBox(height: 8),
              _buildKeyValueRow(
                context,
                'Beneficiary / Account Name',
                'HomeX Custody - Escrow Trustees',
              ),
              const SizedBox(height: 10),
              _buildAccountCopyRow(context),
              const SizedBox(height: 10),
              _buildReferenceRow(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildKeyValueRow(BuildContext context, String label, String value) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountCopyRow(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    const accountNumber = '9928 3401 92';

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DYNAMIC ESCROW ACCOUNT',
                  style: textTheme.labelSmall?.copyWith(fontSize: 10, color: colors.outline),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    accountNumber,
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
          ),
          ScaleOnTap(
            onTap: () => _copyToClipboard(accountNumber, 'Account number'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Icon(Icons.content_copy, size: 15,),
                  const SizedBox(width: 4),
                  Text(
                    'Copy',
                    style: textTheme.labelSmall?.copyWith(
                      // color: colors.primary,
                      fontWeight: FontWeight.w600,
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

  Widget _buildReferenceRow(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    const reference = 'ESC-8942-IKP';

    return Row(
      children: [
        Text('Payment Reference', style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant)),
        const Spacer(),
        Text(
          reference,
          style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, fontFamily: 'monospace'),
        ),
        const SizedBox(width: 4),
        ScaleOnTap(
          onTap: () => _copyToClipboard(reference, 'Reference'),
          child: Icon(Icons.content_copy, size: 14, color: colors.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildSimpleChannel(
      BuildContext context, {
        required int index,
        required IconData icon,
        required String title,
        required String subtitle,
        String? badge,
      }) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    final selected = _selectedChannelIndex == index;

    return ScaleOnTap(
      onTap: () => setState(() => _selectedChannelIndex = index),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: selected ? 1.1 : 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 22, color: colors.onSurfaceVariant),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Text(title, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                      if (badge != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.surfaceContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badge,
                            style: textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                              color: colors.onTertiaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _radioDot(context, selected: selected),
          ],
        ),
      ),
    );
  }

  Widget _radioDot(BuildContext context, {required bool selected}) {
    final colors = context.colors;
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? colors.primary : Colors.transparent,
        border: Border.all(
          color: selected ? colors.primary : colors.outlineVariant,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: selected
          ? Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(shape: BoxShape.circle, color: colors.onPrimary),
      )
          : null,
    );
  }

  // ---------------------------------------------------------------------
  // REGULATORY FOOTNOTE
  // ---------------------------------------------------------------------
  Widget _buildRegulatoryFootnote(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.gavel, size: 20, color: colors.secondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'REGULATORY TRUSTEE CUSTODY',
                  style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.4),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Funds are held in ring-fenced trustee custody under NDIC and SEC-licensed trustees. '
                'HomeX executes disbursement only upon verified digital milestone inspection and dual-key '
                'cryptographic authorization.',
            style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant, height: 1.5),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // STICKY BOTTOM ACTION TRAY
  // ---------------------------------------------------------------------
  Widget _buildActionTray(BuildContext context, double hPad) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor.withValues(alpha: 0.97),
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      padding: EdgeInsets.fromLTRB(hPad, 12, hPad, context.bottomPadding + 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Total Funding Commitment:',
                  style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '₦${_amountController.text.isEmpty ? '0.00' : _amountController.text}',
                style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ScaleOnTap(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Confirm & Generate Payment Slip',
                      textAlign: TextAlign.center,
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18, color: colors.onPrimary),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          ScaleOnTap(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Save Draft & Complete Later',
                style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
              ),
            ),
          ),
        ],
      ),
    );
  }
}