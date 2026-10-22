import 'package:homex/res/app_strings.dart';
import 'package:homex/ui/global.dart';

class MakeAnOfferScreen extends StatefulWidget {
  const MakeAnOfferScreen({super.key});

  @override
  State<MakeAnOfferScreen> createState() => _MakeAnOfferScreenState();
}

class _MakeAnOfferScreenState extends State<MakeAnOfferScreen> {
  final TextEditingController _amountController = TextEditingController(text: '42,000,000');
  int _depositTier = 0; // 0 = 10% standard, 1 = 15% priority
  bool _walkthroughEnabled = true;
  int _closingDateIndex = 0; // 0 = 14 days, 1 = 30 days, 2 = immediate
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
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
    final tt = context.textTheme;
    final hPad = _hPad(context);

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeIn(child: _buildPropertyCard(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(child: _buildOfferAmountSection(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(delay: AppAnimations.shortDelay, child: _buildDepositSection(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(delay: AppAnimations.mediumDelay, child: _buildTermsSection(context)),
                    const SizedBox(height: 16),
                    ScrollReveal(child: _buildTrustBadge(context)),
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
                Text('Make an Offer', style: tt.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('#LX-1092 • Lekki Phase 1', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),

          ScaleOnTap(onTap: () {}, child: Padding(padding: const EdgeInsets.only(left: 8), child: Icon(Icons.help_outline, color: cs.onSurface))),
        ],
      ),
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

  Widget _buildPropertyCard(BuildContext context) {
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ImageView.networkCached(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCR9XGghAo8if4jAtlS6KGwJGk4Gc8TE93LiagRviN2MBCXC85S6uwJpVmXebKmhCNqM94wYciZOIS9wO5URRUrpBQuPvkwRxsrtoZAbcuNf7I0hK3GkbMKnY_R_jZ76lPZtHcMQnjdkGD3Y8mdY5bqQXPtYB5Gpod9s8p2dvHkZhUKJPRMSLaR9MRe6oAd-MzZ72XMpQ2mtUzYKUTrP7Alm5iLzO7T4AQzOTByYSOPMG5qGOaG6NPX',
                        fit: BoxFit.cover,
                        errorWidget: Container(color: cs.surfaceContainer, child: const Icon(Icons.image_not_supported_outlined)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    left: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(3)),
                      child: Text('DIRECT', style: tt.labelSmall?.copyWith(fontSize: 8, color: cs.onPrimary, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.verified, size: 14, color: cs.secondary),
                      const SizedBox(width: 4),
                      Expanded(child: Text('John Okafor', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: cs.tertiaryFixed, borderRadius: BorderRadius.circular(999)),
                        child: Text('99% Trust', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onTertiaryFixed, fontWeight: FontWeight.w700)),
                      ),
                    ]),
                    const SizedBox(height: 4),
                    Text('Luxury 4-Bedroom Semi-Detached Duplex', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Row(children: [
                      Icon(Icons.location_on, size: 13, color: cs.outline),
                      const SizedBox(width: 3),
                      Expanded(child: Text('Lekki Phase 1, Lagos', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant), overflow: TextOverflow.ellipsis)),
                    ]),
                    const SizedBox(height: 8),
                    Container(height: 1, color: cs.surfaceContainer),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('List Price', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                        Text.rich(
                          TextSpan(
                            style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: cs.onPrimary),
                            children: [
                              const TextSpan(text: '₦45,000,000'),
                              TextSpan(text: '/yr', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: cs.onSurfaceVariant)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: cs.surfaceContainerLow),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.check_circle, size: 13, color: cs.onTertiaryContainer),
                const SizedBox(width: 4),
                Text('BVN & NIN Cleared Landlord', style: context.textTheme.labelSmall?.copyWith(fontSize: 11, color: cs.onTertiaryContainer, fontWeight: FontWeight.w600)),
              ]),
              Text('0% Broker Markup', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.secondary, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfferAmountSection(BuildContext context) {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('YOUR OFFER AMOUNT', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                    Text('Direct negotiation, no agent intermediaries', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: cs.secondaryFixed, borderRadius: BorderRadius.circular(999)),
                child: Text('Binding 72 Hrs', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSecondaryFixed, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant)),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('₦', style: tt.headlineSmall?.copyWith(color: cs.onSurfaceVariant, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: tt.headlineSmall?.copyWith(color:context.isDarkTheme?Colors.white :cs.primary, fontWeight: FontWeight.w700),
                        decoration: const InputDecoration(border: InputBorder.none, isCollapsed: true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Official Nigerian Naira', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                    Text('-6.6% from list', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.error, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _presetButton(context, label: '-5% Value', amount: '₦42.75M', selected: false)),
              const SizedBox(width: 8),
              Expanded(child: _presetButton(context, label: 'List Price', amount: '₦45.00M', selected: false)),
              const SizedBox(width: 8),
              Expanded(child: _presetButton(context, label: '+5% High Lock', amount: '₦47.25M', selected: true)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.tertiaryFixed.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.tertiaryFixedDim.withValues(alpha: 0.4))),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: cs.tertiaryContainer, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Icon(Icons.savings, size: 17, color: cs.onTertiaryContainer),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${AppStrings.appName} fee Applied', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.tertiaryContainer, fontWeight: FontWeight.w700)),
                      Text.rich(
                        TextSpan(
                          style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant),
                          children: [
                            const TextSpan(text: 'You pay '),
                            TextSpan(text: '₦4,500,000', style: TextStyle(fontWeight: FontWeight.w700, color: cs.primary)),
                            const TextSpan(text: ' standard 10% agency & agreement fees.'),
                          ],
                        ),
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

  Widget _presetButton(BuildContext context, {required String label, required String amount, required bool selected}) {
    final cs = context.colors;
    final tt = context.textTheme;
    return ScaleOnTap(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: selected ? cs.primary : cs.surfaceContainer, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(label, style: tt.labelSmall?.copyWith(fontSize: 9, color: selected ? cs.primaryFixedDim : cs.onSurfaceVariant)),
            Text(amount, style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, color: selected ? cs.onPrimary : cs.onSurface)),
          ],
        ),
      ),
    );
  }

  Widget _buildDepositSection(BuildContext context) {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Commitment Deposit (Escrow)', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    Text('Refundable until contract signing', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                  ],
                ),
              ),
              Icon(Icons.shield_moon, color: cs.primary),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _depositTile(context, index: 0, label: '10% Standard', amount: '₦4,200,000', note: 'Stanbic Custody Hold')),
              const SizedBox(width: 10),
              Expanded(child: _depositTile(context, index: 1, label: '15% Priority', amount: '₦6,300,000', note: 'Top-Rank Consideration')),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lock, size: 16,),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.5),
                      children: [
                        const TextSpan(text: 'Held in '),
                        TextSpan(text: '${AppStrings.appName} Regulated Custody Vault', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                        const TextSpan(text: '. Funds only move after mutual contract execution & physical inspection.'),
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

  Widget _depositTile(BuildContext context, {required int index, required String label, required String amount, required String note}) {
    final cs = context.colors;
    final tt = context.textTheme;
    final selected = _depositTier == index;
    return ScaleOnTap(
      onTap: () => setState(() => _depositTier = index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? cs.primary.withValues(alpha: 0.05) : cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? cs.primary : cs.outlineVariant, width: selected ? 1 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: selected ? cs.primary : cs.onSurface)),
                Icon(selected ? Icons.check_circle : Icons.radio_button_unchecked, size: 16, color: selected ? cs.primary : cs.outline),
              ],
            ),
            const SizedBox(height: 4),
            Text(amount, style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w800)),
            Text(note, style: tt.labelSmall?.copyWith(fontSize: 10, color: selected ? cs.secondary : cs.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsSection(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Proposed Terms & Inspection', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.7))),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(color: cs.surfaceContainerHigh, borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: Icon(Icons.search, size: 16, ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('48-Hour Walkthrough', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                      Text('Structural & MEP Audit Contingency', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
                    ],
                  ),
                ),
                Switch(value: _walkthroughEnabled, activeThumbColor: cs.primary, onChanged: (v) => setState(() => _walkthroughEnabled = v)),
              ],
            ),
          ),
          const SizedBox(height: 14),
         /* Text('Intended Move-in / Closing Date', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _dateButton(context, index: 0, label: '14 Days')),
              const SizedBox(width: 8),
              Expanded(child: _dateButton(context, index: 1, label: '30 Days')),
              const SizedBox(width: 8),
              Expanded(child: _dateButton(context, index: 2, label: 'Immediate')),
            ],
          ),
          const SizedBox(height: 14),
          Text('Direct Message to John Okafor', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),

          */
          TextField(
            controller: _noteController,
            maxLines: 2,
            style: tt.labelSmall,
            decoration: InputDecoration(
              hintText: 'e.g. High-net-worth tenant/buyer, ready for instant verification...',
              filled: true,
              fillColor: cs.surface,
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: cs.outlineVariant)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateButton(BuildContext context, {required int index, required String label}) {
    final cs = context.colors;
    final tt = context.textTheme;
    final selected = _closingDateIndex == index;
    return ScaleOnTap(
      onTap: () => setState(() => _closingDateIndex = index),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? cs.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? cs.primary : cs.outlineVariant),
        ),
        child: Text(label, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: selected ? cs.onPrimary : cs.onSurfaceVariant)),
      ),
    );
  }

  Widget _buildTrustBadge(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant)),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('AM', style: tt.labelSmall?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('Alexander Magnus', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 4),
                  Icon(Icons.check_circle, size: 12, color: cs.onTertiaryContainer),
                ]),
                Text('Tier-1 BVN Verified • ₦85M Escrow Capacity', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: cs.tertiaryFixed, borderRadius: BorderRadius.circular(999)),
            child: Text('Pre-Approved', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onTertiaryFixed, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTray(BuildContext context, double hPad) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, border: Border(top: BorderSide(color: cs.outlineVariant))),
      padding: EdgeInsets.fromLTRB(hPad, 12, hPad, context.bottomPadding + 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Offer Submission', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                    Text('₦42,000,000', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w800, color: cs.primary)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Escrow Hold Due', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                  Text('₦4,200,000', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700, color: cs.secondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ScaleOnTap(
            onTap: () => AppNavigator.pushAndStackNamed(AppRoutes.offerConfirmedScreen),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 18, color: cs.onPrimary),
                  const SizedBox(width: 8),
                  Text('Submit Binding Offer & Lock Escrow', style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, size: 12, color: cs.onTertiaryContainer),
              const SizedBox(width: 4),
              Text('Protected by HomeX Direct • 0% Commission', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}