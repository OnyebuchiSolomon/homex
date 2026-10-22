 import 'package:homex/ui/global.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
    this.onBack,
    this.onMarkAllAsRead,
    this.onViewEscrow,
    this.onDownloadReceipt,
    this.onReviewOffer,
    this.onDeclineOffer,
    this.onViewCredential,
    this.onNotificationPreferences,
    this.onNavigationChanged,
  });

  final VoidCallback? onBack;
  final VoidCallback? onMarkAllAsRead;
  final VoidCallback? onViewEscrow;
  final VoidCallback? onDownloadReceipt;
  final VoidCallback? onReviewOffer;
  final VoidCallback? onDeclineOffer;
  final VoidCallback? onViewCredential;
  final VoidCallback? onNotificationPreferences;
  final ValueChanged<int>? onNavigationChanged;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'all';
  int _selectedNavigation = 2;

  final List<_NotificationFilter> _filters = const [
    _NotificationFilter(
      id: 'all',
      label: 'All',
      count: 4,
    ),
    _NotificationFilter(
      id: 'escrow',
      label: 'Escrow & Payouts',
      count: 2,
    ),
    _NotificationFilter(
      id: 'deals',
      label: 'Deals & Offers',
      count: 1,
    ),
    _NotificationFilter(
      id: 'security',
      label: 'Security & KYC',
      count: 1,
    ),
    _NotificationFilter(
      id: 'system',
      label: 'System',
    ),
  ];

  void _selectFilter(String id) {
    setState(() {
      _selectedFilter = id;
    });
  }

  void _selectNavigation(int index) {
    setState(() {
      _selectedNavigation = index;
    });

    widget.onNavigationChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(
              colors,
              textTheme,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  112,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 576,
                    ),
                    child: Column(
                      children: [
                        _buildFilterChips(
                          colors,
                          textTheme,
                        ),
                        const SizedBox(height: 12),
                        _buildTodaySection(
                          colors,
                          textTheme,
                        ),
                        const SizedBox(height: 24),
                        _buildYesterdaySection(
                          colors,
                          textTheme,
                        ),
                        const SizedBox(height: 24),
                        _buildPreferencesCard(
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
        ),
      ),

    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Material(
      color: colors.surfaceContainerLowest,
      elevation: 1,
      shadowColor: colors.shadow.withValues(alpha: 0.08),
      child: SizedBox(
        height: 64,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1200,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _HeaderIconButton(

                    icon: Icons.arrow_back,
                    onTap: ()=>AppNavigator.pop(),
                    colors: colors,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Notifications',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge?.copyWith(
                       // color: colors.primary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Material(
                      color: colors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(999),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: widget.onMarkAllAsRead,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          child: Text(
                            'Mark all as read',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FILTER CHIPS
  // ============================================================

  Widget _buildFilterChips(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 2),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter.id == _selectedFilter;

          return _FilterChip(
            label: filter.label,
            count: filter.count,
            selected: isSelected,
            colors: colors,
            textTheme: textTheme,
            onTap: () => _selectFilter(filter.id),
          );
        },
      ),
    );
  }

  // ============================================================
  // TODAY
  // ============================================================

  Widget _buildTodaySection(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: 'Today',
          trailing: _buildUnreadBadge(
            colors,
            textTheme,
            '2 unread',
          ),
        ),
        const SizedBox(height: 12),

        _NotificationCard(
          colors: colors,
          textTheme: textTheme,
          icon: Icons.account_balance,
          iconBackground: colors.tertiaryFixed,
          iconColor: colors.onTertiaryFixed,
          title: 'Escrow Milestone 2 Funded',
          timestamp: '10 mins ago',
          unread: true,
          description: _buildRichDescription(
            textTheme,
            colors,
            [
              const _DescriptionPart(
                text:
                'Chief T. Adeleke has deposited ',
              ),
              _DescriptionPart(
                text: '₦15,000,000',
                bold: true,
              ),
              const _DescriptionPart(
                text:
                ' for Lekki Duplex Phase 1 into Stanbic IBTC Escrow Vault.',
              ),
            ],
          ),
          actions: [
            _CardAction(
              label: 'View Escrow',
              filled: true,
              onTap: widget.onViewEscrow,
            ),
            _CardAction(
              label: 'Download Receipt',
              icon: Icons.download,
              onTap: widget.onDownloadReceipt,
            ),
          ],
        ),

        const SizedBox(height: 12),

        _NotificationCard(
          colors: colors,
          textTheme: textTheme,
          icon: Icons.handshake,
          iconBackground: colors.primaryFixed,
          iconColor: colors.onPrimaryFixed,
          title: 'New Offer Received — ₦115,000,000',
          timestamp: '1 hour ago',
          unread: true,
          description: _buildRichDescription(
            textTheme,
            colors,
            [
              const _DescriptionPart(
                text:
                'Adeola Balogun submitted an outright purchase offer with verified proof of funds for Lekki Duplex.',
              ),
            ],
          ),
          actions: [
            _CardAction(
              label: 'Review Offer',
              filled: true,
              onTap: ()=>AppNavigator.pushAndStackNamed(AppRoutes.offerReviewScreen)//widget.onReviewOffer,
            ),
            _CardAction(
              label: 'Decline',
              destructive: true,
              onTap: widget.onDeclineOffer,
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // YESTERDAY
  // ============================================================

  Widget _buildYesterdaySection(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: 'Yesterday',
          trailing: Text(
            'Archive',
            style: textTheme.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 12),

        _NotificationCard(
          colors: colors,
          textTheme: textTheme,
          read: true,
          icon: Icons.verified_user,
          iconBackground: colors.secondaryFixed,
          iconColor: colors.secondary,
          title: 'Tier 3 Institutional Verification Approved',
          timestamp: '16:40 WAT',
          description: _buildRichDescription(
            textTheme,
            colors,
            [
              const _DescriptionPart(
                text:
                'Your NIBSS & CAC documents have passed audit. Transacting limit upgraded to ',
              ),
              _DescriptionPart(
                text: '₦450,000,000',
                bold: true,
              ),
              const _DescriptionPart(
                text: '.',
              ),
            ],
          ),
          bottomChild: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: widget.onViewCredential,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      'View Credential Certificate',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: colors.secondary,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        _NotificationCard(
          colors: colors,
          textTheme: textTheme,
          read: true,
          icon: Icons.home_work,
          iconBackground: colors.surfaceContainerHigh,
          iconColor: colors.onSurfaceVariant,
          title: 'Direct Deal Listing Live',
          timestamp: '11:15 WAT',
          description: _buildRichDescription(
            textTheme,
            colors,
            [
              const _DescriptionPart(
                text:
                'Contemporary 4-Bed Smart Detached Duplex in Lekki Phase 1 is now active on the public market.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _buildSectionHeader({
    required String title,
    required Widget trailing,
  }) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: colors.outline,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: trailing,
          ),
        ],
      ),
    );
  }

  Widget _buildUnreadBadge(
      ColorScheme colors,
      TextTheme textTheme,
      String text,
      ) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 100,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: colors.tertiaryFixed,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.labelSmall?.copyWith(
          color: colors.onTertiaryFixedVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ============================================================
  // PREFERENCES
  // ============================================================

  Widget _buildPreferencesCard(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Material(
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: widget.onNotificationPreferences,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.outlineVariant.withValues(
                alpha: 0.4,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.tune,
                  size: 18,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification Preferences',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Manage push alerts & email digests',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: colors.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }


  // ============================================================
  // RICH DESCRIPTION
  // ============================================================

  Widget _buildRichDescription(
      TextTheme textTheme,
      ColorScheme colors,
      List<_DescriptionPart> parts,
      ) {
    return RichText(
      text: TextSpan(
        style: textTheme.bodySmall?.copyWith(
          color: colors.onSurfaceVariant,
          height: 1.55,
          fontWeight: FontWeight.w400,
        ),
        children: [
          for (final part in parts)
            TextSpan(
              text: part.text,
              style: part.bold
                  ? textTheme.bodySmall?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
                height: 1.55,
              )
                  : null,
            ),
        ],
      ),
    );
  }
}

// ================================================================
// NOTIFICATION CARD
// ================================================================

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.colors,
    required this.textTheme,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.timestamp,
    required this.description,
    this.unread = false,
    this.read = false,
    this.actions,
    this.bottomChild,
  });

  final ColorScheme colors;
  final TextTheme textTheme;

  final IconData icon;
  final Color iconBackground;
  final Color iconColor;

  final String title;
  final String timestamp;

  final Widget description;

  final bool unread;
  final bool read;

  final List<_CardAction>? actions;
  final Widget? bottomChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: read
            ? colors.surfaceContainerLowest.withValues(
          alpha: 0.80,
        )
            : colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(
            alpha: read ? 0.30 : 0.40,
          ),
        ),
        boxShadow: read
            ? null
            : [
          BoxShadow(
            color: colors.shadow.withValues(
              alpha: 0.05,
            ),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NotificationIcon(
            icon: icon,
            backgroundColor: iconBackground,
            iconColor: iconColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NotificationTitleRow(
                  title: title,
                  timestamp: timestamp,
                  unread: unread,
                  colors: colors,
                  textTheme: textTheme,
                ),
                const SizedBox(height: 6),
                description,
                if (actions != null && actions!.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  _buildActions(),
                ],
                if (bottomChild != null) ...[
                  const SizedBox(height: 10),
                  bottomChild!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: actions!
          .map(
            (action) => _NotificationActionButton(
          action: action,
          colors: colors,
          textTheme: textTheme,
        ),
      )
          .toList(),
    );
  }
}

// ================================================================
// NOTIFICATION TITLE
// ================================================================

class _NotificationTitleRow extends StatelessWidget {
  const _NotificationTitleRow({
    required this.title,
    required this.timestamp,
    required this.unread,
    required this.colors,
    required this.textTheme,
  });

  final String title;
  final String timestamp;
  final bool unread;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 280;

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              _Timestamp(
                timestamp: timestamp,
                unread: unread,
                colors: colors,
                textTheme: textTheme,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _Timestamp(
              timestamp: timestamp,
              unread: unread,
              colors: colors,
              textTheme: textTheme,
            ),
          ],
        );
      },
    );
  }
}

