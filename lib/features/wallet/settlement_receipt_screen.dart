
import 'package:homex/ui/global.dart';

class SettlementReceiptScreen extends StatelessWidget {
  const SettlementReceiptScreen({super.key});

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
                    _buildContextBanner(context),
                    const SizedBox(height: 14),
                    _buildReceiptSheet(context),
                    const SizedBox(height: 16),
                    _buildSupplementaryLinks(context),
                    const SizedBox(height: 20),
                    _buildStickyActionsPreview(context),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      child: Row(
        children: [
          ScaleOnTap(
            onTap: () => Navigator.of(context).maybePop(),
            child: Icon(Icons.arrow_back, color: context.colors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Settlement Receipt', style: textTheme.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.onTertiaryContainer, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text('Audit Verified · Electronic Proof', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary)),
                  ],
                ),
              ],
            ),
          ),
          ScaleOnTap(onTap: () {}, child: Padding(padding: const EdgeInsets.all(6), child: Icon(Icons.share, color: context.colors.primary))),
        ],
      ),
    );
  }

  Widget _buildContextBanner(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.6))),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.verified_user, size: 16, color: AppColors.secondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Regulated Sub-Broker Custody Receipt. Valid for Corporate Tax & Statutory Audit filings.',
                  style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: AppColors.tertiaryContainer, borderRadius: BorderRadius.circular(4)),
              child: Text('SETTLED', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.onTertiaryContainer, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptSheet(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightOutlineVariant),
        boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 4))],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Container(
            height: 8,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [context.colors.primary, AppColors.primaryContainer, AppColors.secondaryContainer]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIssuerHeader(context),
                const SizedBox(height: 24),
                _buildClearanceHero(context),
                const SizedBox(height: 24),
                _buildCoordinatesGrid(context),
                const SizedBox(height: 16),
                _buildNarrationStrip(context),
                const SizedBox(height: 20),
                Text('FINANCIAL SETTLEMENT AUDIT BREAKDOWN', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                _buildBreakdownTable(context),
                const SizedBox(height: 20),
                Container(height: 1, color: AppColors.lightOutlineVariant),
                const SizedBox(height: 20),
                _buildAttestationBlock(context),
                const SizedBox(height: 20),
                Container(height: 1, color: AppColors.lightOutlineVariant),
                const SizedBox(height: 12),
                Text(
                  'This receipt constitutes an official statutory proof of transaction generated electronically by HomeX Technologies Limited under SEC Nigeria Digital Asset & Sub-Broker Guidelines and NDIC Escrow Custody Framework. No physical signature is legally required. Inquiries: compliance@homex.ng | Ref: RCT-2024-NIP-0912448.',
                  textAlign: TextAlign.center,
                  style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightTextSecondary, height: 1.5),
                ),
              ],
            ),
          ),
          Container(height: 8, color: AppColors.lightSurfaceContainerHigh),
        ],
      ),
    );
  }

  Widget _buildIssuerHeader(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: Icon(Icons.account_balance, color: context.colors.onPrimary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HOMEX TECHNOLOGIES LIMITED',
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '& Escrow Trustees (Nigeria) Custody Network',
                    style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _issuerBadge(context, icon: Icons.shield, label: 'SEC Nigeria Regulated Sub-Broker'),
            _issuerBadge(context, icon: Icons.lock, label: 'NDIC Insured Escrow Partner'),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('STATUTORY SETTLEMENT RECEIPT', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.secondary, fontWeight: FontWeight.w700)),
              Text('RCT-2024-NIP-0912448', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, fontFamily: 'monospace')),
              Text('28 Oct 2024, 11:05:42 AM WAT', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary)),
              Text('Channel: NIBSS Instant Payment (NIP)', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightOutline)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _issuerBadge(BuildContext context, {required IconData icon, required String label}) {
    final textTheme = context.textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.5))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.secondary),
          const SizedBox(width: 4),
          Text(label, style: textTheme.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildClearanceHero(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.7))),
      child: Column(
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 4,
            children: [
              const Icon(Icons.check_circle, size: 16, color: AppColors.onTertiaryContainer),
              Text('CBN / NIBSS CLEARED & AUDITED', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.onTertiaryContainer, fontWeight: FontWeight.w700)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppColors.lightSurfaceContainerHigh, borderRadius: BorderRadius.circular(4)),
                child: Text('SESSION #NIP-0912448', style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightTextSecondary, fontFamily: 'monospace')),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('TOTAL SETTLEMENT INFLOW', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: RichText(
              text: TextSpan(
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 34, fontFamily: 'monospace'),
                children: const [
                  TextSpan(text: '+₦'),
                  TextSpan(text: '1,700,000'),
                  TextSpan(text: '.00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.lightTextSecondary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Amount in words: One Million, Seven Hundred Thousand Nigerian Naira Only',
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(fontSize: 11, fontStyle: FontStyle.italic, color: AppColors.lightTextSecondary),
          ),
          const SizedBox(height: 16),
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.onTertiaryContainer.withValues(alpha: 0.7), width: 2, style: BorderStyle.solid),
              color: AppColors.tertiaryFixedDim.withValues(alpha: 0.2),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, size: 20, color: AppColors.onTertiaryContainer),
                Text('CENTRAL\nCLEARING', textAlign: TextAlign.center, style: textTheme.labelSmall?.copyWith(fontSize: 8, color: AppColors.onTertiaryFixed, fontWeight: FontWeight.w800, height: 1.1)),
                Text('CBN / NIBSS', style: textTheme.labelSmall?.copyWith(fontSize: 7, color: AppColors.onTertiaryContainer, fontWeight: FontWeight.w700)),
                Text('SETTLED · SEC', style: textTheme.labelSmall?.copyWith(fontSize: 7, color: AppColors.onTertiaryContainer, fontFamily: 'monospace')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoordinatesGrid(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('BANKING & CLEARING COORDINATES', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700)),
            Text('ISO 20022', style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightOutline, fontFamily: 'monospace')),
          ],
        ),
        const SizedBox(height: 10),
        _coordCard(
          context,
          icon: Icons.send,
          tag: 'SOURCE',
          title: 'Originating Remitter',
          rows: const {
            'Remitter': 'Chief T. Adeleke',
            'Institution': 'Zenith Bank PLC',
            'Debit Account': '•••• 4932',
            'Mandate': 'ZEN-0912-HX883',
          },
        ),
        const SizedBox(height: 10),
        _coordCard(
          context,
          icon: Icons.savings,
          tag: 'CREDITED',
          title: 'Beneficiary & Vault Allocation',
          rows: const {
            'Beneficiary': 'Alexander Magnus',
            'Investor ID': 'INV-NG-883920',
            'NUBAN': '9928 3401 92',
            'Escrow Tier': 'Tier 3 Verified',
          },
        ),
      ],
    );
  }

  Widget _coordCard(BuildContext context, {required IconData icon, required String tag, required String title, required Map<String, String> rows}) {
    final textTheme = context.textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 14, color: AppColors.lightTextSecondary),
                  const SizedBox(width: 6),
                  Text(title, style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(4)),
                child: Text(tag, style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightTextSecondary, fontFamily: 'monospace')),
              ),
            ],
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 8), height: 1, color: AppColors.lightOutlineVariant.withValues(alpha: 0.4)),
          ...rows.entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Expanded(child: Text('${e.key}:', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary))),
                Flexible(
                  child: Text(e.value, textAlign: TextAlign.right, style: textTheme.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildNarrationStrip(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TRANSACTION NARRATION / PURPOSE', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            'HomeX Escrow Wallet Top-up / Allocation reserve for Lekki Pearl Phase 2',
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(color: AppColors.lightSurfaceContainerHighest, borderRadius: BorderRadius.circular(6)),
            child: Text('NIBSS ID: NIP-20241028-ZEN-0912448', style: textTheme.labelSmall?.copyWith(fontSize: 11, fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownTable(BuildContext context) {
    final textTheme = context.textTheme;
    final rows = [
      ['Gross Settlement Inflow', 'NIP-SETTLE-IN', '1,700,000.00', false, false],
      ['Statutory EMT Levy', 'Finance Act §48', '0.00 (Waived)', false, false],
      ['Escrow Custody & Trustee Fee', 'HX-ESC-T3', '0.00', false, false],
    ];

    return Container(
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLowest, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          for (final r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r[0] as String, style: textTheme.labelSmall?.copyWith(fontSize: 11)),
                        Text(r[1] as String, style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightTextSecondary, fontFamily: 'monospace')),
                      ],
                    ),
                  ),
                  Text('₦${r[2]}', style: textTheme.labelSmall?.copyWith(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          Container(
            width: double.infinity,
            color: AppColors.lightSurfaceContainerLow.withValues(alpha: 0.6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Expanded(child: Text('Net Credited into Escrow Vault', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: context.colors.primary))),
                Text('₦1,700,000.00', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, color: context.colors.primary, fontFamily: 'monospace')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(child: Text('Updated Total Available Escrow Allocation', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary))),
                Text('₦1,200,000.00', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, fontFamily: 'monospace')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttestationBlock(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: AppColors.lightSurfaceContainerHigh, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.lightOutlineVariant)),
              alignment: Alignment.center,
              child: Icon(Icons.qr_code_2, size: 34, color: context.colors.primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LIVE LEDGER SCAN', style: textTheme.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w700)),
                  Text(
                    'Scan via camera or NIBSS Mobile to authenticate the cryptographic SHA-256 seal.',
                    style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 28,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.6))),
          child: CustomPaint(painter: _BarcodePainter()),
        ),
        const SizedBox(height: 6),
        Center(
          child: Text('SHA256: 7F83B1...26D9069', style: textTheme.labelSmall?.copyWith(fontSize: 10, fontFamily: 'monospace', color: AppColors.lightTextSecondary)),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.6))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Stanbic IBTC Trustees', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const Icon(Icons.draw, size: 16, color: AppColors.onTertiaryContainer),
                ],
              ),
              const SizedBox(height: 2),
              Text('HX-OFFICER-REG-98124/NGR', style: textTheme.labelSmall?.copyWith(fontSize: 10, fontFamily: 'monospace')),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text('Dual-Authorized Compliance Protocol', style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.secondary, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupplementaryLinks(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.help_outline, size: 16, color: AppColors.lightOutline),
            const SizedBox(width: 6),
            Expanded(
              child: Wrap(
                children: [
                  Text('Notice a discrepancy with this allocation? ', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary)),
                  ScaleOnTap(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Discrepancy audit ticket initiated. Ref: RCT-2024-NIP-0912448'))),
                    child: Text('Report Discrepancy', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: context.colors.primary, fontWeight: FontWeight.w700, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ScaleOnTap(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening Central Settlement Ledger Explorer...'))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verify on Central Settlement Ledger', style: textTheme.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700)),
              const SizedBox(width: 4),
              Icon(Icons.open_in_new, size: 14, color: context.colors.onSurface),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStickyActionsPreview(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ScaleOnTap(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.lightOutlineVariant)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share, size: 16, color: context.colors.onSurface),
                      const SizedBox(width: 6),
                      Text('Share Proof', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ScaleOnTap(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.download, size: 16, color: context.colors.onPrimary),
                      const SizedBox(width: 6),
                      Text('Download PDF', style: textTheme.labelSmall?.copyWith(color: context.colors.onPrimary, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Statutory PDF Ready for Download · 248 KB', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary)),
      ],
    );
  }
}

/// Draws a barcode-style pattern of vertical bars, matching the
/// HTML's repeating-linear-gradient barcode strip.
class _BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.lightTextPrimary;
    double x = 0;
    final pattern = [2.0, 2.0, 3.0, 2.0, 1.0, 3.0, 1.0, 2.0, 1.0, 3.0];
    int i = 0;
    bool draw = true;
    while (x < size.width) {
      final w = pattern[i % pattern.length];
      if (draw) {
        canvas.drawRect(Rect.fromLTWH(x, 0, w, size.height), paint);
      }
      x += w;
      draw = !draw;
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldPainter) => false;
}