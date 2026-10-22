import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class _LedgerTx {
  final String dateGroup;
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String title;
  final String subtitle;
  final IconData subtitleIcon;
  final String amount;
  final Color amountColor;
  final String statusLabel;
  final Color statusBg;
  final Color statusFg;
  final String ref;
  final String custodian;

  const _LedgerTx({
    required this.dateGroup,
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.title,
    required this.subtitle,
    required this.subtitleIcon,
    required this.amount,
    required this.amountColor,
    required this.statusLabel,
    required this.statusBg,
    required this.statusFg,
    required this.ref,
    required this.custodian,
  });
}

class EscrowStatementScreen extends StatefulWidget {
  const EscrowStatementScreen({super.key});

  @override
  State<EscrowStatementScreen> createState() => _EscrowStatementScreenState();
}

class _EscrowStatementScreenState extends State<EscrowStatementScreen> {
  int _selectedFilter = 0;
  static const List<String> _filters = [
    'All Movements',
    'Inflows (Deposits)',
    'Disbursements (Releases)',
    'Escrow Fees',
    'Refunds',
  ];

  /// Was `static const List<_LedgerTx>`. Colors now come from the active
  /// theme (context.colors), which isn't known at compile time, so this
  /// moved from a static const field to a method built per-frame.
  List<_LedgerTx> _buildLedger(BuildContext context) {
    final colors = context.colors;
    return [
      _LedgerTx(
        dateGroup: 'Today, Oct 28, 2023',
        icon: Icons.south_west,
        iconBg: colors.surfaceContainerLow,
        iconFg: colors.onTertiaryContainer,
        title: 'Deposit - The Ikoyi Pearl (Milestone 2/4)',
        subtitle: 'Block B, Waterfront Ave, Lekki',
        subtitleIcon: Icons.location_on,
        amount: '+₦15,000,000.00',
        amountColor: colors.onTertiaryContainer,
        statusLabel: 'Settled',
        statusBg: colors.tertiaryFixedDim,
        statusFg: colors.onTertiaryContainer,
        ref: 'Ref: ESC-8942-IKP',
        custodian: 'Stanbic IBTC Custody',
      ),
      _LedgerTx(
        dateGroup: 'Oct 24, 2023',
        icon: Icons.south_west,
        iconBg: colors.surfaceContainerLow,
        iconFg: colors.onTertiaryContainer,
        title: 'Initial Deposit - Asokoro Heights',
        subtitle: 'Asokoro, Abuja',
        subtitleIcon: Icons.location_on,
        amount: '+₦45,500,000.00',
        amountColor: colors.onTertiaryContainer,
        statusLabel: 'Settled',
        statusBg: colors.tertiaryFixedDim,
        statusFg: colors.onTertiaryContainer,
        ref: 'Ref: ESC-7721-ASK',
        custodian: 'Providus Escrow Trust',
      ),
      _LedgerTx(
        dateGroup: 'Oct 18, 2023',
        icon: Icons.north_east,
        iconBg: colors.surfaceContainerLow,
        iconFg: colors.secondary,
        title: 'Disbursement - Victoria Island Penthouse (Final Handover)',
        subtitle: 'Released to Seller (Deed of Transfer verified)',
        subtitleIcon: Icons.verified,
        amount: '-₦60,000,000.00',
        amountColor: colors.onSurface,
        statusLabel: 'Disbursed',
        statusBg: colors.secondaryFixed,
        statusFg: colors.secondary,
        ref: 'Ref: REL-6619-VIP',
        custodian: 'SEC Trustee Sign-off',
      ),
      _LedgerTx(
        dateGroup: 'Oct 12, 2023',
        icon: Icons.hourglass_top,
        iconBg: colors.surfaceContainerLow,
        iconFg: colors.onSurfaceVariant,
        title: 'Earnest Deposit - Riverside Duplex',
        subtitle: 'GRA Phase 2, Port Harcourt',
        subtitleIcon: Icons.location_on,
        amount: '+₦15,000,000.00',
        amountColor: colors.onSurface,
        statusLabel: 'Pending Verification',
        statusBg: colors.surfaceContainer,
        statusFg: colors.onSurfaceVariant,
        ref: 'Ref: ESC-5412-RSD',
        custodian: 'Stanbic IBTC Custody',
      ),
    ];
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
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterChips(context),
                    const SizedBox(height: 16),
                    FadeIn(child: _buildSummaryCard(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(child: _buildPdfBanner(context)),
                    const SizedBox(height: 20),
                    _buildLedgerHeader(context),
                    const SizedBox(height: 12),
                    ..._buildLedgerGroups(context),
                    const SizedBox(height: 8),
                    _buildFooterNotice(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  Widget _buildHeader(BuildContext context, double hPad) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Container(
      color: context.theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      child: Row(
        children: [
          ScaleOnTap(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: const Icon(Icons.arrow_back),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Escrow Statement',
                  style: textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
                    const SizedBox(width: 4),
                    Text(
                      'Audited Ledger',
                      style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ScaleOnTap(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(Icons.share, size: 20, color: colors.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.outlineVariant.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month, size: 16),
                  const SizedBox(width: 6),
                  Text('Statement Period', style: textTheme.labelSmall),
                ],
              ),
              ScaleOnTap(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color.surfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Oct 1 – Oct 31, 2023', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
                      const Icon(Icons.expand_more, size: 14),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Custody Vault ID:', style: textTheme.labelSmall),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'ESC-VAULT-STANBIC-992834',
                    style: textTheme.labelSmall?.copyWith(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: color.surfaceContainerHigh),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'REMAINING LOCKED IN CUSTODY',
                  style: textTheme.labelSmall?.copyWith(fontSize: 11),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.surfaceContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock, size: 12, color: color.secondary),
                    const SizedBox(width: 3),
                    Text('Dual-Key Ringfenced', style: textTheme.labelSmall?.copyWith(fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('₦', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(width: 2),
                Text(
                  '85,500,000.00',
                  style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 30),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Held under Providus & Stanbic IBTC Trust deed stipulations.',
            style: textTheme.labelSmall?.copyWith(fontSize: 11),
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: color.surfaceContainerHigh),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildMetricTile(context, icon: Icons.arrow_downward, iconColor: color.onTertiaryContainer, label: 'Cumulative Inflows', amount: '₦145,500,000.00', caption: '3 Total Transactions')),
              const SizedBox(width: 8),
              Expanded(child: _buildMetricTile(context, icon: Icons.arrow_upward, iconColor: color.secondary, label: 'Total Disbursed', amount: '₦60,000,000.00', caption: 'Milestone Released')),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: color.surfaceContainerLow.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              runSpacing: 4,
              children: [
                Icon(Icons.percent, size: 16, color: color.secondary),
                Text('Accrued Escrow Fee:', style: textTheme.labelSmall?.copyWith(fontSize: 11)),
                Text(
                  '₦727,500',
                  style: textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.secondaryFixed,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 11, color: color.onSecondaryFixed),
                      const SizedBox(width: 3),
                      Text(
                        '100% FEE WAIVED',
                        style: textTheme.labelSmall?.copyWith(fontSize: 10, color: color.onSecondaryFixed, fontWeight: FontWeight.w700),
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

  Widget _buildMetricTile(BuildContext context, {required IconData icon, required Color iconColor, required String label, required String amount, required String caption}) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: iconColor),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(amount, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
          ),
          Text(caption, style: textTheme.labelSmall?.copyWith(fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedFilter == index;
          return ScaleOnTap(
            onTap: () => setState(() => _selectedFilter = index),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: selected ? color.primary : color.surfaceContainerLow,
                borderRadius: BorderRadius.circular(999),
                border: selected ? null : Border.all(color: color.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: Text(
                _filters[index],
                style: textTheme.labelSmall?.copyWith(
                  color: selected ? color.onPrimary : color.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPdfBanner(BuildContext context) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: color.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.outlineVariant.withValues(alpha: 0.6)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.outlineVariant.withValues(alpha: 0.4)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.picture_as_pdf, size: 22,),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    Text('Official PDF Statement', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: color.secondaryFixed,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        'NDIC SEALED',
                        style: textTheme.labelSmall?.copyWith(fontSize: 9, color: color.onSecondaryFixed, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Includes audited cryptographic hashes & trustee signatures',
                  style: textTheme.labelSmall?.copyWith(fontSize: 11, color: color.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ScaleOnTap(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: color.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.outlineVariant),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.download, size: 15, color: color.primary),
                  const SizedBox(width: 4),
                  Text('Get PDF', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLedgerHeader(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Audit Trail & Ledger', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
        Text('4 Records in Period', style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant)),
      ],
    );
  }

  List<Widget> _buildLedgerGroups(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    final ledger = _buildLedger(context);
    final widgets = <Widget>[];
    String? lastGroup;

    for (final tx in ledger) {
      if (tx.dateGroup != lastGroup) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 8),
          child: Row(
            children: [
              Text(
                tx.dateGroup.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant),
              ),
              const SizedBox(width: 8),
              Expanded(child: Container(height: 1, color: colors.outlineVariant.withValues(alpha: 0.4))),
            ],
          ),
        ));
        lastGroup = tx.dateGroup;
      }
      widgets.add(ScrollReveal(child: _buildLedgerCard(context, tx)));
      widgets.add(const SizedBox(height: 4));
    }
    return widgets;
  }

  Widget _buildLedgerCard(BuildContext context, _LedgerTx tx) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: tx.iconBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Icon(tx.icon, size: 17, color: tx.iconFg),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(tx.subtitleIcon, size: 13, color: colors.onSurfaceVariant),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            tx.subtitle,
                            style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      tx.amount,
                      style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: tx.amountColor),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: tx.statusBg, borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      tx.statusLabel,
                      style: textTheme.labelSmall?.copyWith(fontSize: 10, color: tx.statusFg, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: colors.surfaceContainer),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tx.ref, style: textTheme.labelSmall?.copyWith(fontSize: 11, fontFamily: 'monospace', color: colors.onSurfaceVariant)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.account_balance, size: 12, color: colors.secondary),
                  const SizedBox(width: 3),
                  Text(tx.custodian, style: textTheme.labelSmall?.copyWith(fontSize: 10, color: colors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterNotice(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: colors.surfaceContainer, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(Icons.shield, size: 18, color: colors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Statutory Ring-Fenced Custody', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(
                      'All client capital is held in segregated trust vaults under SEC-licensed trustees and NDIC deposit insurance regulations. Funds are released exclusively upon dual-key cryptographic authorization and mutual milestone verification.',
                      style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ScaleOnTap(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colors.outlineVariant),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified, size: 16, color: colors.secondary),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Download Official Tax & Audit Certificate',
                      style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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