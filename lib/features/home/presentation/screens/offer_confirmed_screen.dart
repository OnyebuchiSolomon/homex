import 'package:homex/res/app_strings.dart';
import 'package:homex/ui/global.dart';
class OfferConfirmedScreen extends StatefulWidget {
  const OfferConfirmedScreen({super.key});

  @override
  State<OfferConfirmedScreen> createState() => _OfferConfirmedScreenState();
}

class _OfferConfirmedScreenState extends State<OfferConfirmedScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
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
                padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 24),
                child: Column(
                  children: [
                    FadeScaleIn(child: _buildHeroSuccess(context)),
                    const SizedBox(height: 20),
                    SlideFadeIn(child: _buildDealSnapshot(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(delay: AppAnimations.shortDelay, child: _buildCustodyShield(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(delay: AppAnimations.mediumDelay, child: _buildRoadmap(context)),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScaleOnTap(onTap: () => Navigator.of(context).maybePop(), child: Icon(Icons.arrow_back, color: cs.primary)),
          Text('Offer Confirmed', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: cs.primary)),
          ScaleOnTap(onTap: () {}, child: Icon(Icons.help_outline, color: cs.primary)),
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
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  final t = _pulseController.value;
                  final scale = 0.95 + (t < 0.5 ? t : 1 - t) * 0.4;
                  final opacity = 0.8 - (t < 0.5 ? t : 1 - t) * 1.0;
                  return Opacity(
                    opacity: opacity.clamp(0.0, 1.0),
                    child: Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryContainer.withValues(alpha: 0.1)),
                      ),
                    ),
                  );
                },
              ),
              Container(width: 64, height: 64, decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryContainer.withValues(alpha: 0.2))),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(shape: BoxShape.circle, color: cs.tertiaryContainer, boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 8)]),
                alignment: Alignment.center,
                child: Icon(Icons.verified_user, size: 30, color: cs.onTertiaryContainer),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 6,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: cs.tertiaryContainer.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999), border: Border.all(color: cs.tertiaryContainer.withValues(alpha: 0.2))),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: cs.onTertiaryContainer, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text('${AppStrings.appName.toUpperCase()} ESCROW LOCKED', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryContainer, fontWeight: FontWeight.w700)),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(999)),
              child: Text('#ESC-8942-01', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, fontFamily: 'monospace')),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('Binding Offer Submitted & Escrow Locked!', textAlign: TextAlign.center, style: tt.headlineSmall),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            style: tt.labelSmall?.copyWith(fontSize: 12, color: cs.onSurfaceVariant, height: 1.5),
            children: [
              const TextSpan(text: 'Your '),
              TextSpan(text: '₦42,000,000', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
              const TextSpan(text: ' offer has been legally transmitted to '),
              TextSpan(text: 'John Okafor', style: TextStyle(fontWeight: FontWeight.w600, color: cs.onSurface)),
              const TextSpan(text: ' (Direct Landlord/Owner) and '),
              TextSpan(text: '₦4,200,000', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
              const TextSpan(text: ' (10% Earnest Deposit) is secured in ${AppStrings.appName} Custody Vault.'),
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
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5))),
      padding: const EdgeInsets.all(14),
      child: child,
    );
  }

  Widget _buildDealSnapshot(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: ImageView.networkCached(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDyYxN84l1F3AbjJE8FGshUwMjQIdjLHPbidfNl-sNACOdEXgEYrk74eLemGNlzGlgjwNUBXHgljSZvz2lIKMDbX6LceS1R0JWFUVkLkexE9QwmVkELGfdGA_GLCCiJonTzGlmnUreOBXEkfjtEDboI6NyswDmt7lXoeOJ0Jfg1G_8ta6yxcymEkGrQNEvyZZ99s4oZD8ZexB4W3aPSzrB7FFGwNxuuBzgADgCN8U8Xe8g7LAXl8mEO',
                    fit: BoxFit.cover,
                    errorWidget: Container(color: cs.surfaceContainer, child: const Icon(Icons.image_not_supported_outlined)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text('#LX-1092', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant, fontFamily: 'monospace')),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(color: cs.secondaryContainer.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(3)),
                        child: Text('Verified Deed', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.secondaryContainer, fontWeight: FontWeight.w700)),
                      ),
                    ]),
                    const SizedBox(height: 2),
                    Text('Luxury 4-Bedroom Semi-Detached Duplex', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Row(children: [
                      Icon(Icons.location_on, size: 12, color: cs.onSurfaceVariant),
                      const SizedBox(width: 3),
                      Text('Lekki Phase 1, Lagos', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Submitted Offer', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    Text('₦42,000,000', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: cs.primary)),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(color: cs.tertiaryContainer.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
                      child: Text('-6.6%', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onTertiaryContainer, fontWeight: FontWeight.w700)),
                    ),
                  ]),
                  Text('₦45,000,000 list', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline, decoration: TextDecoration.lineThrough)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Flexible(child: Text('Pre-Funded Earnest Escrow (10%)', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: 4),
                        Icon(Icons.info, size: 13, color: cs.onSurfaceVariant),
                      ]),
                      Text('● Ring-Fenced in Vault', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryContainer, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Text('₦4,200,000', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w800, color: cs.primary)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Outstanding Balance at Closing', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
              Text('₦37,800,000', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.secondaryFixed.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.secondaryContainer.withValues(alpha: 0.3))),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(color: cs.secondaryContainer.withValues(alpha: 0.2), shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Icon(Icons.savings, size: 15, color: cs.secondary),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSecondaryFixed, height: 1.4),
                      children: [
                        const TextSpan(text: 'Zero Brokerage Savings: ', style: TextStyle(fontWeight: FontWeight.w700)),
                        const TextSpan(text: 'You saved '),
                        const TextSpan(text: '₦4,200,000', style: TextStyle(fontWeight: FontWeight.w700)),
                        const TextSpan(text: ' in middleman commissions by direct escrow closing on HomeX.'),
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

  Widget _buildCustodyShield(BuildContext context) {
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
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(6)),
                  alignment: Alignment.center,
                  child: Icon(Icons.gavel, size: 15, color: cs.onPrimary),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Custody & Regulatory Shield', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                    Text('${AppStrings.appName} Custody Rail', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
                  ],
                ),
              ]),

            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: cs.surfaceContainer),
          const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('Ledger Anchor ID:', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
          //     Container(
          //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          //       decoration: BoxDecoration(color: cs.surfaceContainerHigh, borderRadius: BorderRadius.circular(4)),
          //       child: Text('HSM-0x89F4..3A12', style: tt.labelSmall?.copyWith(fontSize: 10, fontFamily: 'monospace')),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Binding Acceptance Window:', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
              Text('72 Hours Remaining', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.secondary, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: cs.surfaceContainer),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant, height: 1.5),
              children: [
                const TextSpan(text: 'Earnest funds remain protected in trust and are '),
                TextSpan(text: '100% refundable', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                const TextSpan(text: ' if the landlord declines, counters, or physical due-diligence fails inspection conditions.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoadmap(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.timeline, size: 16, color: cs.primary),
            const SizedBox(width: 6),
            Text('Transaction Roadmap', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 14),
          _roadmapStep(
            context,
            iconBg: cs.onTertiaryContainer,
            icon: Icons.check,
            iconColor: cs.onTertiary,
            title: 'Earnest Deposit Locked',
            subtitle: 'Secured in Providus/${AppStrings.appName} vault',
            trailing: 'Just now',
            isLast: false,
          ),
          _roadmapStep(
            context,
            iconBg: cs.secondary,
            icon: null,
            dot: true,
            title: 'Awaiting John Okafor\'s offer countersignature',
            titleWidget: Row(
              children: [
                Expanded(child: Text('48h Structural Walkthrough', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(color: cs.secondaryFixed.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(3)),
                  child: Text('Gate Pass Ready', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.secondary, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            subtitle: "Awaiting John Okafor's offer countersignature",
            isLast: false,
          ),
          _roadmapStep(
            context,
            iconBg: cs.surfaceContainerHigh,
            icon: null,
            outlined: true,
            title: "Deed & Governor's Consent Filing",
            subtitle: 'Lagos State Lands Registry digital integration',
            isLast: true,
            muted: true,
          ),
        ],
      ),
    );
  }

  Widget _roadmapStep(
      BuildContext context, {
        required Color iconBg,
        IconData? icon,
        Color? iconColor,
        bool dot = false,
        bool outlined = false,
        bool muted = false,
        required String title,
        Widget? titleWidget,
        required String subtitle,
        String? trailing,
        required bool isLast,
      }) {
    final cs = context.colors;
    final tt = context.textTheme;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: outlined ? Colors.transparent : iconBg,
                  shape: BoxShape.circle,
                  border: outlined ? Border.all(color: cs.outlineVariant, width: 2) : null,
                ),
                alignment: Alignment.center,
                child: icon != null
                    ? Icon(icon, size: 9, color: iconColor)
                    : dot
                    ? Container(width: 6, height: 6, decoration: BoxDecoration(color: cs.onSecondary, shape: BoxShape.circle))
                    : null,
              ),
              if (!isLast) Expanded(child: Container(width: 2, margin: const EdgeInsets.symmetric(vertical: 4), color: cs.surfaceContainerHigh)),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (titleWidget != null)
                    titleWidget
                  else
                    Row(
                      children: [
                        Expanded(
                          child: Text(title, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: muted ? cs.outline : cs.onSurface)),
                        ),
                        if (trailing != null) Text(trailing, style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.outline, fontFamily: 'monospace')),
                      ],
                    ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: tt.labelSmall?.copyWith(fontSize: 10, color: muted ? cs.outline : cs.onSurfaceVariant)),
                ],
              ),
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
          onTap: ()=>AppNavigator.pushAndStackNamed(AppRoutes.activeEscrowTrackerScreen),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.handshake, size: 18, color: cs.onPrimary),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'View in Deals Hub & Track Status',
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download, size: 16, color: cs.primary),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Download Stamped Offer & Custody Mandate (PDF)',
                    textAlign: TextAlign.center,
                    style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: cs.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ScaleOnTap(
          onTap: () => Navigator.of(context).maybePop(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, size: 14, color: cs.onSurfaceVariant),
              const SizedBox(width: 4),
              Text('Return to Explore Properties', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}