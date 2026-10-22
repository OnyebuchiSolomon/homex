import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class _EscrowProperty {
  final String title;
  final String location;
  final String amount;
  final String status;
  final Color statusBg;
  final Color statusFg;
  final String imageUrl;

  const _EscrowProperty({
    required this.title,
    required this.location,
    required this.amount,
    required this.status,
    required this.statusBg,
    required this.statusFg,
    required this.imageUrl,
  });
}

class _ActivityItem {
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String text;
  final String boldPart;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.text,
    required this.boldPart,
    required this.time,
  });
}

class EscrowDashboardScreen extends StatelessWidget {
  const EscrowDashboardScreen({super.key});

  static const List<_EscrowProperty> _properties = [
    _EscrowProperty(
      title: 'The Ikoyi Pearl',
      location: 'Lekki Phase 1, Lagos',
      amount: '85,000,000',
      status: 'Funded',
      statusBg: AppColors.tertiaryFixedDim,
      statusFg: AppColors.tertiaryContainer,
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAyrVbwfWd5x5cvyLvF1V7g7Wl1TyKTZeetbbHTRFeydKc6KtnbQUj4QR3wSrQ3F_zKVDyYd0fMDMbx2P_5NgwoP_R9OEX9GITAjpp4NOOh2yAwNtJVRhZfSIy8111Z5qnjkKpBu_pISWHLcwdTFlOE4uPAR1vlgnXO2yAH-W7t4ds0PpW5lYhBuiVgKUszr6sNLEjcKCfmDpfP5ynoBkXHjeRwmXOeutSE4F8gbRBvhgBYyxJ6D7bM',
    ),
    _EscrowProperty(
      title: 'Asokoro Heights',
      location: 'Asokoro, Abuja',
      amount: '45,500,000',
      status: 'In Review',
      statusBg: AppColors.lightSurfaceVariant,
      statusFg: AppColors.lightTextSecondary,
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAXuGtEaKg7cnqzZGeet1yOwkhvyR-t9Rb9Q-dTzEARFq49sBrFUb_Q067brYIWXQ6gtBfbYnlvVBRIL9CDQjZfnH2gnDfirJK08Mcxl6pcK32aSQxmNmPlP9CtwH2qbPk-7BWdKOR_qsVKHXB6LXWeEID9jaZXoqffenL_uXn8H3vgtUtFXCDwRkmgiRkiGXZ_mC34cQKFo4tllkyU01GCXZA44i5YOahsCEA0Kdhw_wlAO4LJYMzG',
    ),
    _EscrowProperty(
      title: 'Riverside Duplex',
      location: 'GRA Phase 2, PH',
      amount: '15,000,000',
      status: 'Pending',
      statusBg: AppColors.secondaryFixed,
      statusFg: AppColors.onSecondaryFixed,
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAhXlNe2dW91dRon2W0SeefcRmjquXUuiPjJJQo3ISAx-NhPgu1SHnl7qDFvAJXDNu2bWto401dpyJg72Pxtv0FpuHLZHeMIBxREK605L4WKEoHqcWJG7W3SsUmibVCiWyXiEfDttGiSO9idy5elmm_-cxMdp5LRfiquQb87G4RbUifaPeYtYWSX7Ggd-KQKwhYN6ezvwUavO9AJwSS7bvKVccB0UQCjUUKCJX7JwQy6R_C2M5ozXWp',
    ),
  ];

  static const List<_ActivityItem> _activity = [
    _ActivityItem(
      icon: Icons.check_circle,
      iconBg: AppColors.tertiaryFixedDim,
      iconFg: AppColors.tertiaryContainer,
      text: 'Escrow Funded for ',
      boldPart: 'The Ikoyi Pearl',
      time: 'Today, 10:45 AM',
    ),
    _ActivityItem(
      icon: Icons.description,
      iconBg: AppColors.lightSurfaceVariant,
      iconFg: AppColors.lightTextSecondary,
      text: 'Documents uploaded for ',
      boldPart: 'Asokoro Heights',
      time: 'Yesterday, 14:20 PM',
    ),
    _ActivityItem(
      icon: Icons.schedule,
      iconBg: AppColors.secondaryFixedDim,
      iconFg: AppColors.onSecondaryFixedVariant,
      text: 'Escrow initiated for ',
      boldPart: 'Riverside Duplex',
      time: 'Oct 12, 09:15 AM',
    ),
  ];

