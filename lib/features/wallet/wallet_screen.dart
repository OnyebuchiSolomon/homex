import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1280,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isDesktop = constraints.maxWidth >= 1024;

                      if (isDesktop) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.3333,
                              child: const _WalletOverview(),
                            ),
                            const SizedBox(width: 24),
                            const Expanded(
                              child: _TransactionSection(),
                            ),
                          ],
                        );
                      }

                      return const Column(
                        children: [
                          _WalletOverview(),
                          SizedBox(height: 24),
                          _TransactionSection(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* WALLET OVERVIEW                                                            */
/* -------------------------------------------------------------------------- */

class _WalletOverview extends StatelessWidget {
  const _WalletOverview();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _WalletCard(),
        SizedBox(height: 24),
        _QuickActions(),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* WALLET CARD                                                                */
/* -------------------------------------------------------------------------- */

class _WalletCard extends StatelessWidget {
  const _WalletCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return CustomCard(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'AVAILABLE BALANCE',
              style: textTheme.labelMedium?.copyWith(
                color: colors.onSurfaceVariant,
                letterSpacing: 1.8,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              '₦1,200,000,000',
              style: textTheme.displaySmall?.copyWith(
                //color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: colors.outlineVariant,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Pending (Escrow)',
                          style: textTheme.labelMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.lock,
                        //color: colors.tertiary,
                        size: 18,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '₦500,000',
                    style: textTheme.headlineSmall?.copyWith(
                      color: colors.onSurface,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colors.tertiaryContainer.withValues(
                           alpha: 0.25,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Protected',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.tertiary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Expanded(
                    child: _PrimaryButton(
                      icon: Icons.add,
                      label: 'Deposit',
                      onPressed: () {},
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _SecondaryButton(
                      icon: Icons.arrow_downward,
                      label: 'Withdraw',
                      onPressed: () {},
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
}

/* -------------------------------------------------------------------------- */
/* QUICK ACTIONS                                                              */
/* -------------------------------------------------------------------------- */

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return CustomCard(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Actions',
            style: textTheme.headlineSmall?.copyWith(
              color: colors.primary,
            ),
          ),

          const SizedBox(height: 8),

          _ActionTile(
            icon: Icons.history,
            title: 'View History',
            onTap: () {},
          ),

          _ActionTile(
            icon: Icons.description,
            title: 'Statements',
            onTap: () {},
          ),

          _ActionTile(
            icon: Icons.description,
            title: 'Escrow Dashboard',
            onTap: () {
              AppNavigator.pushAndStackNamed(
                AppRoutes.escrowDashboardScreen,
              );
            },
          ),

          _ActionTile(
            icon: Icons.error_outline,
            title: 'Dispute Center',
            onTap: () {
              AppNavigator.pushAndStackNamed(
                AppRoutes.disputeCenterPage,
              );
            },
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* TRANSACTION SECTION                                                        */
/* -------------------------------------------------------------------------- */

class _TransactionSection extends StatelessWidget {
  const _TransactionSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _EscrowTracker(),
        SizedBox(height: 24),
        _RecentTransactions(),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* ESCROW TRACKER                                                             */
/* -------------------------------------------------------------------------- */

class _EscrowTracker extends StatelessWidget {
  const _EscrowTracker();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Escrow Transaction',
                      style: textTheme.headlineSmall?.copyWith(
                        color: colors.primary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Property Purchase - Lekki Phase 1',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              Text(
                '₦500,000',
                style: textTheme.headlineSmall?.copyWith(
                  color: colors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const _EscrowTimeline(),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: colors.secondary,
                  size: 20,
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Action Required: Approve Inspection',
                        style: textTheme.labelMedium?.copyWith(
                          color: colors.onSurface,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Please verify the property condition to release funds to the seller.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
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
}

/* -------------------------------------------------------------------------- */
/* ESCROW TIMELINE                                                            */
/* -------------------------------------------------------------------------- */

class _EscrowTimeline extends StatelessWidget {
  const _EscrowTimeline();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final steps = [
      const _TimelineStepData(
        icon: Icons.check,
        label: 'Payment Received',
        completed: true,
      ),
      const _TimelineStepData(
        icon: Icons.lock,
        label: 'Funds Protected',
        completed: true,
      ),
      const _TimelineStepData(
        icon: Icons.visibility,
        label: 'Inspection Pending',
        current: true,
      ),
      const _TimelineStepData(
        icon: Icons.done_all,
        label: 'Completion',
      ),
    ];

    return SizedBox(
      height: 96,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final lineLeft = 20.0;
          final lineRight = 20.0;
          final lineWidth =
              constraints.maxWidth - lineLeft - lineRight;

          return Stack(
            children: [
              Positioned(
                left: lineLeft,
                right: lineRight,
                top: 16,
                child: Container(
                  height: 2,
                  color: colors.surfaceContainerHighest,
                ),
              ),

              Positioned(
                left: lineLeft,
                top: 16,
                width: lineWidth * 0.62,
                child: Container(
                  height: 2,
                  color: colors.tertiary,
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final step in steps)
                    Expanded(
                      child: _TimelineStep(
                        data: step,
                        textTheme: textTheme,
                        colors: colors,
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* TIMELINE STEP                                                              */
/* -------------------------------------------------------------------------- */

class _TimelineStep extends StatelessWidget {
  final _TimelineStepData data;
  final TextTheme textTheme;
  final ColorScheme colors;

  const _TimelineStep({
    required this.data,
    required this.textTheme,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    late final Color circleColor;
    late final Color iconColor;
    late final Color labelColor;

    if (data.completed) {
      circleColor = colors.tertiary;
      iconColor = colors.onTertiary;
      labelColor = colors.tertiary;
    } else if (data.current) {
      circleColor = colors.secondary;
      iconColor = colors.onSecondary;
      labelColor = colors.secondary;
    } else {
      circleColor = colors.surfaceContainerHighest;
      iconColor = colors.onSurfaceVariant;
      labelColor = colors.onSurfaceVariant;
    }

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor,
            border: Border.all(
              color: colors.surface,
              width: 4,
            ),
            boxShadow: data.current
                ? [
              BoxShadow(
                color: colors.secondary.withValues(
                  alpha: 0.2,
                ),
                blurRadius: 0,
                spreadRadius: 3,
              ),
            ]
                : null,
          ),
          child: Icon(
            data.icon,
            size: 14,
            color: iconColor,
          ),
        ),

        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            data.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: labelColor,
              fontWeight:
              data.current ? FontWeight.w700 : null,
            ),
          ),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* TIMELINE DATA                                                              */
/* -------------------------------------------------------------------------- */

class _TimelineStepData {
  final IconData icon;
  final String label;
  final bool completed;
  final bool current;

  const _TimelineStepData({
    required this.icon,
    required this.label,
    this.completed = false,
    this.current = false,
  });
}

/* -------------------------------------------------------------------------- */
/* RECENT TRANSACTIONS                                                        */
/* -------------------------------------------------------------------------- */

class _RecentTransactions extends StatelessWidget {
  const _RecentTransactions();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Recent Transactions',
                    style: textTheme.headlineSmall?.copyWith(
                     // color: colors.primary,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: colors.primary,
                  ),
                  child: Text(
                    'View All',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color: colors.surfaceContainerHighest,
          ),

          const _TransactionTile(
            icon: Icons.lock_clock,
            title: 'Escrow Deposit',
            subtitle: 'Lekki Phase 1 Purchase',
            amount: '-₦500,000',
            status: 'Pending',
            type: _TransactionType.pending,
          ),

          const _TransactionTile(
            icon: Icons.arrow_downward,
            title: 'Wallet Top-up',
            subtitle: 'Bank Transfer ****4932',
            amount: '+₦1,700,000',
            status: 'Completed',
            type: _TransactionType.completed,
          ),

          const _TransactionTile(
            icon: Icons.warning_amber_rounded,
            title: 'Inspection Fee',
            subtitle: 'Vendor Payment',
            amount: '-₦25,000',
            status: 'Disputed',
            type: _TransactionType.disputed,
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* TRANSACTION TYPE                                                           */
/* -------------------------------------------------------------------------- */

enum _TransactionType {
  pending,
  completed,
  disputed,
}

/* -------------------------------------------------------------------------- */
/* TRANSACTION TILE                                                           */
/* -------------------------------------------------------------------------- */

class _TransactionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final String status;
  final _TransactionType type;

  const _TransactionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    late final Color iconColor;
    late final Color iconBackground;
    late final Color statusColor;
    late final Color statusBackground;

    switch (type) {
      case _TransactionType.pending:
        iconColor = colors.secondary;
        iconBackground =
            colors.secondaryContainer.withValues(alpha: 0.12);
        statusColor = colors.secondary;
        statusBackground =
            colors.secondaryContainer.withValues(alpha: 0.12);
        break;

      case _TransactionType.completed:
        iconColor = colors.tertiary;
        iconBackground =
            colors.tertiaryContainer.withValues(alpha: 0.12);
        statusColor = colors.tertiary;
        statusBackground =
            colors.tertiaryContainer.withValues(alpha: 0.12);
        break;

      case _TransactionType.disputed:
        iconColor = colors.error;
        iconBackground =
            colors.errorContainer.withValues(alpha: 0.12);
        statusColor = colors.onErrorContainer;
        statusBackground = colors.errorContainer;
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppNavigator.pushAndStackNamed(
            AppRoutes.transactionDetailsScreen,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.onSurface,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: textTheme.labelMedium?.copyWith(
                      color:
                      type == _TransactionType.completed
                          ? colors.tertiary
                          : colors.onSurface,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusBackground,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: textTheme.labelSmall?.copyWith(
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* PRIMARY BUTTON                                                             */
/* -------------------------------------------------------------------------- */

class _PrimaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Material(
      color: Colors.transparent,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          side: BorderSide(
            color: colors.outlineVariant,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          tapTargetSize:
          MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: colors.onPrimary,
            ),

            const SizedBox(width: 8),

            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelMedium?.copyWith(
                  color: colors.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* SECONDARY BUTTON                                                           */
/* -------------------------------------------------------------------------- */

class _SecondaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SecondaryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Material(
      color: Colors.transparent,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: colors.surface,
          foregroundColor: colors.primary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          side: BorderSide(
            color: colors.outlineVariant,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          tapTargetSize:
          MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
             color: colors.onPrimary,
            ),

            const SizedBox(width: 8),

            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelMedium?.copyWith(
                  //color: colors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* ACTION TILE                                                                */
/* -------------------------------------------------------------------------- */

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  //color: colors.onPrimary,
                  size: 20,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                  ),
                ),
              ),

              Icon(
                Icons.chevron_right,
                color: colors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* AMBIENT CIRCLE                                                             */
/* -------------------------------------------------------------------------- */

class _AmbientCircle extends StatelessWidget {
  final Color color;

  const _AmbientCircle({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 128,
        height: 128,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}