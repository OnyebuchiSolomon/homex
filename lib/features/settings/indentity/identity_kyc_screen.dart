import 'package:homex/ui/global.dart';
class _KycCredential {
  final IconData icon;
  final String title;
  final String subtitle;
  final String metaLeft;
  final String metaRight;

  const _KycCredential({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.metaLeft,
    required this.metaRight,
  });
}

class IdentityKycScreen extends StatelessWidget {
  const IdentityKycScreen({super.key});

  static const List<_KycCredential> _credentials = [
    _KycCredential(
      icon: Icons.account_balance_wallet,
      title: 'Bank Verification Number (BVN)',
      subtitle: 'Validated via NIBSS Central Registry (•••• 8291)',
      metaLeft: 'HASH: NIBSS-7810A-LIVE',
      metaRight: '100% Match',
    ),
    _KycCredential(
      icon: Icons.badge,
      title: 'National Identity Number (NIN)',
      subtitle: 'NIMC Digital Registry match with authenticated Iris record',
      metaLeft: 'NIMC-ENCR-29311',
      metaRight: 'Biometrics Authenticated',
    ),
    _KycCredential(
      icon: Icons.pin,
      title: 'Proof of Residential Address',
      subtitle: 'Utility billing audit • Ikoyi, Lagos State (Physical stamp confirmed)',
      metaLeft: 'Inspected by: HomeX Field Ops',
      metaRight: 'GPS Locked',
    ),
    _KycCredential(
      icon: Icons.face,
      title: 'Biometric 3D Liveness',
      subtitle: 'ISO/IEC 30107-3 compliant passive liveness detection',
      metaLeft: 'Confidence Score: 99.8%',
      metaRight: 'No Spoof Detected',
    ),
    _KycCredential(
      icon: Icons.receipt_long,
      title: 'Source of Funds & FIRS Tax ID',
      subtitle: 'Federal Inland Revenue Service (FIRS) Tax Clearance Cert valid',
      metaLeft: 'TIN: 2049****-0001',
      metaRight: 'Audit Status: Current',
    ),
  ];

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeIn(child: _buildTierHero(context),),
                    const SizedBox(height: 16),
                  //  SlideFadeIn(child: _buildLimitsSection(context)),

                    ScrollReveal(child: _buildCredentialsSection(context)),
                    const SizedBox(height: 16),
                   // ScrollReveal(child: _buildCustodyNote(context)),
                    const SizedBox(height: 20),
                    // _buildActions(context),
                    // const SizedBox(height: 16),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Identity & KYC Verification', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('Account ID: KYC-NG-9842109', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          ScaleOnTap(onTap: () {}, child: Icon(Icons.info_outline, size: 20, color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildTierHero(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant)),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: cs.tertiaryContainer, borderRadius: BorderRadius.circular(999)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.verified_user, size: 15, color: cs.tertiaryFixed),
                  const SizedBox(width: 6),
                  Text('3 of 5 Verified', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.tertiaryFixed, fontWeight: FontWeight.w700)),
                ]),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              //   decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(999), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6))),
              //   child: Row(mainAxisSize: MainAxisSize.min, children: [
              //     Icon(Icons.gavel, size: 13, color: cs.secondary),
              //     const SizedBox(width: 5),
              //     Text('SEC & NDIC Compliant', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
              //   ]),
              // ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Institutional Verification', style: tt.headlineSmall),
          const SizedBox(height: 6),
          Text(
            'All statutory Nigerian registries and AML/CFT institutional validation requirements have been permanently cleared.',
            style: tt.labelSmall?.copyWith(fontSize: 12, color: cs.onSurfaceVariant, height: 1.5),
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('VERIFIED SUBJECT', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline, letterSpacing: 0.4)),
                    Text('Alexander Magnus', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                    Text('alexander.magnus@homex.ng', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('INSTITUTIONAL TRUST', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline, letterSpacing: 0.4)),
                    Row(children: [
                      Icon(Icons.shield_moon, size: 15, color: cs.tertiaryFixedDim),
                      const SizedBox(width: 4),
                      Text('99.4% Verified', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, fontFamily: 'monospace')),
                    ]),
                    Text('Zero Compliance Flags', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onTertiaryContainer, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.event_available, size: 14, color: cs.outline),
                  const SizedBox(width: 4),
                  Text('Cleared: Oct 14, 2023', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.sync, size: 14, color: cs.secondary),
                  const SizedBox(width: 4),
                  Text('Audit: Oct 2024', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.secondary, fontWeight: FontWeight.w600)),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildCredentialsSection(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.verified, size: 16, color: cs.primary),
              const SizedBox(width: 6),
              Text('Verified Credential Records', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
            ]),
            Text('5 of 5 Cleared', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.outline)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              for (int i = 0; i < _credentials.length; i++) ...[
                _credentialRow(context, _credentials[i]),
                if (i != _credentials.length - 1) Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.4)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _credentialRow(BuildContext context, _KycCredential c) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Icon(c.icon, size: 20, color: cs.onSurface),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(c.title, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 2)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(999)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.check_circle, size: 12, color: cs.onTertiaryContainer),
                        const SizedBox(width: 3),
                        Text('Verified', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onTertiaryContainer, fontWeight: FontWeight.w700)),
                      ]),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(c.subtitle, style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.4)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 2,
                  children: [
                    Text(c.metaLeft, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline, fontFamily: 'monospace')),
                    Text('•', style: TextStyle(color: cs.outline, fontSize: 10)),
                    Text(c.metaRight, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryContainer, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
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
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download, size: 18, color: cs.onPrimary),
                const SizedBox(width: 8),
                Flexible(child: Text('Download KYC Attestation Certificate (PDF)', textAlign: TextAlign.center, style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_document, size: 16, color: cs.onSurfaceVariant),
                const SizedBox(width: 8),
                Flexible(child: Text('Request Information or Address Update', textAlign: TextAlign.center, style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.assured_workload, size: 13, color: cs.outline),
          const SizedBox(width: 6),
          Flexible(child: Text('Regulated by Securities and Exchange Commission (SEC) Nigeria', textAlign: TextAlign.center, style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.outline))),
        ]),
        const SizedBox(height: 2),
        Text('Reference Hash: SHA256-KYC-T3-HOMEX-778942', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline)),
      ],
    );
  }
}