import 'package:homex/res/app_strings.dart';
import 'package:homex/ui/global.dart';
class _ListingCard {
  final String imageUrl;
  final String price;
  final String badge;
  final String title;
  final String location;
  final List<String> specs;
  final String footerTag;

  const _ListingCard({
    required this.imageUrl,
    required this.price,
    required this.badge,
    required this.title,
    required this.location,
    required this.specs,
    required this.footerTag,
  });
}

class _Review {
  final String initials;
  final String name;
  final String context;
  final String comment;

  const _Review({required this.initials, required this.name, required this.context, required this.comment});
}

class VerifiedSellerProfileScreen extends StatelessWidget {
  const VerifiedSellerProfileScreen({super.key});

  static const List<_ListingCard> _listings = [
    _ListingCard(
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBk9PUN6CClJgU2ZL84rdBo9HRbfz-jDw_-rsyxpRUr-jCuEtJSQ4A29eRcqZAy-al6h5ekQ0kaGq__6KXm50djS9TxXd3N-xbQhpaNFASTJ0lXwuIAV0QeFkH7079k1JdcRCjj1hdYDlClTuuHqIhP-D9LBq99G89ybGmR4h9HItdGc0mGkUU-qFrsL33nxfU5ACvx1v4X2sXcm_1OdlK-dehevVT2km4OAHPFHBTm80xaKRBxsgRA',
      price: '₦45,000,000',
      badge: 'Verified C-of-O',
      title: 'Luxury 4-Bedroom Semi-Detached Duplex',
      location: 'Lekki Phase 1, Lagos',
      specs: ['4 Beds', '4 Baths', '3 Cars'],
      footerTag: '0% Agent Fee',
    ),
    _ListingCard(
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAciaZsfusolejH2jc7M2E11l3eD_qXIQQgzQKElTfsHeivkgu1Ed-oWciz5xu0QQX3n5qaVdINS08SFFa5cMtcewYrB9qrA2Jm6l8N1509VO6yOr_Y7RkcZmXEXwLh9-sIzFiAOAK5EwaHcdZY2ZCl17o41kMDgoBtSi9fXQh_bkMGnvlgX7xbSJArhhF9gT-b82F00ULmc-FhFZKP6MkH2P5h_tL9XUIpdbaPNpgEKXzzwqeLI6bN',
      price: '₦35,000,000',
      badge: "Governor's Consent",
      title: 'Fully Serviced 2-Bedroom Waterfront Apartment',
      location: 'Victoria Island, Lagos',
      specs: ['2 Beds', '2 Baths', '24/7 Power'],
      footerTag: '0% Agent Fee',
    ),
  ];

