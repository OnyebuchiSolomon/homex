import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class OwnerDashboardPage extends StatefulWidget {
  const OwnerDashboardPage({super.key});

  @override
  State<OwnerDashboardPage> createState() => _OwnerDashboardPageState();
}

class _OwnerDashboardPageState extends State<OwnerDashboardPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _pageAnimationController;

  @override
  void initState() {
    super.initState();

    _pageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _pageAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageAnimationController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildTopBar(context),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                16,
                24,
                16,
                32,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1280,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        _buildAnimatedEntrance(
                          index: 0,
                          child: _buildIntro(context),
                        ),

                        const SizedBox(height: 32),

                        _buildDashboard(context),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ANIMATION SYSTEM
  // ============================================================

  Widget _buildAnimatedEntrance({
    required int index,
    required Widget child,
  }) {
    final start = (index * 0.10).clamp(0.0, 0.7);
    final end = (start + 0.35).clamp(0.0, 1.0);

    final animation = CurvedAnimation(
      parent: _pageAnimationController,
      curve: Interval(
        start,
        end,
        curve: Curves.easeOutCubic,
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final value = animation.value;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              0,
              24 * (1 - value),
            ),
            child: Transform.scale(
              scale: 0.96 + (value * 0.04),
              child: child,
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  SliverAppBar _buildTopBar(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: true,
      elevation: 2,
      scrolledUnderElevation: 0,
      backgroundColor:
      colors.surface.withValues(alpha: 0.94),
      surfaceTintColor: colors.surface,
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      titleSpacing: 0,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1280,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      clipBehavior:
                      Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                        colors.surfaceContainerHighest,
                        border: Border.all(
                          color:
                          colors.outlineVariant,
                        ),
                      ),
                      child:
                      ImageView.networkCached(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuB99FzcvxCi8r5GP1secMTN8o9s9tiTzphNx2RP-V7rAqnlB8csqpM7SHJG4qVpaxU1ZnjpJrOv0i6hgB6ARE0sZRn8A4X5susU2g8aMGWitGbgAgn4cV-Mz_kWQag_sfhvGn7IktnpMdbY-c8Iv7MnUxlABohGlr-MQEDXzhLeeEKYSAYuiiEJttYye0iK8PmQ39g-F4wFbKP1DrQGtyTuWCFjnzpCFz_1tOYPPw48ll5WjWvio5Z1',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorWidget: Icon(
                          Icons.person,
                          color:
                          colors.onSurfaceVariant,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Text(
                      'HomeX',
                      style:
                      AppTextStyles.headlineMedium
                          .copyWith(
                        color: colors.primary,
                        fontWeight:
                        FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                IconButton(
                  tooltip: 'Notifications',
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_outlined,
                    color:
                    colors.onSurfaceVariant,
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
  // INTRO
  // ============================================================

  Widget _buildIntro(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Owner Dashboard',
          style:
          AppTextStyles.displayLargeMobile.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Manage your portfolio and track requests.',
          style:
          AppTextStyles.bodyLarge.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DASHBOARD
  // ============================================================

  Widget _buildDashboard(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 600) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              _buildStats(context),

              const SizedBox(height: 24),

              _buildRequests(context),

              const SizedBox(height: 32),

              _buildProperties(context),
            ],
          );
        }

        return Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: _buildStats(context),
                ),

                const SizedBox(width: 24),

                Expanded(
                  flex: 8,
                  child: _buildRequests(context),
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildProperties(context),
          ],
        );
      },
    );
  }

  // ============================================================
  // STATISTICS
  // ============================================================

  Widget _buildStats(BuildContext context) {
    final colors =
        Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.stretch,
      children: [
        _ScrollReveal(
          controller: _scrollController,
          delay: const Duration(milliseconds: 0),
          child: _statCard(
            context,
            title: 'My Properties',
            value: '4',
            icon: Icons.home_work,
            iconColor: colors.primary,
            iconBackground:
            colors.primaryFixed.withValues(
              alpha: 0.20,
            ),
          ),
        ),

        const SizedBox(height: 8),

        _ScrollReveal(
          controller: _scrollController,
          delay: const Duration(milliseconds: 100),
          child: _statCard(
            context,
            title: 'Active Listings',
            value: '2',
            icon: Icons.visibility,
            iconColor:
            colors.onTertiaryContainer,
            iconBackground:
            colors.tertiaryFixed.withValues(
              alpha: 0.30,
            ),
          ),
        ),

        const SizedBox(height: 8),

        _ScrollReveal(
          controller: _scrollController,
          delay: const Duration(milliseconds: 200),
          child: _statCard(
            context,
            title: 'New Requests',
            value: '3',
            icon: Icons.mail,
            iconColor: colors.secondary,
            iconBackground:
            colors.secondaryContainer
                .withValues(alpha: 0.20),
          ),
        ),
      ],
    );
  }

  Widget _statCard(
      BuildContext context, {
        required String title,
        required String value,
        required IconData icon,
        required Color iconColor,
        required Color iconBackground,
      }) {
    final colors =
        Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
        colors.surfaceContainerLowest,
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color:
          colors.outlineVariant.withValues(
            alpha: 0.30,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                  AppTextStyles.labelMedium
                      .copyWith(
                    color:
                    colors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 4),

                TweenAnimationBuilder<double>(
                  tween:
                  Tween(begin: 0, end: double.parse(value)),
                  duration:
                  const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder:
                      (context, animatedValue, child) {
                    return Text(
                      animatedValue
                          .round()
                          .toString(),
                      style:
                      AppTextStyles.headlineMedium
                          .copyWith(
                        color: colors.primary,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          TweenAnimationBuilder<double>(
            tween:   Tween(
              begin: 0.0,
              end: 1.0,
            ),
            duration:
            const Duration(milliseconds: 700),
            curve: Curves.elasticOut,
            builder:
                (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACTIVE REQUESTS
  // ============================================================

  Widget _buildRequests(BuildContext context) {
    final colors =
        Theme.of(context).colorScheme;

    return _ScrollReveal(
      controller: _scrollController,
      delay:
      const Duration(milliseconds: 150),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            'Active Requests',
            style:
            AppTextStyles.headlineSmall
                .copyWith(
              color: colors.primary,
            ),
          ),

          const SizedBox(height: 16),

          _requestCard(context),
        ],
      ),
    );
  }

  Widget _requestCard(BuildContext context) {
    return CustomCard(
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 12,
      ),
      child: LayoutBuilder(
        builder:
            (context, constraints) {
          final compact =
              constraints.maxWidth < 520;

          if (compact) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              children: [
                _requestInformation(
                  context,
                ),

                const SizedBox(height: 16),

                _requestActions(context),
              ],
            );
          }

          return Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              Expanded(
                child:
                _requestInformation(
                  context,
                ),
              ),

              const SizedBox(width: 16),

              _requestActions(context),
            ],
          );
        },
      ),
    );
  }

  Widget _requestInformation(
      BuildContext context) {
    final colors =
        Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        TweenAnimationBuilder<double>(
          tween:
          Tween(begin: 0.0, end: 1.0),
          duration:
          const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          builder:
              (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: Container(
            width: 56,
            height: 56,
            clipBehavior:
            Clip.antiAlias,
            decoration:
            const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child:
            ImageView.networkCached(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCgh2dKNshrN0BofQO2UV6MoB7ULNZPy7GC-aKjnHYNFwQdWP1_h4tn_TSFvmiwXmgmvrIXoe-9HZRpQvtNj4kJhhJV9TB6C5j9-H_0j3dklm9dG2upj9Bp9fZ7yGErgRBzYCC_pyh4Vy8T-2a64dJ5ezqxUVoKQXyx4PvSDzFX6CIeiZOkn65YtI-I-0HTsoikg_o0I6oRNppbcnoC_Z3Q9EXAPuhxpz-9ifnSAExzU1rYV0EuuONL',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorWidget:
              Icon(
                Icons.person,
                color:
                colors.onSurfaceVariant,
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'Michael wants to inspect Lekki Duplex',
                style:
                AppTextStyles.bodyMedium
                    .copyWith(
                  color: colors.primary,
                  fontWeight:
                  FontWeight.w500,
                ),
              ),

              const SizedBox(height: 6),

              Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment:
                WrapCrossAlignment.center,
                children: [
                  _verifiedBadge(
                    context,
                  ),

                  Text(
                    'Trust Score: 92/100',
                    style:
                    AppTextStyles
                        .labelMedium
                        .copyWith(
                      color: colors
                          .onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _requestActions(
      BuildContext context) {
    final colors =
        Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: OutlinedButton(
              onPressed: () {},
              style:
              OutlinedButton.styleFrom(
                foregroundColor:
                colors.primary,
                side: BorderSide(
                  color:
                  colors.outlineVariant,
                ),
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              child:
              const Text('Decline'),
            ),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: SizedBox(
            height: 40,
            child: FilledButton(
              onPressed: () {},
              style:
              FilledButton.styleFrom(
                backgroundColor:
                colors.primary,
                foregroundColor:
                colors.onPrimary,
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              child: const Text(
                'Accept Request',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _verifiedBadge(
      BuildContext context) {
    final colors =
        Theme.of(context).colorScheme;

    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color:
        const Color(0xFF166534)
            .withValues(alpha: 0.10),
        borderRadius:
        BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified,
            size: 14,
            color: Color(0xFF166534),
          ),

          const SizedBox(width: 4),

          Text(
            'Verified',
            style:
            AppTextStyles.labelSmall
                .copyWith(
              color:
              const Color(0xFF166534),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MANAGE PROPERTIES
  // ============================================================

  Widget _buildProperties(
      BuildContext context) {
    final colors =
        Theme.of(context).colorScheme;

    return _ScrollReveal(
      controller: _scrollController,
      delay:
      const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder:
                (context, constraints) {
              final mobile =
                  constraints.maxWidth < 500;

              if (mobile) {
                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manage My Properties',
                      style: AppTextStyles
                          .headlineSmall
                          .copyWith(
                        color:
                        colors.primary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Align(
                      alignment:
                      Alignment.centerRight,
                      child:
                      FilledButton.icon(
                        onPressed: () =>
                            AppNavigator
                                .pushAndStackNamed(
                              AppRoutes
                                  .propertyTypePage,
                            ),
                        style:
                        FilledButton
                            .styleFrom(
                          backgroundColor:
                          colors.primary,
                          foregroundColor:
                          colors
                              .onPrimary,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                              12,
                            ),
                          ),
                        ),
                        icon:
                        const Icon(
                          Icons.add,
                        ),
                        label:
                        const Text(
                          'Add Tenant',
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Manage My Properties',
                      style: AppTextStyles
                          .headlineSmall
                          .copyWith(
                        color:
                        colors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  FilledButton.icon(
                    onPressed: () =>
                        AppNavigator
                            .pushAndStackNamed(
                          AppRoutes
                              .propertyTypePage,
                        ),
                    style:
                    FilledButton
                        .styleFrom(
                      backgroundColor:
                      colors.primary,
                      foregroundColor:
                      colors.onPrimary,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius
                            .circular(
                          12,
                        ),
                      ),
                    ),
                    icon:
                    const Icon(
                      Icons.add,
                    ),
                    label:
                    const Text(
                      'Add Tenant',
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 16),

          _propertyGrid(context),
        ],
      ),
    );
  }

  // ============================================================
  // PROPERTY GRID
  // ============================================================

  Widget _propertyGrid(
      BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) {
        final width =
            constraints.maxWidth;

        int columns;

        if (width >= 900) {
          columns = 3;
        } else if (width >= 600) {
          columns = 2;
        } else {
          columns = 1;
        }

        const spacing = 12.0;

        final cardWidth =
            (width -
                (spacing *
                    (columns - 1))) /
                columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            SizedBox(
              width: cardWidth,
              child: _ScrollReveal(
                controller:
                _scrollController,
                delay:
                const Duration(
                  milliseconds: 0,
                ),
                child: _propertyCard(
                  context,
                  title:
                  'Lekki Duplex Phase 1',
                  location:
                  'Lekki, Lagos',
                  price: '₦120M',
                  status: 'Occupied',
                  occupied: true,
                  image:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuD-D2V1jG9FlxqOenj-1U0mKvAlVYFZyUlEkEo-uE4cptWhjiazye23sddXKVHHsBFM69pWAEM9Bx3m9kFQgXakuUZvgW-HIHZWSAsuD5RkavLad2_u2Fkn4A5bXDAkmoJoc5RMw4YVOPAmvvDp-cXPsmhztCQ3Mmzm3N-O9fPPJfX4WNymSP8y46hq1wzzTDij5Gb2G1ykvwlnCpFnFuL4P_YrOe_Olk0-nQpy0FhcFbadJk1Z2WaP',
                ),
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: _ScrollReveal(
                controller:
                _scrollController,
                delay:
                const Duration(
                  milliseconds: 120,
                ),
                child: _propertyCard(
                  context,
                  title:
                  'VI Studio Apartment',
                  location:
                  'Victoria Island, Lagos',
                  price: '₦45M',
                  status: 'Vacant',
                  occupied: false,
                  image:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDkXBSJ6-QVcJ9e2Az4KnZYz-jAttjSzvfep1lLCnAUHUi0tCTGW1OJWaqso5oU8ie5_iVTVEsQMtDo_VrowZQYyUq39TZ7mHtQ9iK7LIDs_1nQjuewW7PATY7438PAX5gbG5rUhZWfDD97_NQSeEQI6fP9ev-LCd-4L3G3KyiDvJ-v5c2q28Z0RWzjAOBBuyEsOpvFlxfc4wnI4Mp886Ss-w9H3NJDGdmtCpxjt6CK6s6amfpSFq5m',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // PROPERTY CARD
  // ============================================================

  Widget _propertyCard(
      BuildContext context, {
        required String title,
        required String location,
        required String price,
        required String status,
        required bool occupied,
        required String image,
      }) {
    final colors =
        Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius:
      BorderRadius.circular(12),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(12),
        onTap: () {},
        child: Container(
          clipBehavior:
          Clip.antiAlias,
          decoration: BoxDecoration(
            color:
            colors.surfaceContainerLowest,
            borderRadius:
            BorderRadius.circular(12),
            border: Border.all(
              color: colors.outlineVariant
                  .withValues(alpha: 0.30),
            ),
            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withValues(
                  alpha: 0.05,
                ),
                blurRadius: 6,
                offset:
                const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ImageView
                        .networkCached(
                      image,
                      width:
                      double.infinity,
                      height:
                      double.infinity,
                      fit: BoxFit.cover,
                      errorWidget:
                      ColoredBox(
                        color:
                        colors
                            .surfaceContainer,
                        child: Icon(
                          Icons
                              .home_work_outlined,
                          size: 56,
                          color: colors
                              .onSurfaceVariant,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 8,
                      right: 8,
                      child:
                      _animatedBadge(
                        context,
                        child:
                        Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration:
                          BoxDecoration(
                            color:
                            colors
                                .secondary,
                            borderRadius:
                            BorderRadius
                                .circular(
                              6,
                            ),
                          ),
                          child: Text(
                            'Verified',
                            style: AppTextStyles
                                .labelSmall
                                .copyWith(
                              color: colors
                                  .onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 8,
                      left: 8,
                      child:
                      _animatedBadge(
                        context,
                        child:
                        Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration:
                          BoxDecoration(
                            color: colors
                                .surfaceContainerLowest
                                .withValues(
                              alpha: 0.90,
                            ),
                            borderRadius:
                            BorderRadius
                                .circular(
                              6,
                            ),
                          ),
                          child: Text(
                            price,
                            style: AppTextStyles
                                .headlineSmall
                                .copyWith(
                              color:
                              colors
                                  .primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow:
                      TextOverflow
                          .ellipsis,
                      style: AppTextStyles
                          .bodyMedium
                          .copyWith(
                        color:
                        colors.primary,
                        fontWeight:
                        FontWeight.w500,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: colors
                              .onSurfaceVariant,
                        ),

                        const SizedBox(
                          width: 4,
                        ),

                        Expanded(
                          child: Text(
                            location,
                            maxLines: 1,
                            overflow:
                            TextOverflow
                                .ellipsis,
                            style:
                            AppTextStyles
                                .labelMedium
                                .copyWith(
                              color: colors
                                  .onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Divider(
                      height: 1,
                      color: colors
                          .outlineVariant
                          .withValues(
                        alpha: 0.30,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Text(
                          'Status',
                          style:
                          AppTextStyles
                              .labelSmall
                              .copyWith(
                            color: colors
                                .onSurfaceVariant,
                          ),
                        ),

                        _statusBadge(
                          context,
                          status: status,
                          occupied:
                          occupied,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ANIMATED BADGE
  // ============================================================

  Widget _animatedBadge(
      BuildContext context, {
        required Widget child,
      }) {
    return TweenAnimationBuilder<double>(
      tween:  Tween(
        begin: 0,
        end: 1,
      ),
      duration:
      const Duration(milliseconds: 650),
      curve: Curves.easeOutBack,
      builder:
          (context, value, child) {
        return Opacity(
          opacity: value.clamp(0, 1),
          child: Transform.scale(
            scale: 0.75 +
                (value * 0.25),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // ============================================================
  // STATUS BADGE
  // ============================================================

  Widget _statusBadge(
      BuildContext context, {
        required String status,
        required bool occupied,
      }) {
    final colors =
        Theme.of(context).colorScheme;

    final background = occupied
        ? const Color(0xFF166534)
        .withValues(alpha: 0.10)
        : colors.surfaceContainerHigh;

    final foreground = occupied
        ? const Color(0xFF166534)
        : colors.onSurfaceVariant;

    return AnimatedContainer(
      duration:
      const Duration(milliseconds: 300),
      padding:
      const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius:
        BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style:
        AppTextStyles.labelSmall.copyWith(
          color: foreground,
        ),
      ),
    );
  }
}

// ============================================================================
// SCROLL REVEAL
// ============================================================================

class _ScrollReveal extends StatefulWidget {
  const _ScrollReveal({
    required this.child,
    required this.controller,
    this.delay = Duration.zero,
  });

  final Widget child;
  final ScrollController controller;
  final Duration delay;

  @override
  State<_ScrollReveal> createState() =>
      _ScrollRevealState();
}

class _ScrollRevealState
    extends State<_ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController
  _animationController;

  late final Animation<double>
  _opacityAnimation;

  late final Animation<double>
  _slideAnimation;

  late final Animation<double>
  _scaleAnimation;

  bool _isVisible = false;
  bool _checking = false;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(
          vsync: this,
          duration:
          const Duration(milliseconds: 650),
        );

    _opacityAnimation =
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutCubic,
        );

    _slideAnimation = Tween<double>(
      begin: 35,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.94,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    widget.controller.addListener(
      _onScroll,
    );

    WidgetsBinding.instance
        .addPostFrameCallback(
          (_) => _checkVisibility(),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(
      _onScroll,
    );

    _animationController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (_checking) return;

    _checking = true;

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      _checking = false;

      if (mounted) {
        _checkVisibility();
      }
    });
  }

  void _checkVisibility() {
    if (!mounted) return;

    final renderObject =
    context.findRenderObject();

    if (renderObject is! RenderBox) {
      return;
    }

    if (!renderObject.hasSize) {
      return;
    }

    final position =
    renderObject.localToGlobal(
      Offset.zero,
    );

    final size =
        renderObject.size;

    final screenHeight =
        MediaQuery.of(context).size.height;

    final top = position.dy;
    final bottom =
        position.dy + size.height;

    const visibilityPadding = 100.0;

    final visible = bottom >
        -visibilityPadding &&
        top <
            screenHeight +
                visibilityPadding;

    if (visible != _isVisible) {
      _isVisible = visible;

      if (visible) {
        Future.delayed(
          widget.delay,
              () {
            if (mounted &&
                _isVisible) {
              _animationController
                  .forward();
            }
          },
        );
      } else {
        _animationController
            .reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
      _animationController,
      child: widget.child,
      builder:
          (context, child) {
        return Opacity(
          opacity:
          _opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(
              0,
              _slideAnimation.value,
            ),
            child: Transform.scale(
              scale:
              _scaleAnimation.value,
              child: child,
            ),
          ),
        );
      },
    );
  }
}