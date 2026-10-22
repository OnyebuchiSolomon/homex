import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class ListingPreviewPage extends StatefulWidget {
  const ListingPreviewPage({
    super.key,
    this.propertyTitle = 'Luxury 4-Bedroom Semi-Detached Duplex',
    this.location = 'Lekki Phase 1, Lagos',
    this.price = '₦45,000,000',
    this.beds = 4,
    this.baths = 4,
    this.parking = 2,
    this.sqm = 450,
    this.photoCount = 1,
    this.totalPhotos = 12,
    this.description =
    'Experience unparalleled luxury in this stunning 4-bedroom '
        'semi-detached duplex located in the heart of Lekki Phase 1. '
        'Designed with modern aesthetics, it features an open-plan living '
        'area, fully fitted smart kitchen, en-suite bedrooms with walk-in '
        'closets, and a private swimming pool. The property offers 24/7 '
        'security, ample parking, and easy access to major commercial hubs.',
    this.propertyImageUrl,
    this.ownerName = 'John Okafor',
    this.ownerImageUrl,
  });

  final String propertyTitle;
  final String location;
  final String price;

  final int beds;
  final int baths;
  final int parking;
  final int sqm;

  final int photoCount;
  final int totalPhotos;

  final String description;

  final String? propertyImageUrl;

  final String ownerName;
  final String? ownerImageUrl;

  @override
  State<ListingPreviewPage> createState() => _ListingPreviewPageState();
}

class _ListingPreviewPageState extends State<ListingPreviewPage> {
  bool isFavorite = false;
  bool showFullDescription = false;
  bool isPublishing = false;

  ColorScheme get colors => Theme.of(context).colorScheme;
  TextTheme get textTheme => Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                FadeIn(
                  duration: AppAnimations.normal,
                  child: _buildProgressBar(context),
                ),
SizedBox(height: 40,),
                SlideFadeIn(
                  direction: SlideDirection.top,
                  duration: AppAnimations.normal,
                  child: _buildAppBar(context),
                ),