  static const List<_Review> _reviews = [
    _Review(
      initials: 'TA',
      name: 'Tunde Adeleke',
      context: 'Lekki Phase 1 Purchase • Oct 2023',
      comment: 'Seamless transaction with Stanbic escrow. Title deeds verified in 24 hours. John was completely transparent throughout.',
    ),
    _Review(
      initials: 'LE',
      name: 'Barr. Lynda Eke',
      context: 'Ikoyi Land Transaction • Aug 2023',
      comment: 'Authentic direct owner. Prompt gate pass issued for walkthrough. No hidden middleman markups.',
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
                    FadeIn(child: _buildIdentityCard(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(child: _buildQuickActions(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(delay: AppAnimations.shortDelay, child: _buildCredentialsGrid(context)),
                    const SizedBox(height: 20),
                    _buildListingsHeader(context),
                    const SizedBox(height: 12),
                    ..._listings.map((l) => Padding(padding: const EdgeInsets.only(bottom: 14), child: ScrollReveal(child: _buildListingCard(context, l)))),
                    const SizedBox(height: 8),
                    _buildReviewsHeader(context),
                    const SizedBox(height: 12),
                    ..._reviews.map((r) => Padding(padding: const EdgeInsets.only(bottom: 10), child: _buildReviewCard(context, r))),
                    const SizedBox(height: 16),
                    _buildGuaranteeBanner(context),
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
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 12),
      child: Row(
        children: [
          ScaleOnTap(
            onTap: () => Navigator.of(context).maybePop(),
            child: Icon(Icons.arrow_back, color: cs.onSurface),
          ),
          Expanded(
            child: Column(
              children: [
                Text('Verified Seller', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 6, height: 6, decoration: BoxDecoration(color: cs.secondary, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text('Identity Cleared', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
          ScaleOnTap(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(color: cs.surfaceContainerLow, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(Icons.share, size: 18, color: cs.onSurface),
            ),
          ),
          ScaleOnTap(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: cs.surfaceContainerLow, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(Icons.more_vert, size: 18, color: cs.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: cs.surfaceContainerLowest, width: 2)),
                      child: ImageView.networkCached(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuA3nEzHsWgOiOAAIMFUWQtqVJ3VRFAhBGs1ccP8f2KS1cipxYv-aJoYsCrhCA8xs7B4QSCRmnN-jaFwdiHX5VJAJHDtUEarna-ZQStgWo9DknvMuv_9JuO_DEtjlnq6WeXGP_C3czJqEy0QsW491IMaNIGc1lOVh4VSH-dJ6cpkK0Eh5pk_15Kp0CEwQaDt5W9wN-3-QlvCeC2CCbmD_ene5ggXDtovQOY_YyvWW8xt4MTbbD31C2_C',
                        fit: BoxFit.cover,
                        errorWidget: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: cs.secondary, shape: BoxShape.circle),
                      child: Icon(Icons.verified, size: 14, color: cs.onSecondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        Text('John Okafor', style: tt.headlineSmall),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: cs.secondaryFixed, borderRadius: BorderRadius.circular(999)),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.verified_user, size: 11, color: cs.onSecondaryFixed),
                            const SizedBox(width: 3),
                            Text('Audited', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSecondaryFixed, fontWeight: FontWeight.w700)),
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Direct Property Owner & Verified Land Seller', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                    const SizedBox(height: 4),
                    Row(children: [
                      Icon(Icons.location_on, size: 13, color: cs.outline),
                      const SizedBox(width: 3),
                      Expanded(child: Text('Lekki Phase 1, Lagos, Nigeria', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant), overflow: TextOverflow.ellipsis)),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.3)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.star, size: 16, color: cs.secondary),
                const SizedBox(width: 4),
                Text('4.8', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(width: 4),
                Text('(24 Deals / Reviews)', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
              ]),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: cs.tertiaryFixed.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(999)),
                child: Text('99% Trust • 0 Disputes', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onTertiaryContainer, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.2)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _miniBadge(context, icon: Icons.badge, label: 'BVN/NIN Cleared'),
              _miniBadge(context, icon: Icons.description, label: 'Title Deeds Audited (C-of-O)'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: cs.secondaryFixed.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(6)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.handshake, size: 12, color: cs.secondary),
                  const SizedBox(width: 4),
                  Text('Direct Owner (0% Broker Fee)', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSecondaryFixed, fontWeight: FontWeight.w700)),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniBadge(BuildContext context, {required IconData icon, required String label}) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(6)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 12, color: cs.secondary),
        const SizedBox(width: 4),
        Text(label, style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
      ]),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Row(
      children: [
        // Expanded(
        //   child: ScaleOnTap(
        //     onTap: () {},
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(vertical: 14),
        //       decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12)),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(Icons.chat, size: 18, color: cs.onPrimary),
        //           const SizedBox(width: 8),
        //           Text('Message Seller', style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700)),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(width: 10),
        Expanded(
          child: ScaleOnTap(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month, size: 18, color: cs.secondary),
                  const SizedBox(width: 8),
                  Flexible(child: Text('Request Inspection', style: tt.labelMedium?.copyWith(color: cs.primary, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCredentialsGrid(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    final items = [
      [Icons.date_range, 'Member Since', 'Nov 2022', 'Active for 2+ Years', cs.outline, cs.onSurfaceVariant],
      [Icons.verified, 'Identity Level', 'Tier 3 Statutory', 'Govt Biometrics Linked', cs.secondary, cs.onSecondaryContainer],
      [Icons.schedule, 'Avg Response', 'Within 15 mins', 'High Responsiveness', cs.outline, cs.onSurfaceVariant],
      [Icons.account_balance, 'Escrow Volume', '12 Direct Sales', '100% Escrow Released', cs.onTertiaryContainer, cs.onTertiaryContainer],
    ];

    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SELLER CREDENTIALS & TRACK RECORD', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.outline, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.5,
            children: items.map((it) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: cs.surfaceContainerLow.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(it[1] as String, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline), overflow: TextOverflow.ellipsis)),
                        Icon(it[0] as IconData, size: 14, color: it[4] as Color),
                      ],
                    ),
                    const Spacer(),
                    Text(it[2] as String, style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w800)),
                    Text(it[3] as String, style: tt.labelSmall?.copyWith(fontSize: 9, color: it[5] as Color)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildListingsHeader(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Listings', style: tt.headlineSmall),
              Text('2 audited properties currently available', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
        ),
        ScaleOnTap(onTap: () {}, child: Text('View Archive', style: tt.labelSmall?.copyWith(color: cs.secondary, fontWeight: FontWeight.w700))),
      ],
    );
  }

  Widget _buildListingCard(BuildContext context, _ListingCard l) {
    final cs = context.colors;
    final tt = context.textTheme;
    return ScaleOnTap(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: ImageView.networkCached(
                    l.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: Container(color: cs.surfaceContainer, child: const Icon(Icons.image_not_supported_outlined)),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: cs.surfaceContainerLowest.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)),
                    child: Text(l.price, style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w800, color: cs.primary)),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: cs.secondaryFixed, borderRadius: BorderRadius.circular(999)),
                    child: Text(l.badge, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSecondaryFixed, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.title, style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Row(children: [
                    Icon(Icons.location_on, size: 13, color: cs.outline),
                    const SizedBox(width: 3),
                    Text(l.location, style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                  ]),
                  const SizedBox(height: 10),
                  Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.3)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 4,
                          children: l.specs.map((s) => Text(s, style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant))).toList(),
                        ),
                      ),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(l.footerTag, style: tt.labelSmall?.copyWith(color: cs.secondary, fontWeight: FontWeight.w700)),
                        Icon(Icons.chevron_right, size: 14, color: cs.secondary),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsHeader(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Verified Buyer Reviews', style: tt.headlineSmall),
        ScaleOnTap(onTap: () {}, child: Text('See all 24', style: tt.labelSmall?.copyWith(color: cs.secondary, fontWeight: FontWeight.w700))),
      ],
    );
  }

  Widget _buildReviewCard(BuildContext context, _Review r) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: cs.primaryContainer, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(r.initials, style: tt.labelSmall?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.name, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                    Text(r.context, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
                  ],
                ),
              ]),
              Row(children: List.generate(5, (_) => Icon(Icons.star, size: 14, color: cs.secondary))),
            ],
          ),
          const SizedBox(height: 8),
          Text('"${r.comment}"', style: tt.labelSmall?.copyWith(height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildGuaranteeBanner(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2))),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: cs.onPrimary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Icon(Icons.gavel, size: 20, color: cs.secondaryFixed),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('HomeX Direct Protection Guarantee', style: tt.bodyMedium?.copyWith(color: cs.onPrimaryContainer, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Funds stay protected in regulated institutional escrow until title registration is certified by accredited lawyers. Zero unauthorized releases.',
                  style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.inversePrimary.withValues(alpha: 0.8), height: 1.5),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Icon(Icons.verified_user, size: 12, color: cs.secondaryFixed),
                  const SizedBox(width: 4),
                  Text('${AppStrings.appName} Regulated Escrow', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.secondaryFixed, fontWeight: FontWeight.w700)),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  }