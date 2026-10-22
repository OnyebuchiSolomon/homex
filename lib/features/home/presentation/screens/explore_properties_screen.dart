import 'package:flutter/material.dart';

import 'package:homex/ui/global.dart';

import '../widget/filter_widget.dart';

enum _ViewMode { grid, map }

class _PropertyCard {
  final String imageUrl;
  final List<String> topBadges;
  final String priceLabel;
  final String title;
  final String location;
  final List<String> specs;
  final String sellerName;
  final String sellerNote;
  final String footerBadge;

  const _PropertyCard({
    required this.imageUrl,
    required this.topBadges,
    required this.priceLabel,
    required this.title,
    required this.location,
    required this.specs,
    required this.sellerName,
    required this.sellerNote,
    required this.footerBadge,
  });
}

class ExplorePropertiesScreen extends StatefulWidget {
  const ExplorePropertiesScreen({super.key});

  @override
  State<ExplorePropertiesScreen> createState() => _ExplorePropertiesScreenState();
}

class _ExplorePropertiesScreenState extends State<ExplorePropertiesScreen> {
  _ViewMode _viewMode = _ViewMode.grid;
  int _selectedQuickFilter = 0;

  static const List<String> _quickFilters = [
    'All (142)',
    'Direct from Owner',
    '0% Agency Fee',
    'Verified Title (C of O)',
    'Duplexes',
    'Lekki & Ikoyi',
  ];