  // Responsive helpers -----------------------------------------------------
  // Keeps the layout comfortable from small phones (~320dp wide) up to
  // large phones (~430dp+) without any fixed value causing overflow.

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  double _gap(BuildContext context, double base) {
    final w = context.widthPx;
    final scale = (w / 375).clamp(0.85, 1.1);
    return base * scale;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final hPad = _hPad(context);

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: _gap(context, 24)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeIn(child: _buildPageHeader(context)),
                SizedBox(height: _gap(context, 24)),
                SlideFadeIn(child: _buildTotalFundsCard(context)),
                SizedBox(height: _gap(context, 16)),
                SlideFadeIn(
                  delay: AppAnimations.shortDelay,
                  child: _buildActivePropertiesCard(context),
                ),
                SizedBox(height: _gap(context, 24)),
                _buildPropertiesSectionHeader(context),
                SizedBox(height: _gap(context, 16)),
                ..._properties.map(
                      (p) => Padding(
                    padding: EdgeInsets.only(bottom: _gap(context, 16)),
                    child: ScrollReveal(child: _buildPropertyTile(context, p)),
                  ),
                ),
                SizedBox(height: _gap(context, 8)),
                Text('Recent Activity', style: textTheme.headlineSmall),
                SizedBox(height: _gap(context, 16)),
                _buildRecentActivityCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // PAGE HEADER
  // ---------------------------------------------------------------------
  Widget _buildPageHeader(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Escrow Overview', style: textTheme.headlineMedium),
        const SizedBox(height: 4),
        Text(
          'Manage and track your active real estate transactions.',
          style: textTheme.bodyMedium?.copyWith(color: AppColors.lightTextSecondary),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // TOTAL FUNDS CARD
  // ---------------------------------------------------------------------
  Widget _buildTotalFundsCard(BuildContext context) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
       // color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color:color.outlineVariant ),
      ),
      padding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Opacity(
              opacity: 0.05,
              child: Icon(Icons.account_balance, size: 160, color: context.colors.onSurface),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL FUNDS IN ESCROW',
                style: textTheme.labelMedium?.copyWith(
                 // color: AppColors.lightTextSecondary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              // FittedBox guarantees this never overflows, no matter
              // how narrow the device is.
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('₦', style: textTheme.bodyMedium),
                    const SizedBox(width: 4),
                    Text(
                      '145,500,000',
                      style: textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ScaleOnTap(
                    onTap: () => AppNavigator.pushAndStackNamed(AppRoutes.fundEscrowScreen),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: context.colors.primary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_circle, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Fund Escrow',
                            style: textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ScaleOnTap(
                    onTap: () => AppNavigator.pushAndStackNamed(AppRoutes.escrowStatementScreen),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: color.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: color.outlineVariant),
                      ),
                      child: Text(
                        'View Statement',
                        style: textTheme.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // ACTIVE PROPERTIES CARD
  // ---------------------------------------------------------------------
  Widget _buildActivePropertiesCard(BuildContext context) {
    final textTheme = context.textTheme;
    final isNarrow = context.widthPx < 360;
final color = context.colors;
    return CustomCard(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: isNarrow ? 16 : 20),
      child: Column(
        children: [
          Container(
            width: isNarrow ? 52 : 60,
            height: isNarrow ? 52 : 60,
            decoration:   BoxDecoration(color: color.primaryFixed, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(Icons.home_work, size: isNarrow ? 20 : 24, color: color.onPrimaryFixed),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('3', style: textTheme.displayLarge),
          ),
          const SizedBox(height: 4),
          Text(
            'Active Properties',
            style: textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // PROPERTIES SECTION HEADER
  // ---------------------------------------------------------------------
  Widget _buildPropertiesSectionHeader(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Properties in Escrow',
            style: textTheme.headlineSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        ScaleOnTap(
          onTap: () {},
          child: Text(
            'View All',
            style: textTheme.labelMedium?.copyWith(
             // color: context.colors.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // PROPERTY TILE
  // ---------------------------------------------------------------------
  Widget _buildPropertyTile(BuildContext context, _EscrowProperty property) {
    final textTheme = context.textTheme;
    final isNarrow = context.widthPx < 360;
    final imageSize = isNarrow ? 56.0 : 64.0;
    final color = context.colors;
    return ScaleOnTap(
      onTap: () => AppNavigator.pushAndStackNamed(AppRoutes.activeEscrowTrackerScreen),
      child: Container(
        decoration: BoxDecoration(
          color: color.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.outlineVariant),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: imageSize,
                height: imageSize,
                child: ImageView.networkCached(
                  property.imageUrl,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  errorWidget: Container(
                    color: color.surfaceContainer,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      //color: AppColors.lightTextSecondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    property.title,
                    style: textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    property.location,
                    style: textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('₦', style: textTheme.labelSmall),
                      const SizedBox(width: 2),
                      Text(
                        property.amount,
                        style: textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: property.statusBg,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    property.status,
                    style: textTheme.labelSmall?.copyWith(color: property.statusFg),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // RECENT ACTIVITY CARD
  // ---------------------------------------------------------------------
  Widget _buildRecentActivityCard(BuildContext context) {
    final color = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.outlineVariant),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          for (int i = 0; i < _activity.length; i++) ...[
            _buildActivityRow(context, _activity[i]),
            if (i != _activity.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildActivityRow(BuildContext context, _ActivityItem item) {
    final textTheme = context.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(color: item.iconBg, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Icon(item.icon, size: 16, color: item.iconFg),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  children: [
                    TextSpan(text: item.text),
                    TextSpan(text: item.boldPart, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.time,
                style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}