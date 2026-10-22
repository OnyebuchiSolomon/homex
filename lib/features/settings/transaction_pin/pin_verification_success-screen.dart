import 'package:homex/ui/global.dart';
class PinVerificationSuccessScreen extends StatelessWidget {
  const PinVerificationSuccessScreen({super.key});

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
                    _buildStepIndicator(context),
                    const SizedBox(height: 20),
                    FadeScaleIn(child: _buildHeroSuccess(context)),
                    const SizedBox(height: 20),
                    SlideFadeIn(child: _buildSecurityCard(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(delay: AppAnimations.shortDelay, child: _buildCoolingLockCallout(context)),
                    const SizedBox(height: 16),
                  //  ScrollReveal(child: _buildAuditLedger(context)),
                    const SizedBox(height: 20),
                    _buildActions(context),
                  ],
                ),
              ),
            ),
            _buildFooter(context),
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
          ScaleOnTap(onTap: () => Navigator.of(context).maybePop(), child: Icon(Icons.arrow_back, color: cs.primary)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Transaction PIN', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),

              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _card(BuildContext context, {required Widget child, EdgeInsets? padding}) {
    final cs = context.colors;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.surfaceContainerHigh)),
      padding: padding ?? const EdgeInsets.all(14),
      child: child,
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      //padding: EdgeInsets.all(value),
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.check_circle, size: 13, color: cs.onTertiaryContainer),
                  const SizedBox(width: 4),
                  Flexible(child: Text('Step 3 of 3 • Key Updated & Verified', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: cs.tertiaryFixed, borderRadius: BorderRadius.circular(4)),
                child: Text('100% SECURE', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryContainer, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: List.generate(3, (i) => Expanded(child: Container(height: 6, margin: EdgeInsets.only(right: i == 2 ? 0 : 6), decoration: BoxDecoration(color: cs.tertiaryContainer, borderRadius: BorderRadius.circular(999)))))),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1. Current PIN', style: tt.labelSmall?.copyWith(fontSize: 10)),
              Text('2. New Key', style: tt.labelSmall?.copyWith(fontSize: 10)),
              Text('3. Activated', style: tt.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w700)),
            ],
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
                duration: const Duration(milliseconds: 2000),
                child: Container(width: 96, height: 96, decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryFixedDim.withValues(alpha: 0.3))),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryContainer, boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 8)]),
                alignment: Alignment.center,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryFixed),
                  alignment: Alignment.center,
                  child: Icon(Icons.verified_user, size: 28, color: cs.tertiaryContainer),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(color: cs.surfaceContainerLowest, shape: BoxShape.circle, border: Border.all(color: cs.surfaceContainerHigh)),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Icon(Icons.lock, size: 12, color: cs.onPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text('Transaction PIN Updated Successfully!', textAlign: TextAlign.center, style: tt.headlineSmall),
        const SizedBox(height: 8),
        Text(
          'Your 6-digit cryptographic escrow key has been re-encrypted and secured inside the FIPS 140-2 Level 3 Hardware Security Module (HSM).',
          textAlign: TextAlign.center,
          style: tt.labelSmall?.copyWith(fontSize: 12, color: cs.onSurfaceVariant, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSecurityCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.shield_moon, size: 18, color: cs.onSurfaceVariant),
                const SizedBox(width: 6),
                Text('Security Coordinates & Audit', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
              ]),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //   decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(4)),
              //   child: Text('HSM NODE #04', style: tt.labelSmall?.copyWith(fontSize: 10, fontFamily: 'monospace')),
              // ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: cs.surfaceContainer),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Investor Account', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                    Text('Alexander Magnus', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                    Text('INV-NG-883920', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline, fontFamily: 'monospace')),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(color: cs.secondaryFixed.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(8)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.stars, size: 12, color: cs.secondary),
                  const SizedBox(width: 4),
                  Text('Diamond Tier 3 (99.4%)', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.secondary, fontWeight: FontWeight.w700)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: cs.surfaceContainer),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hardware Enclave Hash', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(color: cs.tertiaryFixed.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(4)),
                child: Text('ECDSA P-256', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryContainer, fontFamily: 'monospace')),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.surfaceContainer)),
            child: Row(
              children: [
                Expanded(child: Text('SHA256: 4f8a91c7...9c992d90fa2', style: tt.labelSmall?.copyWith(fontSize: 11, fontFamily: 'monospace'), overflow: TextOverflow.ellipsis)),
                Icon(Icons.key, size: 14, color: cs.outline),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _miniStatTile(context, icon: Icons.face, label: 'Face ID Link', value: 'Biometrics Synced')),
              const SizedBox(width: 8),
              Expanded(child: _miniStatTile(context, icon: Icons.schedule, label: 'Updated Time', value: 'Just now, 14:28 WAT')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStatTile(BuildContext context, {required IconData icon, required String label, required String value}) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.surfaceContainer)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 15, color: cs.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(label, style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 2),
          Text(value, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryContainer)),
        ],
      ),
    );
  }

  Widget _buildCoolingLockCallout(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.secondary.withValues(alpha: 0.3))),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: cs.secondaryContainer.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Icon(Icons.timer, size: 18, color: cs.secondary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('12-Hour High-Value Escrow Cooling Window Active', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, height: 1.4)),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.5),
                    children: [
                      const TextSpan(text: 'In accordance with SEC Nigeria Escrow Rule 184(b) and NDIC deposit protection frameworks, any single milestone property disbursement exceeding '),
                      TextSpan(text: '₦10,000,000', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface, fontFamily: 'monospace')),
                      const TextSpan(text: ' will be subject to a 12-hour cooling delay unless authenticated via trustee biometric co-sign.'),
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

  // Widget _buildAuditLedger(BuildContext context) {
  //   final cs = context.colors;
  //   final tt = context.textTheme;
  //   return _card(
  //     context,
  //     padding: const EdgeInsets.all(14),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Icon(Icons.devices, size: 16, color: cs.onSurfaceVariant),
  //             const SizedBox(width: 6),
  //             Expanded(child: Text('Primary Terminal:', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant))),
  //             Text('iPhone 15 Pro • Lagos, NG', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         Row(
  //           children: [
  //             Icon(Icons.fingerprint, size: 16, color: cs.onSurfaceVariant),
  //             const SizedBox(width: 6),
  //             Expanded(child: Text('Audit Session Ref:', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant))),
  //             Text('#SEC-PIN-88219-OK', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
                Icon(Icons.lock, size: 16, color: cs.onPrimary),
                const SizedBox(width: 8),
                Flexible(child: Text('Done & Return to Security Center', textAlign: TextAlign.center, style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
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
        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant)),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(Icons.download, size: 16, color: cs.onSurfaceVariant),
        //         const SizedBox(width: 8),
        //         Flexible(child: Text('Download Security Audit Log (PDF)', textAlign: TextAlign.center, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
        //       ],
        //     ),
        //   ),
        // ),
        const SizedBox(height: 8),
        ScaleOnTap(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning, size: 14, color: cs.error),
              const SizedBox(width: 4),
              Text('Report Discrepancy or Freeze Account', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.error, fontWeight: FontWeight.w700, decoration: TextDecoration.underline)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, context.bottomPadding + 12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: cs.surfaceContainer))),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.account_balance, size: 14, color: cs.outline),
            const SizedBox(width: 6),
            Text('SEC Nigeria Regulated Sub-Broker • NDIC Insured Partner', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
          ]),
          const SizedBox(height: 4),
          Text('End-to-End Zero Knowledge Architecture: HomeX never stores your PIN in plain text.', textAlign: TextAlign.center, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline)),
        ],
      ),
    );
  }
}