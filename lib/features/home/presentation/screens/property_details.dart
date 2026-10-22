 import 'package:homex/features/home/presentation/widget/schedule_inspection_sheet.dart';

import 'package:homex/ui/global.dart';

import '../widget/video_player_card.dart';

// Change this import to the actual location of your ImageView.

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() =>
      _PropertyDetailsScreenState();
}

// ============================================================
// PROPERTY MEDIA
// ============================================================

enum PropertyMediaType {
  image,
  video,
}

class PropertyMedia {
  final String url;
  final PropertyMediaType type;

  const PropertyMedia({
    required this.url,
    required this.type,
  });
}

// ============================================================
// SCREEN
// ============================================================

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  bool _isSaved = false;

  final List<PropertyMedia> _media = const [
    PropertyMedia(
      url:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBjJBQ9RfzWBNo8U1hxCkNMsnYrehDgowuRBvraGqxvWGK5puArq5j0aCxSw4byG7k2TArj7FGy29RCmN_zdBUjlgszpkgrYPb9Qnu9e805A0WN1tOox8xp2-vTa-B-ouDpG_NAKGrSntDwHaBsecCc7IbGc7kwOFyCPjSiugKFqBQ7xzCXaADI2ZdfPyGxCxCFqQLgBp4RdF25pbl65SMfrdOwn3hTJxzAxXzLfPSx_iuggCxTH4yU',
      type: PropertyMediaType.image,
    ),

    PropertyMedia(
      url:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBjJBQ9RfzWBNo8U1hxCkNMsnYrehDgowuRBvraGqxvWGK5puArq5j0aCxSw4byG7k2TArj7FGy29RCmN_zdBUjlgszpkgrYPb9Qnu9e805A0WN1tOox8xp2-vTa-B-ouDpG_NAKGrSntDwHaBsecCc7IbGc7kwOFyCPjSiugKFqBQ7xzCXaADI2ZdfPyGxCxCFqQLgBp4RdF25pbl65SMfrdOwn3hTJxzAxXzLfPSx_iuggCxTH4yU',
      type: PropertyMediaType.image,
    ),

    PropertyMedia(
      url:
      'https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_1MB.mp4',
      type: PropertyMediaType.video,
    ),

    PropertyMedia(
      url:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBjJBQ9RfzWBNo8U1hxCkNMsnYrehDgowuRBvraGqxvWGK5puArq5j0aCxSw4byG7k2TArj7FGy29RCmN_zdBUjlgszpkgrYPb9Qnu9e805A0WN1tOox8xp2-vTa-B-ouDpG_NAKGrSntDwHaBsecCc7IbGc7kwOFyCPjSiugKFqBQ7xzCXaADI2ZdfPyGxCxCFqQLgBp4RdF25pbl65SMfrdOwn3hTJxzAxXzLfPSx_iuggCxTH4yU',
      type: PropertyMediaType.image,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final isMobile = width < 600;
            final isTablet = width >= 600 && width < 1024;
            final isDesktop = width >= 1024;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildAppBar(
                  context,
                  isMobile: isMobile,
                ),

                SliverToBoxAdapter(
                  child: _buildPropertyGallery(
                    context,
                    isMobile: isMobile,
                    isTablet: isTablet,
                    isDesktop: isDesktop,
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _horizontalPadding(
                      width,
                      isMobile: isMobile,
                      isTablet: isTablet,
                    ),
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _buildContent(
                      context,
                      width: width,
                      isMobile: isMobile,
                      isTablet: isTablet,
                      isDesktop: isDesktop,
                    ),
                  ),
                ),

                if (isMobile)
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 96),
                  ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: _buildMobileActionBar(context),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  Widget _buildAppBar(
      BuildContext context, {
        required bool isMobile,
      }) {
    final colors = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: colors.surface.withValues(alpha: 0.94),
      surfaceTintColor: colors.surface,
      automaticallyImplyLeading: false,
      toolbarHeight: isMobile ? 64 : 72,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 8 : 16,
        ),
        child: Row(
          children: [
            IconButton(
              tooltip: 'Go back',
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: colors.onSurface,
              ),
            ),

            const SizedBox(width: 4),

            Expanded(
              child: Text(
                'Property Details',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.headlineSmall.copyWith(
                  color: colors.onSurface,
                ),
              ),
            ),

            IconButton(
              tooltip: 'Share property',
              onPressed: () {
                // TODO: Share property.
              },
              icon: Icon(
                Icons.share_outlined,
                color: colors.onSurface,
              ),
            ),

            IconButton(
              tooltip: 'Save property',
              onPressed: () {
                setState(() {
                  _isSaved = !_isSaved;
                });
              },
              icon: Icon(
                _isSaved
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: _isSaved
                    ? colors.error
                    : colors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PROPERTY GALLERY
  // ============================================================

  Widget _buildPropertyGallery(
      BuildContext context, {
        required bool isMobile,
        required bool isTablet,
        required bool isDesktop,
      }) {

    final galleryHeight = _galleryHeight(
      context,
      isMobile: isMobile,
      isTablet: isTablet,
      isDesktop: isDesktop,
    );

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 1280,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: isMobile ? 0 : 16,
            left: isMobile ? 0 : 24,
            right: isMobile ? 0 : 24,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              isMobile ? 0 : 16,
            ),
            child: SizedBox(
              width: double.infinity,
              height: galleryHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _PropertyGallery(
                    media: _media,
                  ),

                  Positioned(
                    top: 16,
                    right: 16,
                    child: _verifiedBadge(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _galleryHeight(
      BuildContext context, {
        required bool isMobile,
        required bool isTablet,
        required bool isDesktop,
      }) {
    final width = MediaQuery.sizeOf(context).width;

    if (isMobile) {
      return (width * 0.88).clamp(
        300.0,
        420.0,
      );
    }

    if (isTablet) {
      return (width * 0.55).clamp(
        380.0,
        520.0,
      );
    }

    return 530.0;
  }

  // ============================================================
  // VERIFIED BADGE
  // ============================================================

  Widget _verifiedBadge(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withValues(
          alpha: 0.94,
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colors.secondary.withValues(
            alpha: 0.2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.verified,
              size: 16,
              color: colors.onSecondaryContainer,
            ),
            const SizedBox(width: 6),
            Text(
              'VERIFIED PROPERTY',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CONTENT
  // ============================================================

  Widget _buildContent(
      BuildContext context, {
        required double width,
        required bool isMobile,
        required bool isTablet,
        required bool isDesktop,
      }) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 1280,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: isMobile ? 16 : 24,
            bottom: 24,
          ),
          child: isDesktop
              ? _buildDesktopContent(context)
              : _buildMobileContent(context),
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE / TABLET
  // ============================================================

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPropertyInfoCard(context),

        const SizedBox(height: 20),

        _buildDescriptionCard(context),

        const SizedBox(height: 20),

        _buildAmenitiesCard(context),

        const SizedBox(height: 20),

        _buildLocationCard(context),

        const SizedBox(height: 20),

        _buildOwnerCard(context),

        const SizedBox(height: 20),

        _buildFinancingCard(context),
      ],
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPropertyInfoCard(context),

              const SizedBox(height: 24),

              _buildDescriptionCard(context),

              const SizedBox(height: 24),

              _buildAmenitiesCard(context),

              const SizedBox(height: 24),

              _buildLocationCard(context),
            ],
          ),
        ),

        const SizedBox(width: 24),

        SizedBox(
          width: 360,
          child: Column(
            children: [
              _buildOwnerCard(context),

              const SizedBox(height: 16),

              _buildFinancingCard(context),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROPERTY INFO
  // ============================================================

  Widget _buildPropertyInfoCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '₦45,000,000',
            style: AppTextStyles.headlineMedium
          ),

          const SizedBox(height: 4),

          Text(
            'Luxury 4-Bedroom Semi-Detached Duplex',
            style: AppTextStyles.headlineSmall.copyWith(
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18,

              ),

              const SizedBox(width: 4),

              Expanded(
                child: Text(
                  'Lekki Phase 1, Lagos',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Divider(
            height: 1,
            color: colors.outlineVariant,
          ),

          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _specItem(
                    context,
                    icon: Icons.bed_outlined,
                    value: '4',
                    label: 'Beds',
                  ),
                  _specItem(
                    context,
                    icon: Icons.bathtub_outlined,
                    value: '4',
                    label: 'Baths',
                  ),
                  _specItem(
                    context,
                    icon: Icons.directions_car_outlined,
                    value: '2',
                    label: 'Parking',
                  ),
                  _specItem(
                    context,
                    icon: Icons.square_foot_outlined,
                    value: '450',
                    label: 'Sqm',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _specItem(
      BuildContext context, {
        required IconData icon,
        required String value,
        required String label,
      }) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 24,
              //color: colors.primary,
            ),
          ),
        ),

        const SizedBox(width: 8),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                color: colors.onSurface,
              ),
            ),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  Widget _buildDescriptionCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Property Description',
            style: AppTextStyles.headlineSmall.copyWith(
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Experience unparalleled luxury in this contemporary '
                '4-bedroom semi-detached duplex situated in the prestigious '
                'heart of Lekki Phase 1. Designed with a blend of corporate '
                'modernism and residential comfort, the property features '
                'premium finishes, high ceilings, and expansive glass '
                'windows that flood the interiors with natural light.\n\n'
                'The ground floor boasts an open-plan living area, a '
                'state-of-the-art fitted kitchen with top-tier appliances, '
                'and a guest en-suite bedroom. Upstairs, the master suite '
                'offers a private balcony, a walk-in closet, and a '
                'spa-inspired bathroom.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 8),

          TextButton(
            onPressed: () {
              // TODO: Expand description.
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 40),
              tapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Read more',
                  style: AppTextStyles.labelMedium,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.expand_more,
                  size: 18,

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // AMENITIES
  // ============================================================

  Widget _buildAmenitiesCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final amenities = [
      (
      Icons.security_outlined,
      '24/7 Security',
      ),
      (
      Icons.bolt_outlined,
      'Backup Power',
      ),
      (
      Icons.water_drop_outlined,
      'Water Treatment',
      ),
      (
      Icons.kitchen_outlined,
      'Fitted Kitchen',
      ),
      (
      Icons.pool_outlined,
      'Swimming Pool',
      ),
      (
      Icons.fitness_center_outlined,
      'Gym',
      ),
    ];

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Premium Amenities',
            style: AppTextStyles.headlineSmall.copyWith(
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              final columns =
              constraints.maxWidth >= 700 ? 3 : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                itemCount: amenities.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisExtent: 44,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final amenity = amenities[index];

                  return Row(
                    children: [
                      Icon(
                        amenity.$1,
                        size: 22,
                        color: colors.primary,
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          amenity.$2,
                          maxLines: 2,
                          overflow:
                          TextOverflow.ellipsis,
                          style:
                          AppTextStyles.bodyMedium
                              .copyWith(
                            color:
                            colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOCATION
  // ============================================================

  Widget _buildLocationCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: AppTextStyles.headlineSmall.copyWith(
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 16),

          AspectRatio(
            aspectRatio: 16 / 7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ImageView.networkCached(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCu1Wa8GrZNU5FG5-CkP33bt_PjCpGciWNiIcCxQ8UgwYNTKD6faQMQQANnphWMx8xyoWzhsFK5KrPrROdIXKF_oUg4ZABb3byCvR8y0-Eo10Kxo2-Kxj-tvPpFSjhI2XdSQr3u2Z6I-fQIB-lIxi-XOrCj0Ar5Zxu6HDJmzdWsrHxpE3oyY3LKynWroaRIDN1djDCJiZj6PMwjURS6RGdbx6he_qlyupiMdwTa03etmvEK-4AKpIe4',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: ColoredBox(
                      color:
                      colors.surfaceContainerHighest,
                      child: Icon(
                        Icons.map_outlined,
                        size: 40,
                        color:
                        colors.onSurfaceVariant,
                      ),
                    ),
                  ),

                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surface.withValues(
                        alpha: 0.85,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.location_on,
                        size: 30,

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // OWNER
  // ============================================================

  Widget _buildOwnerCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return CustomCard(
     onTap: ()=>AppNavigator.pushAndStackNamed(AppRoutes.verifiedSellerProfileScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.surfaceContainerHigh,
                  border: Border.all(
                    color: colors.outlineVariant,
                  ),
                ),
                child: ImageView.networkCached(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCVNK02WUfuwhenKgAivkxEFp_xCn7lT5UNHDK3jZWpDaCp2YqsKZEaR1kACqzxduiQzotT6lk_608lrjQeltXvrkYBXiuIWoJglFtOjDqOZhi-BYZ19ZIxpEXinqM904gdwLvV1eok5ENsCbweMepD42PpSs3ktrbSXtn_X-OBu-3omH-zCQsw7nY_0sZWgvKu9mLlB8qkljU5tcXf_1av49_ZYp9kh903425aaCICRSKLE0dUEtVv',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Okafor',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                      AppTextStyles.headlineSmall.copyWith(
                        color: colors.onSurface,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color:
                          colors.secondaryContainer,
                        ),

                        const SizedBox(width: 4),

                        Expanded(
                          child: Text(
                            'Excellent Reputation (4.8)',
                            style: AppTextStyles.labelMedium
                                .copyWith(
                              color:
                              colors.secondaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          size: 16,
                          color:
                          AppColors.success,
                        ),

                        const SizedBox(width: 4),

                        Expanded(
                          child: Text(
                            'Verified Identity',
                            maxLines: 1,
                            overflow:
                            TextOverflow.ellipsis,
                            style:
                            AppTextStyles.labelSmall
                                .copyWith(
                              color:
                              AppColors.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _primaryButton(
            context,
            label: 'Request Property Visit',
            onPressed: () {
             ScheduleInspectionSheet.show(context);
            },
          ),

          const SizedBox(height: 12),

          _outlinedButton(
            context,
            label: 'Call with Owner',
            icon: Icons.call,
            onPressed: () {
              // TODO: Navigate to chat.
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FINANCING
  // ============================================================

  Widget _buildFinancingCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primary.withValues(
          alpha: 0.05,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.secondary.withValues(
            alpha: 0.10,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Financing Available',
              style: AppTextStyles.labelMedium.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Estimated mortgage from ₦350,000/mo. '
                  'Subject to approval.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 8),

            TextButton(
              onPressed: () {
                // TODO: Mortgage calculator.
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 40),
              ),
              child: Text(
                'Calculate Mortgage',
                style:
                AppTextStyles.labelSmall.copyWith(
                  color: colors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE ACTION BAR
  // ============================================================

  Widget? _buildMobileActionBar(
      BuildContext context,
      ) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= 600) {
      return null;
    }

    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Material(
        color: colors.surfaceContainerLowest,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            12,
            10,
            12,
            10,
          ),
          child: Row(
            children: [
              Expanded(
                child: _actionButton(
                  context,
                  label: 'Offer',
                  icon: Icons.payments_outlined,
                  background:
                  colors.secondaryContainer,
                  foreground:
                  colors.onSecondaryContainer,
                  onPressed: () {
                   AppNavigator.pushAndStackNamed(AppRoutes.makeAnOfferScreen);
                  },
                ),
              ),

              const SizedBox(width: 8),

              // Expanded(
              //   child: _actionButton(
              //     context,
              //     label: 'Chat',
              //     icon: Icons.chat_outlined,
              //     background:
              //     colors.surfaceContainerLowest,
              //     foreground: colors.primary,
              //     border: colors.outline,
              //     onPressed: () {
              //       // TODO: Navigate to chat.
              //     },
              //   ),
              // ),
              //
              // const SizedBox(width: 8),

              Expanded(
                flex: 2,
                child: _actionButton(
                  context,
                  label: 'Request Visit',
                  background: colors.primary,
                  foreground: colors.onPrimary,
                  onPressed: () {
                  ScheduleInspectionSheet.show(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PRIMARY BUTTON
  // ============================================================

  Widget _primaryButton(
      BuildContext context, {
        required String label,
        required VoidCallback onPressed,
      }) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: colors.onPrimary,
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(
            color: colors.outline,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.labelMedium.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // OUTLINED BUTTON
  // ============================================================

  Widget _outlinedButton(
      BuildContext context, {
        required String label,
        required IconData icon,
        required VoidCallback onPressed,
      }) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 18,
          color: context.isDarkTheme?Colors.white:colors.primary,
        ),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodyMedium,
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(
            color: colors.outline,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle:
          AppTextStyles.labelMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ACTION BUTTON
  // ============================================================

  Widget _actionButton(
      BuildContext context, {
        required String label,
        IconData? icon,
        required Color background,
        required Color foreground,
        Color? border,
        required VoidCallback onPressed,
      }) {
    return SizedBox(
      height: 48,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border:  Border.all(
                color: context.colors.outlineVariant,
              ),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 18,
                    color: foreground,
                  ),
                  const SizedBox(width: 5),
                ],
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style:
                    AppTextStyles.labelMedium.copyWith(
                      color: foreground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // COMMON CARD
  // ============================================================

  Widget _sectionCard(
      BuildContext context, {
        required Widget child,
        
      }) {
    return CustomCard(
      child: child,
    );
  }

  // ============================================================
  // RESPONSIVE PADDING
  // ============================================================

  double _horizontalPadding(
      double width, {
        required bool isMobile,
        required bool isTablet,
      }) {
    if (isMobile) {
      return 16;
    }

    if (isTablet) {
      return 24;
    }

    if (width >= 1280) {
      return 0;
    }

    return 24;
  }
}

// ============================================================
// PROPERTY GALLERY
// ============================================================

class _PropertyGallery extends StatefulWidget {
  final List<PropertyMedia> media;

  const _PropertyGallery({
    required this.media,
  });

  @override
  State<_PropertyGallery> createState() =>
      _PropertyGalleryState();
}

class _PropertyGalleryState
    extends State<_PropertyGallery> {
  late final PageController _pageController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void _goToPage(int index) {
    if (index < 0 ||
        index >= widget.media.length) {
      return;
    }

    _pageController.animateToPage(
      index,
      duration: const Duration(
        milliseconds: 280,
      ),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors =
        Theme.of(context).colorScheme;
debugPrint(widget.media.length.toString());
    if (widget.media.isEmpty) {
      return ColoredBox(
        color: colors.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 48,
            color: colors.onSurfaceVariant,
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // ======================================================
        // SWIPEABLE MEDIA
        // ======================================================

        PageView.builder(
          controller: _pageController,
          itemCount: widget.media.length,
          physics:
          const BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return _buildMedia(
              context,
              widget.media[index],
            );
          },
        ),

        // ======================================================
        // GRADIENT
        // ======================================================

        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.scrim.withValues(
                      alpha: 0.06,
                    ),
                    colors.scrim.withValues(
                      alpha: 0.0,
                    ),
                    colors.scrim.withValues(
                      alpha: 0.22,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ======================================================
        // LEFT ARROW
        // ======================================================

        if (_currentIndex > 0)...[
          Positioned(
            left: 12,
            top: 0,
            bottom: 0,
            child: _navigationButton(
              context,
              icon: Icons.chevron_left,
              onPressed: () {
                _goToPage(
                  _currentIndex - 1,
                );
              },
            ),
          ),
        ],


        // ======================================================
        // RIGHT ARROW
        // ======================================================

        if (_currentIndex < widget.media.length - 1)...[
          Positioned(
            right: 12,
            top: 0,
            bottom: 0,
            child: _navigationButton(
              context,
              icon: Icons.chevron_right,
              onPressed: () {
                _goToPage(
                  _currentIndex + 1,
                );
              },
            ),
          ),
        ],


        // ======================================================
        // INDICATORS
        // ======================================================

        if (widget.media.length > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: _buildIndicators(context),
          ),

        // ======================================================
        // MEDIA COUNT
        // ======================================================

        if (widget.media.length > 1)
          Positioned(
            left: 16,
            bottom: 16,
            child: _mediaCount(context),
          ),
      ],
    );
  }

  // ============================================================
  // MEDIA
  // ============================================================

  Widget _buildMedia(
      BuildContext context,
      PropertyMedia media,
      ) {
    switch (media.type) {
      case PropertyMediaType.image:
        return _buildImage(
          context,
          media.url,
        );

      case PropertyMediaType.video:
        return PropertyVideoCard(
          url: media.url,
        );
    }
  }

  // ============================================================
  // IMAGE
  // ============================================================

  Widget _buildImage(
      BuildContext context,
      String url,
      ) {
    final colors =
        Theme.of(context).colorScheme;

    return ImageView.networkCached(
      url,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorWidget: ColoredBox(
        color:
        colors.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 48,
            color:
            colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // INDICATORS
  // ============================================================

  Widget _buildIndicators(
      BuildContext context,
      ) {
    final colors =
        Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: List.generate(
        widget.media.length,
            (index) {
          final selected =
              index == _currentIndex;

          final isVideo =
              widget.media[index].type ==
                  PropertyMediaType.video;

          return AnimatedContainer(
            duration:
            const Duration(milliseconds: 200),
            margin:
            const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            width: selected ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: selected
                  ? colors.onPrimary
                  : colors.onPrimary.withValues(
                alpha: 0.5,
              ),
              borderRadius:
              BorderRadius.circular(999),
            ),
            child: isVideo && selected
                ? Icon(
              Icons.videocam,
              size: 7,
              color: colors.primary,
            )
                : null,
          );
        },
      ),
    );
  }

  // ============================================================
  // MEDIA COUNT
  // ============================================================

  Widget _mediaCount(
      BuildContext context,
      ) {
    final colors =
        Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.scrim.withValues(
          alpha: 0.55,
        ),
        borderRadius:
        BorderRadius.circular(999),
      ),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.media[_currentIndex]
                  .type ==
                  PropertyMediaType.video
                  ? Icons.videocam_outlined
                  : Icons.photo_library_outlined,
              size: 15,
              color: colors.onPrimary,
            ),

            const SizedBox(width: 5),

            Text(
              '${_currentIndex + 1}/${widget.media.length}',
              style:
              AppTextStyles.labelSmall.copyWith(
                color: colors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NAVIGATION BUTTON
  // ============================================================

  Widget _navigationButton(
      BuildContext context, {
        required IconData icon,
        required VoidCallback onPressed,
      }) {
    final colors =
        Theme.of(context).colorScheme;

    return Center(
      child: Material(
        color: colors.surface.withValues(
          alpha: 0.82,
        ),
        shape: const CircleBorder(),
        elevation: 2,
        child: InkWell(
          onTap: onPressed,
          customBorder:
          const CircleBorder(),
          child:   Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
             icon,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// VIDEO
// ============================================================

