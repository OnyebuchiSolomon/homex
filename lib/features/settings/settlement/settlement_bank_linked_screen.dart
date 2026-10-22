import 'package:homex/ui/global.dart';
class SettlementBankLinkedScreen extends StatefulWidget {
  const SettlementBankLinkedScreen({super.key});

  @override
  State<SettlementBankLinkedScreen> createState() => _SettlementBankLinkedScreenState();
}

class _SettlementBankLinkedScreenState extends State<SettlementBankLinkedScreen> {
  bool _copied = false;

  void _copyNuban(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: '0234881920'));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colors;
    final hPad = _hPad(context);

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 24),
                child: Column(
                  children: [
                    FadeScaleIn(child: _buildHeroSuccess(context)),
                    const SizedBox(height: 20),
                    SlideFadeIn(child: _buildBankDetailsCard(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(delay: AppAnimations.shortDelay, child: _buildSecurityCard(context)),
                    const SizedBox(height: 20),
                    _buildActions(context),
                    const SizedBox(height: 16),
                    _buildFooter(context),
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
    final cs = context.colors;
    final tt = context.textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      child: Row(
        children: [
          ScaleOnTap(onTap: () => Navigator.of(context).maybePop(), child: Icon(Icons.arrow_back, color: cs.onSurface)),
          const SizedBox(width: 10),
          Expanded(child: Text('Bank Account Linked', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(999), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.verified_user, size: 13, color: cs.secondary),
              const SizedBox(width: 4),
              Flexible(child: Text('SEC & NDIC Ring-Fenced', style: tt.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSuccess(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      children: [
        SizedBox(
          width: 96,
          height: 96,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Pulse(
                duration: const Duration(milliseconds: 3000),
                child: Container(width: 96, height: 96, decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryFixedDim.withValues(alpha: 0.4))),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryContainer, boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 10)], border: Border.all(color: cs.onTertiaryContainer.withValues(alpha: 0.3))),
                alignment: Alignment.center,
                child: Icon(Icons.verified, size: 36, color: cs.tertiaryFixed),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: cs.tertiaryContainer, borderRadius: BorderRadius.circular(999), border: Border.all(color: cs.onTertiaryContainer.withValues(alpha: 0.2))),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.check_circle, size: 13, color: cs.onTertiaryContainer),
            const SizedBox(width: 5),
            Text('100% NIBSS MATCH VERIFIED', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryContainer, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
          ]),
        ),
        const SizedBox(height: 10),
        Text('Settlement Account Linked Successfully!', textAlign: TextAlign.center, style: tt.headlineSmall),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            style: tt.bodyMedium?.copyWith(fontSize: 13, color: cs.onSurfaceVariant, height: 1.5),
            children: [
              const TextSpan(text: 'Guaranty Trust Bank (GTBank) account has been cryptographically authorized and bound to '),
              TextSpan(text: 'Alexander Magnus', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
              const TextSpan(text: ' for automated escrow disbursements.'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBankDetailsCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(color: cs.secondaryContainer.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.secondaryContainer.withValues(alpha: 0.4))),
                      alignment: Alignment.center,
                      child: Text('GT', style: tt.bodyMedium?.copyWith(color: cs.secondary, fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Guaranty Trust Bank', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('GTBank Nigeria PLC', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(999)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: cs.secondaryContainer, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text('Commercial / Escrow Rail', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
              ]),
            ),
          ]),
          const SizedBox(height: 12),
          Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.2)),
          const SizedBox(height: 12),
          Text('Account Holder', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
          const SizedBox(height: 4),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              Text('Alexander Magnus', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: cs.tertiaryFixed.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(4)),
                child: Text('BVN/NIN Statutory Match', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryContainer, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NUBAN ACCOUNT NUMBER', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
                      Text('0234 881 920', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w800, fontFamily: 'monospace', letterSpacing: 1)),
                    ],
                  ),
                ),
                ScaleOnTap(
                  onTap: () => _copyNuban(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(8), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(_copied ? Icons.check : Icons.content_copy, size: 14, color: cs.onSurface),
                      const SizedBox(width: 4),
                      Text(_copied ? 'Copied!' : 'Copy', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _detailTile(context, label: 'Classification', value: 'Designated Secondary Escrow', caption: 'Failover Routing Active', captionColor: cs.secondary)),
              const SizedBox(width: 8),
              Expanded(child: _detailTile(context, label: 'Tier & Transacting Ceiling', value: 'Tier 3 Institutional', caption: '₦450,000,000 Cap', captionColor: cs.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailTile(BuildContext context, {required String label, required String value, required String caption, required Color captionColor}) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
          const SizedBox(height: 2),
          Text(value, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
          Text(caption, style: tt.labelSmall?.copyWith(fontSize: 10, color: captionColor, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildSecurityCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.lock_clock, size: 18, color: cs.primaryContainer),
            const SizedBox(width: 8),
            Text('Security & Institutional Governance', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.4)),
          ]),
          const SizedBox(height: 10),
          Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.2)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.secondaryFixed.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.secondaryFixedDim.withValues(alpha: 0.4))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.history_toggle_off, size: 16, color: cs.secondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('24-Hour Disbursement Cooling Lock Active', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: cs.onSecondaryFixed)),
                      const SizedBox(height: 3),
                      Text(
                        'SEC Rule 184(b) & NDIC Protocol: Outflow releases above ₦10,000,000 will be locked for a mandatory 24-hour verification cooling window to prevent unauthorized diversion.',
                        style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSecondaryFixedVariant, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.fingerprint, size: 14, color: cs.onTertiaryContainer),
              const SizedBox(width: 6),
              Expanded(child: Text('Biometric 2FA Signature', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant))),
              Text('Device HSM Synced', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 6),
          Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.15)),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.key, size: 14, color: cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Expanded(child: Text('Hardware Enclave Hash', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(4)),
                child: Text('ECDSA SHA-256 e8f4c...90fa2', style: tt.labelSmall?.copyWith(fontSize: 10, fontFamily: 'monospace')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      children: [
        ScaleOnTap(
          onTap: () => AppNavigator.popUntil((route)=>route.isFirst),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text('Done & Return to Settlement Accounts', textAlign: TextAlign.center, style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
                const SizedBox(width: 6),
                Icon(Icons.chevron_right, size: 18, color: cs.onPrimary),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // ScaleOnTap(
        //   onTap: () {},
        //   child: Container(
        //     width: double.infinity,
        //     padding: const EdgeInsets.symmetric(vertical: 12),
        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(Icons.download, size: 16, color: cs.onSurfaceVariant),
        //         const SizedBox(width: 8),
        //         Flexible(child: Text('Download Banking Custody Mandate (PDF)', textAlign: TextAlign.center, style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
        //       ],
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 8),
        // ScaleOnTap(onTap: () {}, child: Text('View Active Escrow Contracts', style: tt.labelSmall?.copyWith(color: cs.primary, fontWeight: FontWeight.w600, decoration: TextDecoration.underline))),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      children: [
        Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.3)),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.security, size: 13, color: cs.onSurfaceVariant),
          const SizedBox(width: 6),
          Text('INSTITUTIONAL COMPLIANCE ENGINE', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ]),
        const SizedBox(height: 4),
        Text(
          'SEC Nigeria Regulated Sub-Broker • NDIC Insured Escrow Partner • Central Bank of Nigeria (CBN) Direct Settlement Rail',
          textAlign: TextAlign.center,
          style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant, height: 1.4),
        ),
      ],
    );
  }
}