import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:homex/ui/global.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  void _copy(BuildContext context, String value, String label) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label copied')));
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
                padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroCard(context),
                    const SizedBox(height: 12),
                    _buildSenderCard(context),
                    const SizedBox(height: 12),
                    _buildRecipientCard(context),
                    const SizedBox(height: 12),
                    _buildAuditBreakdownCard(context),
                    const SizedBox(height: 20),
                    _buildQuickActions(context),
                    const SizedBox(height: 20),
                    _buildPrimaryActions(context),
                    const SizedBox(height: 16),
                    _buildFooterNote(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double hPad) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      child: Row(
        children: [
          ScaleOnTap(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: colors.surfaceContainer, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back, size: 20, color: colors.onSurface),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Transaction Details', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('Statutory Proof of Inflow', style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant)),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(color: colors.tertiaryFixedDim, borderRadius: BorderRadius.circular(999)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, size: 13, color: colors.onTertiaryFixed),
                const SizedBox(width: 4),
                Text('Settled', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: colors.onTertiaryFixed, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          ScaleOnTap(
            onTap: () {},
            child: Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(left: 6),
              decoration: BoxDecoration(color: colors.surfaceContainer, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(Icons.share, size: 18, color: colors.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, {required Widget child, EdgeInsets? padding}) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
      ),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return _card(
      context,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(color: colors.surfaceContainer, borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Icon(Icons.account_balance, size: 18, color: colors.primary),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'INBOUND NIP',
                      style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant, fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: colors.tertiaryFixedDim, borderRadius: BorderRadius.circular(999)),
                child: Text('Settled in Wallet', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: colors.onTertiaryFixed, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('CREDITED AMOUNT', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: colors.onSurfaceVariant)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text('+₦1,700,000.00', style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 32)),
          ),
          const SizedBox(height: 8),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 4,
            children: [
              Icon(Icons.schedule, size: 14, color: colors.onSurfaceVariant),
              Text('Today, 11:05 AM WAT', style: textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: colors.secondary, borderRadius: BorderRadius.circular(4)),
                child: Text('Tier 3 Verified Escrow', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: colors.onSecondary, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: colors.surfaceContainerHigh),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: colors.surfaceContainerLow, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Session ID', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant)),
                      const SizedBox(height: 2),
                      Text('NIP-20241028-ZEN-0912448', style: textTheme.labelSmall?.copyWith(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: colors.surfaceContainerLow, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('System Reference', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant)),
                            Text('ZEN-0912', style: textTheme.labelSmall?.copyWith(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      ScaleOnTap(onTap: () => _copy(context, 'ZEN-0912', 'Reference'), child: Icon(Icons.content_copy, size: 15, color: colors.onSurface)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSenderCard(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: colors.secondaryFixed, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(Icons.upload, size: 14, color: colors.onSecondaryFixed),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'ORIGINATING SOURCE',
                  style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _kvRow(context, 'Sender Name', 'Chief T. Adeleke'),
          const SizedBox(height: 8),
          _kvRow(context, 'Sending Institution', 'Zenith Bank PLC', dot: colors.error),
          const SizedBox(height: 8),
          _kvRow(context, 'Originating Account', '****4932', mono: true),
          const SizedBox(height: 10),
          Container(height: 1, color: colors.surfaceContainerHigh),
          const SizedBox(height: 10),
          _kvRow(context, 'Narration', '"HomeX Escrow Wallet Top-up / Allocation reserve"', italic: true),
        ],
      ),
    );
  }

  Widget _buildRecipientCard(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(color: colors.primaryFixed, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Icon(Icons.download, size: 14, color: colors.onPrimaryFixed),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'HOMEX PROTECTED CUSTODY',
                      style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant, fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(4)),
                child: Text('SEC Regulated', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: colors.onPrimary, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _kvRow(context, 'Beneficiary', 'Alexander Magnus'),
          const SizedBox(height: 8),
          _kvRow(context, 'Destination Vault', 'HomeX NGN Fiat Wallet'),
          const SizedBox(height: 8),
          _kvRow(context, 'Custody Partner', 'Providus Bank / Stanbic IBTC'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(color: colors.surfaceContainerLow, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(child: Text('Dedicated Virtual NUBAN', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant))),
                Text('9928 3401 92', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, fontFamily: 'monospace')),
                const SizedBox(width: 6),
                ScaleOnTap(onTap: () => _copy(context, '9928340192', 'NUBAN'), child: Icon(Icons.content_copy, size: 15, color: colors.onSurface)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kvRow(BuildContext context, String label, String value, {bool mono = false, bool italic = false, Color? dot}) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label, style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant))),
        const SizedBox(width: 8),
        Flexible(
          flex: 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dot != null) ...[Container(width: 6, height: 6, decoration: BoxDecoration(color: dot, shape: BoxShape.circle)), const SizedBox(width: 6)],
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontFamily: mono ? 'monospace' : null,
                    fontStyle: italic ? FontStyle.italic : null,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuditBreakdownCard(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Statutory Audit Breakdown', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    Text('CBN Settlement & NDIC Compliant Ledger', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant)),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: colors.surfaceContainer, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Icon(Icons.shield, size: 18, color: colors.primary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _kvRow(context, 'Gross Inflow', '₦1,700,000.00', mono: true),
          const SizedBox(height: 8),
          _kvRow(context, 'EMT Levy', 'Waived (Tier 3)', mono: true),
          const SizedBox(height: 10),
          Container(height: 1, color: colors.surfaceContainerHigh),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: Text('Net Credited Balance', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700))),
              Text('₦1,700,000.00', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, color: colors.primary)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: colors.surfaceContainerLow, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Updated Wallet Balance', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant)),
                      Text('Available for allocation', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: colors.onSurfaceVariant)),
                    ],
                  ),
                ),
                Text('₦1,200,000.00', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, color: colors.primary)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: colors.surfaceContainer, borderRadius: BorderRadius.circular(10), border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.verified_user, size: 18, color: colors.secondary),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant, height: 1.5),
                      children: [
                        TextSpan(text: 'NDIC Custodial Protection: ', style: TextStyle(fontWeight: FontWeight.w700, color: colors.onSurface)),
                        const TextSpan(text: 'Funds deposited are held in strict segregated escrow with Stanbic IBTC Trustees and Providus Bank PLC.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    final actions = [
      [Icons.real_estate_agent, 'Fund Milestone', colors.primaryFixed, colors.onPrimaryFixed],
      [Icons.swap_horiz, 'Transfer / Out', colors.secondaryFixed, colors.onSecondaryFixed],
      [Icons.contact_support, 'Query Inflow', colors.surfaceContainer, colors.onSurface],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ESCROW ACTIONS', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Row(
          children: actions
              .map((a) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: a == actions.last ? 0 : 8),
              child: ScaleOnTap(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(color: a[2] as Color, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Icon(a[0] as IconData, size: 16, color: a[3] as Color),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        a[1] as String,
                        textAlign: TextAlign.center,
                        style: textTheme.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPrimaryActions(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Column(
      children: [
        ScaleOnTap(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download, size: 18, color: colors.onPrimary),
                const SizedBox(width: 8),
                Text('Download Official PDF Receipt', style: textTheme.labelMedium?.copyWith(color: colors.onPrimary, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ScaleOnTap(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.outlineVariant)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.forward_to_inbox, size: 18, color: colors.onSurface),
                const SizedBox(width: 8),
                Text('Share Statutory Audit Proof', style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterNote(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 14, color: colors.tertiary),
            const SizedBox(width: 6),
            Text('End-to-End SEC Nigeria Protected Escrow', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Need assistance? Contact 24/7 Escrow Concierge.',
          textAlign: TextAlign.center,
          style: textTheme.labelSmall?.copyWith(fontSize: 11, color: colors.onSurfaceVariant),
        ),
      ],
    );
  }
}