// ================================================================
// TIMESTAMP
// ================================================================

class _Timestamp extends StatelessWidget {
  const _Timestamp({
    required this.timestamp,
    required this.unread,
    required this.colors,
    required this.textTheme,
  });

  final String timestamp;
  final bool unread;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    if (!unread) {
      return Text(
        timestamp,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.labelSmall?.copyWith(
          color: colors.outline,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: colors.tertiaryContainer,
            shape: BoxShape.circle,
            border: Border.all(
              color: colors.tertiaryFixedDim,
              width: 2,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          timestamp,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.labelSmall?.copyWith(
            color: colors.outline,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ================================================================
// NOTIFICATION ICON
// ================================================================

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 22,
       // color: iconColor,
      ),
    );
  }
}

// ================================================================
// FILTER CHIP
// ================================================================

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.colors,
    required this.textTheme,
    required this.onTap,
    this.count,
  });

  final String label;
  final bool selected;
  final int? count;

  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final background = selected
        ? colors.primary
        : colors.surfaceContainerLowest;

    final foreground = selected
        ? colors.onPrimary
        : colors.onSurfaceVariant;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 7,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall?.copyWith(
                  color: foreground,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w500,
                ),
              ),
              if (count != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? colors.surfaceContainerHighest
                        : colors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$count',
                    style: textTheme.labelSmall?.copyWith(
                      color: selected
                          ? colors.primary
                          : colors.onSurfaceVariant,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// CARD ACTION
// ================================================================

class _NotificationActionButton extends StatelessWidget {
  const _NotificationActionButton({
    required this.action,
    required this.colors,
    required this.textTheme,
  });

  final _CardAction action;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final background = action.filled
        ? colors.primary
        : action.destructive
        ? colors.surfaceContainerLow
        : colors.surfaceContainerLow;

    final foreground = action.filled
        ? colors.onPrimary
        : action.destructive
        ? colors.error
        : colors.onSurfaceVariant;

    final borderColor = action.filled
        ? Colors.transparent
        : action.destructive
        ? colors.errorContainer
        : colors.outlineVariant.withValues(
      alpha: 0.60,
    );

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: action.onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 34,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderColor,
            ),
            boxShadow: action.filled
                ? [
              BoxShadow(
                color: colors.shadow.withValues(
                  alpha: 0.06,
                ),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (action.icon != null) ...[
                Icon(
                  action.icon,
                  size: 15,
                  color: foreground,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                action.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// BOTTOM NAV ITEM
// ================================================================

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.item,
    required this.selected,
    required this.colors,
    required this.textTheme,
    required this.onTap,
  });

  final _NavigationItem item;
  final bool selected;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? colors.onPrimaryContainer
        : colors.onSurfaceVariant;

    return Material(
      color: selected
          ? colors.primaryContainer
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                selected ? item.activeIcon : item.icon,
                size: 20,
                color: foreground,
              ),
              const SizedBox(height: 2),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// HEADER ICON BUTTON
// ================================================================

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.colors,
    this.onTap,
  });

  final IconData icon;
  final ColorScheme colors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            size: 24,
           // color: colors.primary,
          ),
        ),
      ),
    );
  }
}

// ================================================================
// MODELS
// ================================================================

class _NotificationFilter {
  const _NotificationFilter({
    required this.id,
    required this.label,
    this.count,
  });

  final String id;
  final String label;
  final int? count;
}

class _CardAction {
  const _CardAction({
    required this.label,
    this.icon,
    this.filled = false,
    this.destructive = false,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool filled;
  final bool destructive;
  final VoidCallback? onTap;
}

class _DescriptionPart {
  const _DescriptionPart({
    required this.text,
    this.bold = false,
  });

  final String text;
  final bool bold;
}

class _NavigationItem {
  const _NavigationItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}