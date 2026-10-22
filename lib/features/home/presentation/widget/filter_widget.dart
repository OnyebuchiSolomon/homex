import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({super.key});

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  String _dealModel = 'direct_owner';

  final Set<String> _legalChecks = {
    'consent',
    'coo',
    'audit',
  };

  final Set<String> _securityChecks = {
    'bvn',
    'escrow',
  };

  int _pricePreset = 1;

  final Set<String> _hubs = {
    'Ikoyi',
    'Lekki Phase 1',
  };

  final Set<String> _categories = {
    'Detached Duplex',
    'Penthouse',
  };

  int _bedroomIndex = 4;

  final Set<String> _amenities = {
    'power',
    'bq',
    'pool',
  };

  int _matchCount = 142;

  final TextEditingController _minPriceController =
  TextEditingController(
    text: '20,000,000',
  );

  final TextEditingController _maxPriceController =
  TextEditingController(
    text: '350,000,000',
  );

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _resetAll() {
    setState(() {
      _dealModel = 'direct_owner';

      _legalChecks
        ..clear()
        ..addAll({
          'consent',
          'coo',
          'audit',
        });

      _securityChecks
        ..clear()
        ..addAll({
          'bvn',
          'escrow',
        });

      _pricePreset = 1;

      _hubs
        ..clear()
        ..addAll({
          'Ikoyi',
          'Lekki Phase 1',
        });

      _categories
        ..clear()
        ..addAll({
          'Detached Duplex',
          'Penthouse',
        });

      _bedroomIndex = 4;

      _amenities
        ..clear()
        ..addAll({
          'power',
          'bq',
          'pool',
        });

      _minPriceController.text = '20,000,000';
      _maxPriceController.text = '350,000,000';

      _matchCount = 1890;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.96,
      expand: false,
      builder: (context, scrollController) {
        return Material(
          color: colors.surfaceContainerLow,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _buildHandle(context),
              _buildHeader(context),
              _buildMatchBanner(context),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    12,
                    16,
                    24,
                  ),
                  children: [
                    _buildDealTypeSection(context),
                    const SizedBox(height: 16),
                    _buildLegalSection(context),
                    const SizedBox(height: 16),
                    _buildSecuritySection(context),
                    const SizedBox(height: 16),
                    _buildPriceSection(context),
                    const SizedBox(height: 16),
                    _buildLocationSection(context),
                    const SizedBox(height: 16),
                    _buildCategorySection(context),
                    const SizedBox(height: 16),
                    _buildBedroomsAndAmenitiesSection(context),
                  ],
                ),
              ),
              _buildFooterActions(context),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // HANDLE
  // ---------------------------------------------------------------------------

  Widget _buildHandle(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 4,
      ),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: colors.outlineVariant,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        8,
        4,
        8,
        8,
      ),
      child: Row(
        children: [
          ScaleOnTap(
            onTap: () => Navigator.of(context).pop(),
            child: SizedBox(
              width: 36,
              height: 36,
              child: Icon(
                Icons.close,
                color: colors.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Filters',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: colors.onSurface,
              ),
            ),
          ),
          ScaleOnTap(
            onTap: _resetAll,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 8,
              ),
              child: Text(
                'Reset All',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // MATCH BANNER
  // ---------------------------------------------------------------------------

  Widget _buildMatchBanner(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      width: double.infinity,
      color: colors.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 6,
        runSpacing: 4,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: colors.secondary,
              shape: BoxShape.circle,
            ),
          ),
          Text.rich(
            TextSpan(
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
              children: [
                TextSpan(
                  text: '$_matchCount properties',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: ' match current criteria',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Direct Deals',
              style: textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: colors.onSecondaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION CARD
  // ---------------------------------------------------------------------------

  Widget _sectionCard(
      BuildContext context, {
        required Widget child,
      }) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.outlineVariant.withValues(
            alpha: 0.4,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION TITLE
  // ---------------------------------------------------------------------------

  Widget _sectionTitle(
      BuildContext context, {
        required IconData icon,
        required String title,
        Widget? trailing,
      }) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: colors.secondary,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // DEAL TYPE
  // ---------------------------------------------------------------------------

  Widget _buildDealTypeSection(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final options = [
      [
        'direct_owner',
        'Direct from Owner (0% Commission)',
        'Verified title owner directly listed',
      ],
      [
        'verified_landlord',
        'Verified Landlords',
        'Institutions & verified family estates',
      ],
      [
        'developer_direct',
        'Developer Direct',
        'Primary off-plan and completed towers',
      ],
      [
        'all_deals',
        'All Deals',
        'Include partner institutional portfolios',
      ],
    ];

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            context,
            icon: Icons.handshake,
            title: 'Deal Type & Direct Model',
          ),

          const SizedBox(height: 12),

          ...options.map(
                (option) {
              final selected = _dealModel == option[0];

              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: ScaleOnTap(
                  onTap: () {
                    setState(() {
                      _dealModel = option[0];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selected
                          ? colors.primary.withValues(
                        alpha: 0.05,
                      )
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? colors.outlineVariant
                            : colors.outlineVariant.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          size: 18,

                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                option[1],
                                style:
                                textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  // color: selected
                                  //     ? colors.primary
                                  //     : colors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                option[2],
                                style:
                                textTheme.labelSmall?.copyWith(
                                  fontSize: 11,
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LEGAL
  // ---------------------------------------------------------------------------

  Widget _buildLegalSection(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final checks = [
      [
        'consent',
        "Governor's Consent Verified",
        'State Land Bureau stamped & cross-checked',
      ],
      [
        'coo',
        'Certificate of Occupancy (C of O)',
        'Original root title validated',
      ],
      [
        'deed',
        'Deed of Assignment Ready',
        'Registered legal survey plan lodged',
      ],
      [
        'fcda',
        'FCDA Allocation Documented',
        'Applicable for Abuja Federal Capital territory',
      ],
      [
        'audit',
        'Zero Dispute Registry Audit',
        'Court judgment checks & non-acquisition guarantee',
      ],
    ];

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            context,
            icon: Icons.verified_user,
            title: 'Title & Legal Verification',
          ),

          const SizedBox(height: 4),

          Text(
            'Filters exclusively for properties with fully validated Nigerian land registry documents.',
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 12),

          ...checks.map(
                (check) => _checkboxRow(
              context,
              id: check[0],
              title: check[1],
              subtitle: check[2],
              set: _legalChecks,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECURITY
  // ---------------------------------------------------------------------------

  Widget _buildSecuritySection(BuildContext context) {
    final checks = [
      [
        'bvn',
        'BVN / NIN Verified Owner',
        'Identity verified via Nimc / NIBSS',
        Icons.badge,
      ],
      [
        'escrow',
        'Secured Escrow Eligible',
        'Stanbic IBTC & Providus Trustee',
        Icons.account_balance,
      ],
      [
        'inspection',
        'Instant Inspection Booking',
        'Same-day verified agent escort',
        Icons.schedule,
      ],
      [
        'trust',
        '90%+ Trust Rating Only',
        'Calculated from legal audits',
        Icons.workspace_premium,
      ],
    ];

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            context,
            icon: Icons.security,
            title: 'Security & Transaction Assurance',
          ),

          const SizedBox(height: 12),

          ...checks.map(
                (check) => _checkboxRow(
              context,
              id: check[0] as String,
              title: check[1] as String,
              subtitle: check[2] as String,
              leadingIcon: check[3] as IconData,
              set: _securityChecks,
              trailingCheckbox: true,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CHECKBOX ROW
  // ---------------------------------------------------------------------------

  Widget _checkboxRow(
      BuildContext context, {
        required String id,
        required String title,
        required String subtitle,
        required Set<String> set,
        IconData? leadingIcon,
        bool trailingCheckbox = false,
      }) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final checked = set.contains(id);

    final checkbox = Icon(
      checked
          ? Icons.check_box
          : Icons.check_box_outline_blank,
      size: 20,
      // color: checked
      //     ? colors.primary
      //     : colors.outline,
    );

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: ScaleOnTap(
        onTap: () {
          setState(() {
            if (checked) {
              set.remove(id);
            } else {
              set.add(id);
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colors.outlineVariant.withValues(
                alpha: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              if (!trailingCheckbox) checkbox,

              if (!trailingCheckbox)
                const SizedBox(width: 10),

              if (leadingIcon != null) ...[
                Icon(
                  leadingIcon,
                  size: 18,
                  color: colors.onSurface,
                ),
                const SizedBox(width: 10),
              ],

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              if (trailingCheckbox) checkbox,
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PRICE
  // ---------------------------------------------------------------------------

  Widget _buildPriceSection(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final presets = [
      '< ₦50M',
      '₦50M - ₦150M',
      '₦150M - ₦300M',
      '₦300M+',
    ];

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            context,
            icon: Icons.payments,
            title: 'Price Range (₦)',
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _priceField(
                  context,
                  label: 'Minimum Price',
                  controller: _minPriceController,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _priceField(
                  context,
                  label: 'Maximum Price',
                  controller: _maxPriceController,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            'Quick Presets',
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              presets.length,
                  (index) {
                final selected =
                    _pricePreset == index;

                return ScaleOnTap(
                  onTap: () {
                    setState(() {
                      _pricePreset = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? colors.primary
                          : Colors.transparent,
                      borderRadius:
                      BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? colors.primary
                            : colors.outlineVariant
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    child: Text(
                      presets[index],
                      style:
                      textTheme.labelSmall?.copyWith(
                        color: selected
                            ? colors.onPrimary
                            : colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PRICE FIELD
  // ---------------------------------------------------------------------------

  Widget _priceField(
      BuildContext context, {
        required String label,
        required TextEditingController controller,
      }) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 6),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colors.outlineVariant.withValues(
                alpha: 0.8,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Text(
                '₦',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(width: 4),

              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurface,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                  cursorColor: colors.primary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                    contentPadding:
                    const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // LOCATION
  // ---------------------------------------------------------------------------

  Widget _buildLocationSection(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final hubs = [
      'Ikoyi',
      'Lekki Phase 1',
      'Victoria Island',
      'Banana Island',
      'Maitama, Abuja',
      'Asokoro, Abuja',
    ];

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            context,
            icon: Icons.location_on,
            title: 'Location & Prime Corridors',
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colors.outlineVariant.withValues(
                  alpha: 0.8,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 18,
                  color: colors.onSurfaceVariant,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: TextField(
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurface,
                    ),
                    cursorColor: colors.primary,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      hintText:
                      'Search neighborhood, district or street...',
                      hintStyle:
                      textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Prime Hubs (Lagos & Abuja)',
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: hubs.map(
                  (hub) {
                final selected =
                _hubs.contains(hub);

                return ScaleOnTap(
                  onTap: () {
                    setState(() {
                      if (selected) {
                        _hubs.remove(hub);
                      } else {
                        _hubs.add(hub);
                      }
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? colors.primary
                          : Colors.transparent,
                      borderRadius:
                      BorderRadius.circular(999),
                      border: Border.all(
                        color: selected
                            ? colors.primary
                            : colors.outlineVariant
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          hub,
                          style:
                          textTheme.labelSmall?.copyWith(
                            color: selected
                                ? colors.onPrimary
                                : colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        if (selected) ...[
                          const SizedBox(width: 4),
                          Icon(
                            Icons.check,
                            size: 12,
                            color: colors.onPrimary,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PROPERTY CATEGORY
  // ---------------------------------------------------------------------------

  Widget _buildCategorySection(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final categories = [
      'Detached Duplex',
      'Penthouse',
      'Semi-Detached',
      'Terrace House',
      'Luxury Apartment',
      'Waterfront Villa',
      'Commercial',
    ];

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            context,
            icon: Icons.home_work,
            title: 'Property Category',
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map(
                  (category) {
                final selected =
                _categories.contains(category);

                return ScaleOnTap(
                  onTap: () {
                    setState(() {
                      if (selected) {
                        _categories.remove(category);
                      } else {
                        _categories.add(category);
                      }
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? colors.primary
                          : Colors.transparent,
                      borderRadius:
                      BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? colors.primary
                            : colors.outlineVariant
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    child: Text(
                      category,
                      style:
                      textTheme.labelSmall?.copyWith(
                        color: selected
                            ? colors.onPrimary
                            : colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BEDROOMS & AMENITIES
  // ---------------------------------------------------------------------------

  Widget _buildBedroomsAndAmenitiesSection(
      BuildContext context,
      ) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final bedroomOptions = [
      'Any',
      '1+',
      '2+',
      '3+',
      '4+',
      '5+',
    ];

    final amenities = [
      [
        'power',
        '24/7 Guaranteed Power',
      ],
      [
        'bq',
        'BQ Included',
      ],
      [
        'pool',
        'Swimming Pool',
      ],
      [
        'solar',
        'Solar Inverter System',
      ],
      [
        'smart',
        'Smart Home Automation',
      ],
      [
        'cinema',
        'Private Cinema',
      ],
    ];

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            context,
            icon: Icons.bed,
            title: 'Bedrooms',
          ),

          const SizedBox(height: 12),

          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 8.0;

              final itemWidth =
                  (constraints.maxWidth -
                      gap *
                          (bedroomOptions.length - 1)) /
                      bedroomOptions.length;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: List.generate(
                  bedroomOptions.length,
                      (index) {
                    final selected =
                        _bedroomIndex == index;

                    return SizedBox(
                      width: itemWidth,
                      child: ScaleOnTap(
                        onTap: () {
                          setState(() {
                            _bedroomIndex = index;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? colors.primary
                                : Colors.transparent,
                            borderRadius:
                            BorderRadius.circular(10),
                            border: Border.all(
                              color: selected
                                  ? colors.primary
                                  : colors.outlineVariant
                                  .withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                          child: Text(
                            bedroomOptions[index],
                            style: textTheme.labelSmall
                                ?.copyWith(
                              color: selected
                                  ? colors.onPrimary
                                  : colors.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          Text(
            'Key Nigerian Infrastructure & Amenities',
            style: textTheme.labelMedium?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: amenities.map(
                  (amenity) {
                final id = amenity[0];
                final title = amenity[1];

                final selected =
                _amenities.contains(id);

                return ScaleOnTap(
                  onTap: () {
                    setState(() {
                      if (selected) {
                        _amenities.remove(id);
                      } else {
                        _amenities.add(id);
                      }
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      color: selected
                          ? colors.primary.withValues(
                        alpha: 0.05,
                      )
                          : Colors.transparent,
                      border: Border.all(
                        color: colors.outlineVariant
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          selected
                              ? Icons.check_box
                              : Icons
                              .check_box_outline_blank,
                          size: 16,
                          color: selected
                              ? colors.primary
                              : colors.outline,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          title,
                          style:
                          textTheme.labelSmall?.copyWith(
                            fontSize: 11,
                            color: colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FOOTER
  // ---------------------------------------------------------------------------

  Widget _buildFooterActions(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: colors.outlineVariant,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        context.bottomPadding + 12,
      ),
      child: Row(
        children: [
          ScaleOnTap(
            onTap: () {},
            child: Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(12),
                border: Border.all(
                  color: colors.outline,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_active,
                    size: 18,
                    color: colors.onSurface,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    'Save Alert',
                    style:
                    textTheme.labelSmall?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: ScaleOnTap(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius:
                  BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Show $_matchCount Properties',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style:
                        textTheme.labelMedium
                            ?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: colors.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}