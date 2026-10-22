import 'package:flutter/material.dart';
 import 'package:homex/ui/global.dart';


class ProfileScreen extends StatefulWidget {
  final bool isProfile;
  const ProfileScreen({super.key, this.isProfile = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedNavigation = 4;

  final String profileImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e'
      '?auto=format&fit=crop&w=500&q=80';

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final bool isMobile = width < 600;
            final bool isTablet = width >= 600 && width < 1000;
            final bool isDesktop = width >= 1000;

            return Column(
              children: [
                if (!isMobile)
                  _buildDesktopHeader(
                    context,
                    colors,
                    textTheme,
                  ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: isMobile
                          ? 16
                          : isTablet
                          ? 24
                          : 32,
                      right: isMobile
                          ? 16
                          : isTablet
                          ? 24
                          : 32,
                      top: isMobile ? 16 : 32,
                      bottom: isMobile ? 110 : 32,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 1280,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isMobile&&!widget.isProfile)
                              _buildMobileBackButton(
                                context,
                                colors,
                                textTheme,
                              ),

                            _buildProfileHeader(
                              context,
                              colors,
                              textTheme,
                              isMobile,
                            ),

                            const SizedBox(height: 24),

                            _buildTrustSection(
                              context,
                              colors,
                              textTheme,
                              isMobile,
                              isDesktop,
                            ),

                            const SizedBox(height: 24),

                            _buildReviews(
                              context,
                              colors,
                              textTheme,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),

    );
  }

  // ============================================================
  // DESKTOP HEADER
  // ============================================================

  Widget _buildDesktopHeader(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      ) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.96),
        boxShadow: [
          BoxShadow(
            color: colors.onSurface.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'HomeX',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.primary,
            ),
          ),

          const Spacer(),

          _buildDesktopNavItem(
            context,
            'Home',
            Icons.home_outlined,
            0,
            colors,
            textTheme,
          ),

          _buildDesktopNavItem(
            context,
            'Explore',
            Icons.search_rounded,
            1,
            colors,
            textTheme,
          ),

          _buildDesktopNavItem(
            context,
            'Requests',
            Icons.description_outlined,
            2,
            colors,
            textTheme,
          ),

          _buildDesktopNavItem(
            context,
            'Wallet',
            Icons.account_balance_wallet_outlined,
            3,
            colors,
            textTheme,
          ),

          _buildDesktopNavItem(
            context,
            'Profile',
            Icons.person_rounded,
            4,
            colors,
            textTheme,
          ),

          const SizedBox(width: 16),

          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_rounded,
              color: colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(width: 8),

          _buildAvatar(
            width: 38,
            height: 38,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavItem(
      BuildContext context,
      String title,
      IconData icon,
      int index,
      dynamic colors,
      dynamic textTheme,
      ) {
    final selected = _selectedNavigation == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TextButton.icon(
        onPressed: () {
          setState(() {
            _selectedNavigation = index;
          });
        },
        icon: Icon(
          icon,
          size: 20,
        ),
        label: Text(title),
        style: TextButton.styleFrom(
          foregroundColor: selected
              ? colors.primary
              : colors.onSurfaceVariant,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE BACK BUTTON
  // ============================================================

  Widget _buildMobileBackButton(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 6,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  size: 21,
                  color: colors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Back to Profile',
                  style: textTheme.labelLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
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
  // PROFILE HEADER
  // ============================================================

  Widget _buildProfileHeader(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.onSurface.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: isMobile
          ? _buildMobileProfileHeader(
        colors,
        textTheme,
      )
          : _buildDesktopProfileHeader(
        colors,
        textTheme,
      ),
    );
  }

  Widget _buildMobileProfileHeader(
      dynamic colors,
      dynamic textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLargeAvatar(
          size: 104,
          colors: colors,
        ),

        const SizedBox(height: 18),

        Text(
          'John Okafor',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: colors.onSurface,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          'Verified Real Estate Agent & Property Manager',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 18),

        _buildVerificationBadges(
          colors,
          textTheme,
        ),
      ],
    );
  }

  Widget _buildDesktopProfileHeader(
      dynamic colors,
      dynamic textTheme,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLargeAvatar(
          size: 128,
          colors: colors,
        ),

        const SizedBox(width: 28),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Okafor',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.onSurface,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Verified Real Estate Agent & Property Manager',
                style: textTheme.bodyLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 18),

              _buildVerificationBadges(
                colors,
                textTheme,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROFILE AVATAR
  // ============================================================

  Widget _buildLargeAvatar({
    required double size,
    required dynamic colors,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.surfaceContainerLowest,
            border: Border.all(
              color: colors.surfaceContainerLowest,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.onSurface.withValues(alpha: 0.10),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipOval(
            child: ImageView.networkCached(
              profileImage,
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          right: 0,
          bottom: 3,
          child: Container(
            width: 31,
            height: 31,
            decoration: BoxDecoration(
              color: const Color(0xFF166534),
              shape: BoxShape.circle,
              border: Border.all(
                color: colors.surfaceContainerLowest,
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.verified_rounded,
              color: Colors.white,
              size: 17,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar({
    required double width,
    required double height,
  }) {
    return ClipOval(
      child: ImageView.networkCached(
        profileImage,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  // ============================================================
  // VERIFICATION BADGES
  // ============================================================

  Widget _buildVerificationBadges(
      dynamic colors,
      dynamic textTheme,
      ) {
    final badges = [
      _VerificationBadge(
        icon: Icons.badge_outlined,
        title: 'ID Verified',
      ),
      _VerificationBadge(
        icon: Icons.phone_iphone_rounded,
        title: 'Phone Verified',
      ),
      _VerificationBadge(
        icon: Icons.location_on_outlined,
        title: 'Location Verified',
      ),
      _VerificationBadge(
        icon: Icons.verified_user_rounded,
        title: 'NIN Linked',
        green: true,
      ),
    ];

    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: badges.map((badge) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: badge.green
                ? const Color(0xFF166534).withValues(alpha: 0.08)
                : colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: badge.green
                  ? const Color(0xFF166534).withValues(alpha: 0.20)
                  : colors.outlineVariant,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                badge.icon,
                size: 16,
                color: badge.green
                    ? const Color(0xFF166534)
                    : colors.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                badge.title,
                style: textTheme.labelMedium?.copyWith(
                  color: badge.green
                      ? const Color(0xFF166534)
                      : colors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ============================================================
  // TRUST SECTION
  // ============================================================

  Widget _buildTrustSection(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      bool isMobile,
      bool isDesktop,
      ) {
    if (isMobile) {
      return Column(
        children: [
          _buildTrustScore(
            colors,
            textTheme,
          ),

          const SizedBox(height: 16),

          _buildScoreBreakdown(
            colors,
            textTheme,
          ),

          const SizedBox(height: 16),

          _buildTrackRecord(
            colors,
            textTheme,
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: isDesktop ? 360 : 300,
          child: _buildTrustScore(
            colors,
            textTheme,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: Column(
            children: [
              Expanded(
                child: _buildScoreBreakdown(
                  colors,
                  textTheme,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: _buildTrackRecord(
                  colors,
                  textTheme,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TRUST SCORE
  // ============================================================

  Widget _buildTrustScore(
      dynamic colors,
      dynamic textTheme,
      ) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 340,
      ),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.onSurface.withValues(alpha: 0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Trust Score',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: 170,
            height: 170,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 170,
                  height: 170,
                  child: CircularProgressIndicator(
                    value: 0.96,
                    strokeWidth: 9,
                    backgroundColor: colors.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colors.secondaryContainer,
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '4.8',
                      style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.onSurface,
                      ),
                    ),
                    Text(
                      'Out of 5',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Text(
            'Excellent',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.secondaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SCORE BREAKDOWN
  // ============================================================

  Widget _buildScoreBreakdown(
      dynamic colors,
      dynamic textTheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.onSurface.withValues(alpha: 0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Score Breakdown',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 22),

          _buildScoreRow(
            title: 'Communication',
            score: 5.0,
            progress: 1.0,
            colors: colors,
            textTheme: textTheme,
          ),

          const SizedBox(height: 20),

          _buildScoreRow(
            title: 'Property Accuracy',
            score: 5.0,
            progress: 1.0,
            colors: colors,
            textTheme: textTheme,
          ),

          const SizedBox(height: 20),

          _buildScoreRow(
            title: 'Payment Reliability',
            score: 4.9,
            progress: 0.98,
            colors: colors,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreRow({
    required String title,
    required double score,
    required double progress,
    required dynamic colors,
    required dynamic textTheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: textTheme.labelLarge?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Text(
              score.toStringAsFixed(1),
              style: textTheme.labelLarge?.copyWith(
                color: colors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(width: 4),

            Icon(
              Icons.star_rounded,
              size: 16,
              color: colors.secondaryContainer,
            ),
          ],
        ),

        const SizedBox(height: 7),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 9,
            backgroundColor:
            const Color(0xFF166534).withValues(alpha: 0.10),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF166534),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TRACK RECORD
  // ============================================================

  Widget _buildTrackRecord(
      dynamic colors,
      dynamic textTheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.onSurface.withValues(alpha: 0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTrackItem(
            icon: Icons.handshake_rounded,
            value: '48',
            label: 'Successful Transactions',
            iconBackground: colors.primaryFixed.withValues(alpha: 0.35),
            iconColor: colors.primary,
            colors: colors,
            textTheme: textTheme,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Divider(
              color: colors.outlineVariant,
              height: 1,
            ),
          ),

          _buildTrackItem(
            icon: Icons.verified_user_rounded,
            value: '0',
            label: 'Unresolved Complaints',
            iconBackground:
            const Color(0xFF166534).withValues(alpha: 0.10),
            iconColor: const Color(0xFF166534),
            colors: colors,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildTrackItem({
    required IconData icon,
    required String value,
    required String label,
    required Color iconBackground,
    required Color iconColor,
    required dynamic colors,
    required dynamic textTheme,
  }) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 27,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.onSurface,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                label,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // REVIEWS
  // ============================================================

  Widget _buildReviews(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.onSurface.withValues(alpha: 0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Recent Reviews',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: textTheme.labelLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          ReviewCard(
            initials: 'AO',
            name: 'Amina O.',
            role: 'Buyer',
            date: 'Oct 12, 2023',
            rating: 5,
            review:
            'John was incredibly transparent throughout the entire purchasing process. The property matched the description perfectly, and he facilitated a smooth handover. Highly recommended for first-time buyers.',

          ),

          Divider(
            color: colors.outlineVariant,
            height: 32,
          ),

          ReviewCard(
            initials: 'CE',
            name: 'Chinedu E.',
            role: 'Tenant',
            date: 'Sep 28, 2023',
            rating: 4.5,
            review:
            'Very professional and responsive. There was a minor delay with the paperwork, but his communication was excellent, keeping me updated every step of the way.',

          ),
        ],
      ),
    );
  }




  // ============================================================
  // MOBILE BOTTOM NAVIGATION
  // ============================================================

}

// ============================================================
// VERIFICATION BADGE MODEL
// ============================================================

class _VerificationBadge {
  final IconData icon;
  final String title;
  final bool green;

  const _VerificationBadge({
    required this.icon,
    required this.title,
    this.green = false,
  });
}

// ============================================================
// NAVIGATION MODEL
// ============================================================

