import 'package:flutter/material.dart';
import 'package:homex/res/app_strings.dart';
import 'package:homex/ui/global.dart';

class AccountRestrictedScreen extends StatelessWidget {
  const AccountRestrictedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [

              const SizedBox(width: 8),
              Text(
                AppStrings.appName,
                style: textTheme.headlineMedium?.copyWith(
                 // color: colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            final horizontalPadding = isTablet ? 40.0 : 16.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                32,
                horizontalPadding,
                64,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 720,
                  ),
                  child: Column(
                    children: [
                      _buildWarningHeader(
                        context,
                        colors,
                        textTheme,
                      ),

                      const SizedBox(height: 24),

                      _buildRestrictionCard(
                        context,
                        colors,
                        textTheme,
                      ),

                      const SizedBox(height: 24),

                      _buildActions(
                        context,
                        colors,
                        textTheme,
                        isTablet,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWarningHeader(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      ) {
    var colors = context.colors;
    var textTheme = context.textTheme;
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: colors.errorContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.gpp_maybe_rounded,
            size: 40,
            color: colors.error,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Account Restricted',
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),

        const SizedBox(height: 8),

        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 560,
          ),
          child: Text(
            'Your access has been limited due to a policy violation. '
                'Please review the details below to understand the current '
                'status of your account.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestrictionCard(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      ) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // -----------------------------------------------------------------
          // REASON
          // -----------------------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.errorContainer.withValues(
                alpha: 0.20,
              ),
              border: Border(
                bottom: BorderSide(
                  color: colors.outlineVariant,
                ),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 430;

                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReasonContent(
                        colors,
                        textTheme,
                      ),
                      const SizedBox(height: 16),
                      _buildReference(
                        colors,
                        textTheme,
                      ),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildReasonContent(
                        colors,
                        textTheme,
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildReference(
                      colors,
                      textTheme,
                    ),
                  ],
                );
              },
            ),
          ),

          // -----------------------------------------------------------------
          // RESTRICTED ACTIONS
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Restricted Actions',
                  style: textTheme.labelLarge?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 16),

                _buildRestrictedAction(
                  context,
                  icon: Icons.block_rounded,
                  title: 'Cannot list new properties',
                  description:
                  'Creation of new portfolio assets is suspended.',
                  colors: colors,
                  textTheme: textTheme,
                ),

                const SizedBox(height: 16),

                _buildRestrictedAction(
                  context,
                  icon: Icons.money_off_rounded,
                  title: 'Withdrawals disabled',
                  description:
                  'Funds are currently locked pending resolution.',
                  colors: colors,
                  textTheme: textTheme,
                ),

                const SizedBox(height: 16),

                _buildRestrictedAction(
                  context,
                  icon: Icons.gavel_rounded,
                  title: 'Bidding privileges suspended',
                  description:
                  'You cannot participate in active auctions.',
                  colors: colors,
                  textTheme: textTheme,
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // INFORMATION
          // -----------------------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: colors.onSurfaceVariant,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    'This restriction is temporary. Submitting an appeal '
                        'will initiate a review by our compliance team within '
                        '24-48 hours.',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.onSurfaceVariant,
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

  Widget _buildReasonContent(
      dynamic colors,
      dynamic textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REASON FOR RESTRICTION',
          style: textTheme.labelSmall?.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
        ),

        const SizedBox(height: 6),

        Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 20,
              color: colors.error,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                'Unresolved Dispute',
                style: textTheme.titleMedium?.copyWith(
                  color: colors.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReference(
      dynamic colors,
      dynamic textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: colors.error.withValues(
            alpha: 0.20,
          ),
        ),
      ),
      child: Text(
        'Ref: #HX-8892-A',
        style: textTheme.labelSmall?.copyWith(
          color: colors.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRestrictedAction(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required dynamic colors,
        required dynamic textTheme,
      }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16,
            color: colors.outline,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                description,
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActions(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      bool isTablet,
      ) {
    if (isTablet) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStartAppealButton(
            context,
            colors,
            textTheme,
          ),

          const SizedBox(width: 12),

          _buildSupportButton(
            context,
            colors,
            textTheme,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildStartAppealButton(
          context,
          colors,
          textTheme,
        ),

        const SizedBox(height: 12),

        _buildSupportButton(
          context,
          colors,
          textTheme,
        ),
      ],
    );
  }

  Widget _buildStartAppealButton(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      ) {
    return SizedBox(
      height: 52,
      child: FilledButton.icon(
        onPressed: () {
          AppNavigator.pushAndStackNamed(
            AppRoutes.appealRestrictionScreen,
          );
        },
        icon: const Icon(
          Icons.assignment_turned_in_rounded,
          size: 19,
        ),
        label: const Text(
          'Start Appeal',
        ),
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          side: BorderSide(color: context.colors.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSupportButton(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      ) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: () {
          // TODO: Navigate to Contact Support screen.
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.onSurface,
          backgroundColor: colors.surfaceContainerLowest,
          side: BorderSide(
            color: colors.outlineVariant,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Text(
          'Contact Support',
        ),
      ),
    );
  }
}