  static const List<_PropertyCard> _properties = [
    _PropertyCard(
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDfEGsV4UI4Tt9dxO75UyXdK3bTO-ssTa7bNTym81S_3LnpCvLzdhFGE7KDd6XHqtAzjeCLAGlOH2wQSujSOuKsRjFmPZKR_sgw4wlDk7ocSFdwGXZCvjkmHdxJ5MQQ214cZdguh-ND97lbKDA00L1n2sW7QKooogJMNDgsdQaqdhk38uFRT3S9x7O8hJeMBYYau63lpP7CsrAYuPmFH31XGpokW9pYhTL8rR0gTlv2wbbFKUZMssN4',
      topBadges: ['Direct Owner Verified'],
      priceLabel: '₦85,000,000',
      title: 'Contemporary 4-Bed Smart Detached Duplex',
      location: 'Admiralty Way, Lekki Phase 1, Lagos',
      specs: ['4 Bedrooms', '5 Baths', '3 Cars Park'],
      sellerName: 'Otunba Adeleke (Owner)',
      sellerNote: 'Identity & Gov ID Verified • 99% Response',
      footerBadge: 'Escrow Protected',
    ),
    _PropertyCard(
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAD3mgpPyHrFNL8dG5018dYLsvqwiveuaTZUGeC4czaR8r030CiggS71nsR1AEXIOTtr7927sMXJqmQIDSeDxcJBwPuvU-s2pMkemMyBTmwc6QAP38AbN4JyOauCu41xmV0UgaAe2Cg3gsr09lzTvauRUflOS4z_wiYGfDM6XlRH2mJ7Pz3HWl35H_eZyPDTfn8ZVyJGH96jLP8-5M6e1y0m62YGQjHudJMrKmgFSqmm8w6O4lTIyad',
      topBadges: ["Governor's Consent"],
      priceLabel: '₦220,000,000',
      title: 'Palatial 5-Bed Detached Villa with Cinema & Pool',
      location: 'Bournillon Road, Old Ikoyi, Lagos',
      specs: ['5 Beds', '6 Baths', 'Pool', '24/7 Power'],
      sellerName: 'Adeyemi Estates Trust',
      sellerNote: '98% Trust Score',
      footerBadge: 'Tier 1 Asset',
    ),
    _PropertyCard(
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBE8nqhvWEmyg0CLgx2QyNfEjNbEDECr0e2SORihjf-dnPcvfWVjy9appNpR7s6Hd35LyZbQqVuxcEebsVFyfAOiGhXDfujS7jnYy5tLzfZOFsFxtp6o00rU7cWx2IAbvy3d7jVDg364G2SPvJXEojpnxKZtatlDs6HWVA6X_LYJIZD64bU4Bb4Vm62jAG98YZEOh6CZxc-OCiE4Oq6iQwEGyQFZqy4EXUNi2nHN56oxFCbm6c3dOnk',
      topBadges: ['Direct Landlord', 'Instant Inspection'],
      priceLabel: '₦7,500,000/yr',
      title: 'Fully Serviced 2-Bed Waterfront Residence',
      location: 'Ozumba Mbadiwe Avenue, Victoria Island, Lagos',
      specs: ['2 Beds', '2 Baths', 'Gym', '24h Guard'],
      sellerName: 'Dr. K. Briggs (Verified)',
      sellerNote: 'Service Charge: ₦1.2M',
      footerBadge: 'Annual Rental',
    ),
    _PropertyCard(
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuA0-qCyXQrb_pmKwf32FHal5RWHtCIx1rrqfver63ZUOWTlQUQDj-hVYyXTLAwljgJY3FuGdnJR62l7-n99V4yD6UiKnx8aa17bkWpKzj5oju0LcEtdsLg1PTI3f4-aUWyAKvXOeZLtYOA741ojQPE_sliZ0NYL4pp-VJ5Vh5F2YUlKvobUC70BPVLOQmpRRNBzbIGmY9LkikyZIOWfo8kEiXjC-N3g2JNz6vEAbw8O7xz_oK9zGzD4',
      topBadges: ['C of O Verified'],
      priceLabel: '₦110,000,000',
      title: 'Brand New 4-Bedroom Terrace with BQ',
      location: 'Yakubu Gowon Crescent, Asokoro, Abuja',
      specs: ['4 Beds', '5 Baths', 'Solar Inverter'],
      sellerName: 'FCDA Allocated Title',
      sellerNote: 'Zero Legal Surprises',
      footerBadge: 'Owner Direct',
    ),
  ];

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FiltersBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hPad = _hPad(context);

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildStickyHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._properties.map(
                          (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ScrollReveal(child: _buildPropertyCard(context, p)),
                      ),
                    ),
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
  Widget _buildStickyHeader(BuildContext context, double hPad) {
    final textTheme = context.textTheme;
final color = context.colors;
    return Container(
      color: context.theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScaleOnTap(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                       // decoration: const BoxDecoration(color: AppColors.lightSurfaceContainer, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_back,  color: context.colors.onSurface),
                      ),
                      const SizedBox(width: 6),
                      Text('Explore', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: color.secondaryFixed.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.verified_user, size: 13, color: AppColors.secondary),
                          const SizedBox(width: 4),
                          Text('Direct Deal', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.secondary, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // ScaleOnTap(
                    //   onTap: () {},
                    //   child: Container(
                    //     width: 32,
                    //     height: 32,
                    //     decoration: const BoxDecoration(color: AppColors.lightSurfaceContainer, shape: BoxShape.circle),
                    //     alignment: Alignment.center,
                    //     child: Icon(Icons.notifications, size: 18, color: AppColors.lightTextSecondary),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Explore Properties', style: textTheme.headlineSmall?.copyWith(fontSize: 20), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(
                        "Nigeria's zero-commission on escrow verified direct market",
                        style: textTheme.labelSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Container(
                //   padding: const EdgeInsets.all(3),
                //   decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(8)),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       _viewToggleButton(context, label: 'Grid', icon: Icons.grid_view, mode: _ViewMode.grid),
                //       _viewToggleButton(context, label: 'Map', icon: Icons.map, mode: _ViewMode.map),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 8),
            child: Row(
              children: [
                Expanded(

                  child: TextEditView(
                      controller: TextEditingController(),
                    hintText: 'Search Lekki, C of O, 4 Bed duplex...',
                  prefixIcon:  Icon(Icons.search, size: 20, color: context.colors.primary),
                  ),
                  /*
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.lightSurfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.6)),
                    ),
                    height: 44,
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 20, color: AppColors.lightOutline),
                        const SizedBox(width: 6),
                        Expanded(
                          child: TextField(
                            style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              hintText: 'Search Lekki, C of O, 4 Bed duplex...',
                            ),
                            controller: TextEditingController(text: 'Lekki Phase 1, Lagos'),
                          ),
                        ),
                        Icon(Icons.cancel, size: 16, color: AppColors.lightTextSecondary),
                      ],
                    ),
                  )
                   */
                ),
                const SizedBox(width: 8),
                ScaleOnTap(
                  onTap: () => _openFilters(context),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: color.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: color.outlineVariant.withValues(alpha: 0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.tune, size: 18, ),
                        const SizedBox(width: 4),
                        Text('Filters', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(width: 4),
                        Container(width: 6, height: 6, decoration:   BoxDecoration(color: AppColors.secondaryContainer, shape: BoxShape.circle)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: hPad),
              itemCount: _quickFilters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final selected = _selectedQuickFilter == index;
                return ScaleOnTap(
                  onTap: () => setState(() => _selectedQuickFilter = index),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: selected ? (context.isDarkTheme?color.surfaceContainerHighest:color.primary) :(context.isDarkTheme?color.primary:color.surfaceContainerHighest),
                      borderRadius: BorderRadius.circular(999),
                      border: selected ? Border.all(color: color.outlineVariant) : null,
                    ),
                    child: Text(
                      _quickFilters[index],
                      style: textTheme.labelSmall?.copyWith(
                        color: selected ? color.onPrimary : color.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            color: context.colors.surfaceContainerLow.withValues(alpha: 0.7),
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.security, size: 14, color: AppColors.onTertiaryContainer),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            style: textTheme.labelSmall?.copyWith(fontSize: 11,),
                            children: [
                              const TextSpan(text: '142 verified properties ', style: TextStyle(fontWeight: FontWeight.w700,)),
                              const TextSpan(text: 'with zero agent markups'),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Sort: Recently Listed', style: textTheme.labelSmall?.copyWith(fontSize: 11,  fontWeight: FontWeight.w600)),
                   // Icon(Icons.arrow_drop_down, size: 16, color: context.colors.primary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewToggleButton(BuildContext context, {required String label, required IconData icon, required _ViewMode mode}) {
    final textTheme = context.textTheme;
    final selected = _viewMode == mode;
    return ScaleOnTap(
      onTap: () => setState(() => _viewMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.lightSurfaceContainerLowest : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: selected ? context.colors.primary : AppColors.lightTextSecondary),
            const SizedBox(width: 4),
            Text(label, style: textTheme.labelSmall?.copyWith(fontSize: 11, color: selected ? context.colors.primary : AppColors.lightTextSecondary, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, _PropertyCard p) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return ScaleOnTap(
      onTap: () =>AppNavigator.pushAndStackNamed(AppRoutes.propertyDetailsScreen),
      child: Container(
        decoration: BoxDecoration(
        color:color. surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.outlineVariant.withValues(alpha: 0.4)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: ImageView.networkCached(
                    p.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: Container(color: color.surfaceContainer, child: const Icon(Icons.image_not_supported_outlined)),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  right: 46,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: p.topBadges
                        .map((b) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(6)),
                      child: Text(b, style: textTheme.labelSmall?.copyWith(fontSize: 10, color: context.colors.onPrimary, fontWeight: FontWeight.w700)),
                    ))
                        .toList(),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: ScaleOnTap(
                    onTap: () {},
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(color: color.surface.withValues(alpha: 0.9), shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Icon(Icons.favorite_border, size: 16,),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(p.priceLabel, style: textTheme.headlineSmall),
                  ),
                  const SizedBox(height: 6),
                  Text(p.title, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14,),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(p.location, style: textTheme.labelSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(spacing: 12, runSpacing: 6, children: p.specs.map((s) => Text(s, style: textTheme.bodySmall)).toList()),
                  const SizedBox(height: 10),
                  Container(height: 1, color: color.outlineVariant),
                  const SizedBox(height: 10),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(p.sellerName, style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                  //           Text(p.sellerNote, style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                  //         ],
                  //       ),
                  //     ),
                  //     const SizedBox(width: 6),
                  //     Container(
                  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //       decoration: BoxDecoration(color: AppColors.tertiaryFixedDim, borderRadius: BorderRadius.circular(999)),
                  //       child: Text(p.footerBadge, style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.tertiaryContainer, fontWeight: FontWeight.w700)),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 12),
                  ScaleOnTap(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(color: context.isDarkTheme?  color.surfaceContainerHighest:color.primary, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.policy, size: 16, color: Colors.white),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'View Deal & Title Documents',
                              textAlign: TextAlign.center,
                              style: textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuaranteeBanner(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.gavel, size: 20, color: AppColors.secondaryContainer),
              const SizedBox(width: 8),
              Text('Direct-Deal Guarantee', style: textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Every property on HomeX has its title verified at state land registries. Funds stay locked in regulated banking escrow until both buyer and seller verify the physical handover.',
            style: textTheme.labelSmall?.copyWith(color: Colors.white.withValues(alpha: 0.85), height: 1.5),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: const [
              _GuaranteeChip(label: '0% Agent Fee'),
              _GuaranteeChip(label: 'Registry Title Audit'),
            ],
          ),
        ],
      ),
    );
  }

 }

class _GuaranteeChip extends StatelessWidget {
  final String label;
  const _GuaranteeChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, size: 14, color: AppColors.secondaryContainer),
        const SizedBox(width: 4),
        Text(label, style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.secondaryContainer, fontWeight: FontWeight.w700)),
      ],
    );
  }
}