                Expanded(
                  child: _buildMainContent(context),
                ),
              ],
            ),

            _buildBottomActionBar(context),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PROGRESS BAR
  // ===========================================================================

  Widget _buildProgressBar(BuildContext context) {
    return SizedBox(
      height: 6,
      width: double.infinity,
      child: ColoredBox(
        color: colors.surfaceContainerHighest,
        child: Align(
          alignment: Alignment.centerLeft,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0,
              end: 1,
            ),
            duration: AppAnimations.medium,
            curve: AppAnimations.enter,
            builder: (context, value, child) {
              return FractionallySizedBox(
                widthFactor: value,
                child: child,
              );
            },
            child: ColoredBox(
              color: colors.primary,
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // APP BAR
  // ===========================================================================

  Widget _buildAppBar(BuildContext context) {
    return Container(
     // height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.92),
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.30),
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1280,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                ScaleOnTap(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: _circleIconButton(
                    context,
                    icon: Icons.arrow_back,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),

                const Spacer(),

                FadeScaleIn(
                  delay: AppAnimations.shortDelay,
                  duration: AppAnimations.normal,
                  child: Text(
                    'Listing Preview',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.primary,
                    ),
                  ),
                ),

                const Spacer(),

                const SizedBox(
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // MAIN CONTENT
  // ===========================================================================

  Widget _buildMainContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 900;
        final bool isTablet = constraints.maxWidth >= 600;

        final double horizontalPadding = isDesktop
            ? 24
            : isTablet
            ? 24
            : 16;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            24,
            horizontalPadding,
            150,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 672,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FadeIn(
                    duration: AppAnimations.normal,
                    child: _buildPreviewBanner(context),
                  ),

                  const SizedBox(height: 24),

                  FadeScaleIn(
                    delay: AppAnimations.shortDelay,
                    duration: AppAnimations.medium,
                    child: _buildMainPropertyImage(context),
                  ),

                  const SizedBox(height: 24),

                  SlideFadeIn(
                    direction: SlideDirection.bottom,
                    delay: AppAnimations.mediumDelay,
                    duration: AppAnimations.normal,
                    child: _buildCoreDetailsCard(context),
                  ),



                  _buildFeaturesGrid(context),

                  const SizedBox(height: 24),

                  SlideFadeIn(
                    direction: SlideDirection.bottom,
                    delay: AppAnimations.longDelay,
                    duration: AppAnimations.normal,
                    child: _buildDescriptionCard(context),
                  ),

                  const SizedBox(height: 24),

                  SlideFadeIn(
                    direction: SlideDirection.bottom,
                    delay: const Duration(milliseconds: 500),
                    duration: AppAnimations.normal,
                    child: _buildOwnerCard(context),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // PREVIEW BANNER
  // ===========================================================================

  Widget _buildPreviewBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.secondaryContainer.withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeScaleIn(
            delay: AppAnimations.shortDelay,
            beginScale: 0.85,
            child: Icon(
              Icons.visibility_outlined,
              color: colors.secondary,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideFadeIn(
                  direction: SlideDirection.right,
                  delay: AppAnimations.shortDelay,
                  child: Text(
                    'Preview Mode',
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                FadeIn(
                  delay: AppAnimations.mediumDelay,
                  child: Text(
                    'This is exactly how buyers will see your listing. '
                        'Review details before publishing.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontSize: 14,
                      height: 1.45,
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

  // ===========================================================================
  // MAIN PROPERTY IMAGE
  // ===========================================================================

  Widget _buildMainPropertyImage(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildPropertyImage(context),

            IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      colors.primaryContainer.withValues(alpha: 0.82),
                    ],
                    stops: const [
                      0.45,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 16,
              right: 16,
              child: FadeScaleIn(
                delay: const Duration(milliseconds: 300),
                beginScale: 0.85,
                child: _buildVerifiedBadge(context),
              ),
            ),

            Positioned(
              left: 16,
              bottom: 16,
              child: SlideFadeIn(
                direction: SlideDirection.bottom,
                delay: const Duration(milliseconds: 400),
                child: _buildPhotoCounter(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyImage(BuildContext context) {
    const String fallbackImage =
        'https://lh3.googleusercontent.com/aida-public/'
        'AB6AXuBez5KNda9vrLV1Nowzq6FYPa3ZEPfP4QXr2MgDbq-JAtvtoVJol-'
        'Dziiahw5BtSUbBANekKrnuheCdxNy7T96l0gzj1fNZ4IqpqrZo3JC7dpnTytx'
        'P7VDZP7Ag0tXKc2ztAZOOBgnYppgjprF6pn1SA8uzUbf-F7_Bamfvpn0oZB'
        'PPvXvyJmm0kghes0FPscHeatFI5NFHKvlPu_DiA7acuTyAqEkTDAgFH8dly'
        'aja-DGbiSZ1Iy6t';

    final imageUrl = widget.propertyImageUrl ?? fallbackImage;

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: colors.surfaceContainer,
          child: Center(
            child: Icon(
              Icons.home_outlined,
              size: 72,
              color: colors.onSurfaceVariant,
            ),
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return FadeIn(
            duration: AppAnimations.medium,
            child: child,
          );
        }

        return Container(
          color: colors.surfaceContainer,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.primary,
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // VERIFIED BADGE
  // ===========================================================================

  Widget _buildVerifiedBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            size: 17,
            color: colors.onSecondary,
          ),
          const SizedBox(width: 5),
          Text(
            'Verified',
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PHOTO COUNTER
  // ===========================================================================

  Widget _buildPhotoCounter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 17,
            color: colors.onSurfaceVariant,
          ),
          const SizedBox(width: 5),
          Text(
            '${widget.photoCount}/${widget.totalPhotos} Photos',
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // CORE DETAILS CARD
  // ===========================================================================

  Widget _buildCoreDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(context),
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
                    FadeIn(
                      child: Text(
                        widget.propertyTitle,
                        style: textTheme.headlineSmall?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w500,
                          height: 1.25,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    SlideFadeIn(
                      direction: SlideDirection.right,
                      delay: AppAnimations.shortDelay,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.location,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              ScaleOnTap(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child: _circleIconButton(
                  context,
                  icon: isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  backgroundColor: colors.surfaceContainerLow,
                  iconColor: isFavorite
                      ? colors.error
                      : colors.onSurfaceVariant,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Divider(
            height: 1,
            color: colors.outlineVariant.withValues(alpha: 0.20),
          ),

          const SizedBox(height: 16),

          FadeScaleIn(
            delay: AppAnimations.mediumDelay,
            beginScale: 0.97,
            child: Text(
              widget.price,
              style: textTheme.displaySmall?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w500,
                letterSpacing: -1,
              ),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'ASKING PRICE',
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FEATURES GRID
  // ===========================================================================

  Widget _buildFeaturesGrid(BuildContext context) {
    final features = [
      (
      icon: Icons.bed_outlined,
      value: '${widget.beds}',
      label: 'Beds',
      ),
      (
      icon: Icons.shower_outlined,
      value: '${widget.baths}',
      label: 'Baths',
      ),
      (
      icon: Icons.directions_car_outlined,
      value: '${widget.parking}',
      label: 'Parking',
      ),
      (
      icon: Icons.square_foot_outlined,
      value: '${widget.sqm}',
      label: 'Sqm',
      ),
    ];

    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.95,
      children: List.generate(
        features.length,
            (index) {
          final feature = features[index];

          return SlideFadeIn(
            direction: SlideDirection.bottom,
            delay: Duration(
              milliseconds: 250 + (index * 80),
            ),
            duration: AppAnimations.normal,
            child: ScaleOnTap(
              child: _featureCard(
                context,
                icon: feature.icon,
                value: feature.value,
                label: feature.label,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _featureCard(
      BuildContext context, {
        required IconData icon,
        required String value,
        required String label,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8,),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: colors.onSurfaceVariant,
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DESCRIPTION
  // ===========================================================================

  Widget _buildDescriptionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About this property',
            style: textTheme.titleLarge?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          AnimatedSize(
            duration: AppAnimations.normal,
            curve: AppAnimations.smooth,
            alignment: Alignment.topCenter,
            child: Text(
              widget.description,
              maxLines: showFullDescription ? null : 4,
              overflow: showFullDescription
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 8),

          ScaleOnTap(
            onTap: () {
              setState(() {
                showFullDescription = !showFullDescription;
              });
            },
            child: Text(
              showFullDescription
                  ? 'Show less'
                  : 'Read full description',
              style: textTheme.labelLarge?.copyWith(
                color: colors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // OWNER PROFILE
  // ===========================================================================

  Widget _buildOwnerCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(context),
      child: Row(
        children: [
          FadeScaleIn(
            beginScale: 0.85,
            child: _buildOwnerAvatar(context),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeIn(
                  delay: AppAnimations.shortDelay,
                  child: Text(
                    widget.ownerName,
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                SlideFadeIn(
                  direction: SlideDirection.right,
                  delay: AppAnimations.mediumDelay,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: colors.secondaryContainer,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Excellent Reputation',
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          ScaleOnTap(
            onTap: _openChat,
            child: Material(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: _openChat,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.chat_outlined,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerAvatar(BuildContext context) {
    const String fallbackOwnerImage =
        'https://lh3.googleusercontent.com/aida-public/'
        'AB6AXuAziyxPPrIqWJAx5ouOKAPVy1ZjmR-ud-fg7I2eEiUA6mcW0KOG14m'
        'EGKjIdCKqRBLZwzZhZgD8lutTPvu_FDNWEnMLZcsIZebQx5htAcj0aItdG8Kp'
        'Z-bO8yOZoTcru4-qgCGy4Qr2ufzCm9jM7hAemN3tkgoJ12xIc4AH23bNrxQm'
        'cbr86FsohBaTp1uB6pPYKnyRS0x0_RCEfNesK3HrDF52Aqa3lNnkADZ7nWF'
        'CMh1sX3DaSq8';

    final imageUrl = widget.ownerImageUrl ?? fallbackOwnerImage;

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.surface,
          width: 2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return ColoredBox(
            color: colors.surfaceContainer,
            child: Icon(
              Icons.person_outline,
              color: colors.onSurfaceVariant,
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // BOTTOM ACTION BAR
  // ===========================================================================

  Widget _buildBottomActionBar(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SlideFadeIn(
        direction: SlideDirection.bottom,
        delay: const Duration(milliseconds: 600),
        duration: AppAnimations.medium,
        child: Material(
          color: colors.surface.withValues(alpha: 0.94),
          child: SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                24,
                16,
                24,
                16,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colors.outlineVariant.withValues(alpha: 0.20),
                  ),
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 672,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildEditButton(context),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        flex: 2,
                        child: _buildPublishButton(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // EDIT BUTTON
  // ===========================================================================

  Widget _buildEditButton(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ScaleOnTap(
        onTap: _editListing,
        child: OutlinedButton.icon(
          onPressed: _editListing,
          icon: const Icon(
            Icons.edit_outlined,
            size: 18,
          ),
          label: const Text(
            'Edit Listing',
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.primaryContainer,
            backgroundColor: colors.surfaceContainerLowest,
            side: BorderSide(
              color: colors.outlineVariant,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // PUBLISH BUTTON
  // ===========================================================================

  Widget _buildPublishButton(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ScaleOnTap(
        onTap: isPublishing ? null : _publishProperty,
        child: FilledButton.icon(
          onPressed: isPublishing ? null : _publishProperty,
          icon: AnimatedSwitcher(
            duration: AppAnimations.fast,
            transitionBuilder: (child, animation) {
              return FadeScaleIn(
                child: child,
              );
            },
            child: isPublishing
                ? SizedBox(
              key: const ValueKey('loading'),
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.onPrimary,
              ),
            )
                : const Icon(
              key: ValueKey('rocket'),
              Icons.rocket_launch_outlined,
              size: 20,
            ),
          ),
          label: AnimatedSwitcher(
            duration: AppAnimations.fast,
            child: Text(
              isPublishing
                  ? 'Publishing...'
                  : 'Publish Property',
              key: ValueKey(
                isPublishing,
              ),
            ),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: colors.primaryContainer,
            foregroundColor: colors.onPrimary,
            disabledBackgroundColor:
            colors.primaryContainer.withValues(alpha: 0.65),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // BUTTON HELPERS
  // ===========================================================================

  Widget _circleIconButton(
      BuildContext context, {
        required IconData icon,
        required VoidCallback onPressed,
        Color? backgroundColor,
        Color? iconColor,
      }) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            size: 24,
            color: iconColor ?? colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // CARD DECORATION
  // ===========================================================================

  BoxDecoration _cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: colors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: colors.outlineVariant.withValues(alpha: 0.30),
      ),
      boxShadow: [
        BoxShadow(
          color: colors.primaryContainer.withValues(alpha: 0.08),
          blurRadius: 40,
          spreadRadius: -10,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  // ===========================================================================
  // ACTIONS
  // ===========================================================================

  void _editListing() {
    Navigator.of(context).pop();
  }

  Future<void> _publishProperty() async {
    if (isPublishing) return;

    setState(() {
      isPublishing = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    setState(() {
      isPublishing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Property published successfully.',
        ),
        backgroundColor: colors.primaryContainer,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Chat with property owner',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}