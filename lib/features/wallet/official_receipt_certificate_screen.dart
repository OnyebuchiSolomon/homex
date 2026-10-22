import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class OfficialReceiptCertificateScreen extends StatelessWidget {
  const OfficialReceiptCertificateScreen({super.key});

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final hPad = _hPad(context);
    final textTheme = context.textTheme;

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
                    _buildValidationBanner(context),
                    const SizedBox(height: 12),
                    _buildCertificateBody(context),
                    const SizedBox(height: 20),
                    _buildActions(context),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      child: Row(
        children: [
          ScaleOnTap(
            onTap: () => Navigator.of(context).maybePop(),
            child: Icon(Icons.arrow_back, color: context.colors.onSurface),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Official Receipt', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.tertiaryContainer, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text('SEC & CBN VALIDATED', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.onTertiaryContainer, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
          ScaleOnTap(onTap: () {}, child: Padding(padding: const EdgeInsets.all(6), child: Icon(Icons.share, size: 20, color: context.colors.onSurface))),
          ScaleOnTap(onTap: () {}, child: Padding(padding: const EdgeInsets.all(6), child: Icon(Icons.download, size: 20, color: context.colors.onSurface))),
        ],
      ),
    );
  }

  Widget _buildValidationBanner(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.verified, size: 16, color: AppColors.onTertiaryContainer),
          const SizedBox(width: 8),
          Expanded(child: Text('Statutory Proof of Inflow', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
          Text('CERT: NIP-8849201', style: textTheme.labelSmall?.copyWith(fontSize: 11, fontFamily: 'monospace', color: AppColors.lightTextSecondary)),
        ],
      ),
    );
  }

  Widget _buildCertificateBody(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightOutlineVariant),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 3))],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container(height: 6, color: context.colors.primary)),
              Expanded(child: Container(height: 6, color: AppColors.secondary)),
              Expanded(child: Container(height: 6, color: AppColors.primaryContainer)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18),
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
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 6,
                            children: [
                              Text('HomeX', style: textTheme.headlineSmall),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                decoration: BoxDecoration(color: AppColors.lightSurfaceContainerHigh, borderRadius: BorderRadius.circular(3)),
                                child: Text('ESCROW RAIL', style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Licensed SEC Digital Sub-Broker & NDIC Custody Rails',
                            style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('OFFICIAL CERTIFICATE', style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightTextSecondary)),
                        Text('REC-NIBSS-20241028', style: textTheme.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
                        Text('28 Oct 2024, 11:05 WAT', style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightTextSecondary)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('SETTLEMENT STATUS', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary)),
                            Row(
                              children: [
                                const Icon(Icons.check_circle, size: 14, color: AppColors.onTertiaryContainer),
                                const SizedBox(width: 4),
                                Text('SETTLED & IRREVOCABLE', style: textTheme.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.lightSurfaceContainerHighest, borderRadius: BorderRadius.circular(999)),
                        child: Text('Tier 3 Clear', style: textTheme.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightOutlineVariant)),
                  child: Column(
                    children: [
                      Text('SETTLED ESCROW INFLOW', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      FittedBox(fit: BoxFit.scaleDown, child: Text('₦1,700,000.00', style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 30))),
                      const SizedBox(height: 4),
                      Text('One Million, Seven Hundred Thousand Naira Only', style: textTheme.labelSmall?.copyWith(fontSize: 11, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLowest, borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.apartment, size: 16, color: AppColors.secondary),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'HomeX Escrow Wallet Top-Up / Prime Allocation Reserve (Lekki Phase 1, #ESC-8942)',
                                style: textTheme.labelSmall?.copyWith(fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _coordCard(context, title: 'Originating Remitter', rows: {'Entity': 'Chief T. Adeleke', 'Institution': 'Zenith Bank PLC', 'Account': '•••• 4932'})),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _coordCard(context, title: 'Beneficiary & Vault', rows: {'Investor': 'Alexander Magnus', 'NUBAN': '9928 3401 92', 'Trustee': 'Providus / Stanbic'})),
                  ],
                ),
                const SizedBox(height: 16),
                Text('FINANCIAL BREAKDOWN', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant)),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _breakdownRow(context, 'Gross Inflow', '1,700,000.00'),
                      const SizedBox(height: 8),
                      _breakdownRow(context, 'EMT Levy', '0.00 (Waived)'),
                      const SizedBox(height: 8),
                      _breakdownRow(context, 'Escrow Custody Fee', '0.00'),
                      const SizedBox(height: 8),
                      Container(height: 1, color: AppColors.lightOutlineVariant),
                      const SizedBox(height: 8),
                      _breakdownRow(context, 'Net Settled Value', '1,700,000.00', bold: true),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerHigh, borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      child: Icon(Icons.qr_code_2, size: 32, color: context.colors.primary),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Scan to Verify Audit', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                          Text('Cryptographically verified & synchronized with the CBN Ledger.', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary)),
                          Text('SHA256: e8f4c0291ba489...', style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightOutline)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(height: 1, color: AppColors.lightOutlineVariant),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tunde Adeleke, Esq.', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                          Text('Senior Trustee Officer, Stanbic IBTC', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.secondary, width: 2), color: AppColors.secondaryFixed.withValues(alpha: 0.2)),
                          alignment: Alignment.center,
                          child: Text('NDIC\nSECURED', textAlign: TextAlign.center, style: textTheme.labelSmall?.copyWith(fontSize: 7, color: AppColors.secondary, fontWeight: FontWeight.w800)),
                        ),
                        Text('SEAL #8942', style: textTheme.labelSmall?.copyWith(fontSize: 8, color: AppColors.lightOutline)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'This receipt is an electronic statutory certificate issued pursuant to Section 14 of the Nigerian Electronic Transactions Act (ETA) and NDIC Insured Escrow Guidelines.',
                  style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightOutline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _coordCard(BuildContext context, {required String title, required Map<String, String> rows}) {
    final textTheme = context.textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...rows.entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Expanded(child: Text(e.key, style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary))),
                Flexible(child: Text(e.value, textAlign: TextAlign.right, style: textTheme.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _breakdownRow(BuildContext context, String label, String value, {bool bold = false}) {
    final textTheme = context.textTheme;
    return Row(
      children: [
        Expanded(child: Text(label, style: textTheme.labelSmall?.copyWith(fontWeight: bold ? FontWeight.w700 : FontWeight.w400))),
        Text('₦$value', style: textTheme.labelSmall?.copyWith(fontFamily: 'monospace', fontWeight: bold ? FontWeight.w800 : FontWeight.w600, color: bold ? context.colors.primary : null)),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      children: [
        ScaleOnTap(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.picture_as_pdf, size: 18, color: context.colors.onPrimary),
                const SizedBox(width: 8),
                Text('Save as PDF (A4 Stamped)', style: textTheme.labelMedium?.copyWith(color: context.colors.onPrimary, fontWeight: FontWeight.w700)),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.lightOutlineVariant)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.send, size: 16, color: AppColors.lightTextSecondary),
                const SizedBox(width: 8),
                Text('Email to Legal Representative', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}