import 'package:homex/ui/global.dart';
class InspectionConfirmedScreen extends StatelessWidget {
  const InspectionConfirmedScreen({super.key});

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  void _copyPasscode(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: '849201'));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passcode copied')));
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
                padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 24),
                child: Column(
                  children: [
                    FadeScaleIn(child: _buildHeroSuccess(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(child: _buildScheduleCard(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(delay: AppAnimations.shortDelay, child: _buildGatePassCard(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(delay: AppAnimations.mediumDelay, child: _buildContactCard(context)),
                    const SizedBox(height: 16),
                    ScrollReveal(child: _buildTrustBanner(context)),
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
          Expanded(child: Text('Inspection Confirmed', style: tt.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
          ScaleOnTap(onTap: () {}, child: Icon(Icons.help_outline, color: cs.onSurfaceVariant)),
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
          width: 64,
          height: 64,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Pulse(
                duration: const Duration(milliseconds: 2500),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryFixed.withValues(alpha: 0.5)),
                ),
              ),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryContainer, boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 8)]),
                alignment: Alignment.center,
                child: Icon(Icons.check_circle, size: 30, color: cs.tertiaryFixed),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: cs.tertiaryFixed, borderRadius: BorderRadius.circular(999)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.verified_user, size: 13, color: cs.onTertiaryFixed),
            const SizedBox(width: 5),
            Text('SECURITY APPROVED PASS', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryFixed, fontWeight: FontWeight.w700)),
          ]),
        ),
        const SizedBox(height: 8),
        Text('Inspection Request Confirmed & Sent!', textAlign: TextAlign.center, style: tt.headlineSmall),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            style: tt.bodyMedium?.copyWith(fontSize: 13, color: cs.onSurfaceVariant, height: 1.5),
            children: [
              const TextSpan(text: 'Your physical walkthrough request has been scheduled with '),
              TextSpan(text: 'John Okafor', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
              const TextSpan(text: ' (Direct Landlord) and synced with '),
              TextSpan(text: 'Lekki Phase 1 Estate Security', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
              const TextSpan(text: '.'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _card(BuildContext context, {required Widget child}) {
    final cs = context.colors;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant)),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildScheduleCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.calendar_month, size: 16, color: cs.onSurfaceVariant),
                const SizedBox(width: 6),
                Text('SCHEDULED VISIT', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, fontWeight: FontWeight.w700)),
              ]),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: cs.secondaryFixed, borderRadius: BorderRadius.circular(4)),
                child: Text('Confirmed', style: tt.labelSmall?.copyWith(fontSize: 10,  fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: cs.surfaceContainer),
          const SizedBox(height: 12),
          _infoRow(context, icon: Icons.schedule, label: 'Date & Time', value: 'Tomorrow, 14:00 - 15:30 WAT'),
          const SizedBox(height: 8),
          _infoRow(
            context,
            icon: Icons.badge,
            iconColor: cs.onTertiaryContainer,
            label: 'Inspection Mode',
            value: 'Physical Walkthrough',
            caption: 'Accompanied by LASRERA Certified Resident Escort',
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: cs.surfaceContainer),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: ImageView.networkCached(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCJ0HU7QP_WR81-Enm-1XKBLoimnkJF74U1Z-IZOwj3FWaCKJXyZ8X5GcrlZ34AIbH8BKrCqhjJUjebgLJmWrbmn5kEPDUjpmRZQnIjn4CRH4Ft6fDKLHEpByIcMqmPXyqRC4JpTCh15KQ8oZ-TiUga3j3bhpGs7zC14yvn-PB30lttxwejz1kc19P4tBdbD6gtyWOPpFS26vd6annXRmYMl3beCW7fxdWmzPezo3uZ_e4USYRqKo71',
                    fit: BoxFit.cover,
                    errorWidget: Container(color: cs.surfaceContainerHigh, child: const Icon(Icons.image_not_supported_outlined)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Luxury 4-Bed Semi-Detached Duplex', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text('#LX-1092 • Lekki Phase 1, Lagos State', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('₦45,000,000', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w800, )),
                        const SizedBox(width: 4),
                        Text('/yr', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(color: cs.tertiaryFixed, borderRadius: BorderRadius.circular(4)),
                          child: Text('0% Broker Markup', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onTertiaryContainer, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, {required IconData icon, Color? iconColor, required String label, required String value, String? caption}) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor ?? cs.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                Text(value, style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
                if (caption != null) Text(caption, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGatePassCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.lock_clock, size: 16, color: cs.secondary),
                const SizedBox(width: 6),
                Text('Estate Gate Clearance', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              ]),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(999)),
                child: Text('GATE PASS 02', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onPrimary, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.surfaceContainer)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Clearance Access PIN', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                      Text('849 - 201', style: tt.headlineMedium?.copyWith(fontSize: 26, fontWeight: FontWeight.w800, fontFamily: 'monospace')),
                      ScaleOnTap(
                        onTap: () => _copyPasscode(context),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.content_copy, size: 13, color: cs.onSurface),
                          const SizedBox(width: 4),
                          Text('Copy Passcode', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, decoration: TextDecoration.underline)),
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outlineVariant)),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(color: cs.surfaceContainerHighest, borderRadius: BorderRadius.circular(6)),
                        alignment: Alignment.center,
                        child: Icon(Icons.qr_code_2, size: 40, color: cs.onSurface),
                      ),
                      const SizedBox(height: 4),
                      Text('GATE SCANNER', style: tt.labelSmall?.copyWith(fontSize: 8, color: cs.onSurfaceVariant, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.shield_moon, size: 16, color: cs.onSurfaceVariant),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant),
                    children: [
                      TextSpan(text: 'LASRERA Officer Assigned: ', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                      const TextSpan(text: 'Officer Babatunde O. (ID #LA-9021)'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.surfaceContainer.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.surfaceContainerHigh)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info, size: 15, color: cs.secondary),
                const SizedBox(width: 8),
                Expanded(child: Text('Present this PIN or QR pass at Lekki Phase 1 Main Estate Gate 2 for seamless access.', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.4))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DIRECT CONTACT', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: cs.outlineVariant)),
                      child: ImageView.networkCached(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAlMFgQfJYYakBN5DiuRG_H1wZ6cnGmK_W33QtxBDQtm26njLlWDPuYRZIrvIX_1NzGDjuQzPPL5wzoemEEXDU3sTH47QpBU1EXI0FiOuO6n5ZX3s7mPjGrUf3vdfiouSLOIUxjtrmT6jI9x5nJpFyk4sYGbvWMrb5JoA0ak1qxJMEUmNSHohNfjypW_XAaZFX1mcwkOk1Z2Gsg1XepkEQtNue3lI2SpVIvdoplfBZpyWN0VDbygOGO',
                        fit: BoxFit.cover,
                        errorWidget: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    right: -1,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(color: cs.tertiaryFixed, shape: BoxShape.circle, border: Border.all(color: cs.surfaceContainerLowest, width: 2)),
                      alignment: Alignment.center,
                      child: Icon(Icons.check, size: 9, color: cs.onTertiaryFixed),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Flexible(child: Text('John Okafor', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(color: cs.secondaryFixed, borderRadius: BorderRadius.circular(3)),
                        child: Text('Direct Landlord', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.secondary, fontWeight: FontWeight.w700)),
                      ),
                    ]),
                    Row(children: [
                      Text('99% Trust Score', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onTertiaryContainer, fontWeight: FontWeight.w600)),
                      Text(' • BVN/NIN Cleared', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: cs.surfaceContainer),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ScaleOnTap(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outlineVariant)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat, size: 16, color: cs.onSurface),
                        const SizedBox(width: 6),
                        Text('Message', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ScaleOnTap(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outlineVariant)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call, size: 16, color: cs.onSurface),
                        const SizedBox(width: 6),
                        Text('Call', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBanner(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified, size: 22, color: cs.secondaryContainer),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('HomeX Direct Trust Guarantee', style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  '100% verified title, zero middleman markup, LASRERA accredited escort on site.',
                  style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.primaryFixedDim, height: 1.4),
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
            decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12),border: Border.all(color: cs.outlineVariant)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder, size: 18, color: cs.onPrimary),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'View in Deals Hub / Manage Requests',
                    textAlign: TextAlign.center,
                    style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
                Icon(Icons.event, size: 16, color: cs.onSurface),
                const SizedBox(width: 8),
                Text('Add to Calendar', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ScaleOnTap(
          onTap: () => Navigator.of(context).maybePop(),
          child: Text('Back to Property Details', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant, decoration: TextDecoration.underline)),
        ),
      ],
    );
  }
}