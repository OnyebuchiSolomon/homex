import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class AppealSubmittedScreen extends StatelessWidget {
  const AppealSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: CustomCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: colors.primaryContainer.withValues(alpha: .2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        size: 40,
                        color: colors.primary,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Appeal Submitted Successfully',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'We have received your appeal and our team is currently '
                          'reviewing it. We appreciate your patience during this process.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 32),

                    _AppealStatusCard(
                      colors: colors,
                      textTheme: textTheme,
                    ),

                    const SizedBox(height: 32),

                    _ActionButtons(
                      colors: colors,
                      textTheme: textTheme,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppealStatusCard extends StatelessWidget {
  final dynamic colors;
  final TextTheme textTheme;

  const _AppealStatusCard({
    required this.colors,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appeal Status',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 24),

          _TimelineItem(
            title: 'Appeal Received',
            subtitle: 'Today, 10:42 AM',
            completed: true,
            current: false,
            colors: colors,
            textTheme: textTheme,
          ),

          _TimelineItem(
            title: 'Under Review',
            subtitle: 'Estimated response: 24–48 hours',
            completed: false,
            current: true,
            colors: colors,
            textTheme: textTheme,
          ),

          _TimelineItem(
            title: 'Decision Reached',
            subtitle: 'Pending',
            completed: false,
            current: false,
            colors: colors,
            textTheme: textTheme,
          ),

          const SizedBox(height: 8),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'You will receive an email notification once a decision '
                        'has been made.',
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
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
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool completed;
  final bool current;
  final dynamic colors;
  final TextTheme textTheme;

  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.completed,
    required this.current,
    required this.colors,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                _TimelineCircle(
                  completed: completed,
                  current: current,
                  colors: colors,
                ),

                if (!completed || current)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: colors.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.labelLarge?.copyWith(
                      color: completed || current
                          ? colors.onSurface
                          : colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
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
}

class _TimelineCircle extends StatelessWidget {
  final bool completed;
  final bool current;
  final dynamic colors;

  const _TimelineCircle({
    required this.completed,
    required this.current,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    if (completed) {
      return Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          color: colors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check,
          size: 15,
          color: colors.onPrimary,
        ),
      );
    }

    if (current) {
      return Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          color: colors.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: colors.primary,
            width: 2,
          ),
        ),
        child: Center(
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 26,
      width: 26,
      decoration: BoxDecoration(
        color: colors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.outlineVariant,
          width: 2,
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final dynamic colors;
  final TextTheme textTheme;

  const _ActionButtons({
    required this.colors,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 400;

        if (isSmall) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PrimaryButton(
                colors: colors,
                textTheme: textTheme,
              ),
              const SizedBox(height: 12),
              _SecondaryButton(
                colors: colors,
                textTheme: textTheme,
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: _PrimaryButton(
                colors: colors,
                textTheme: textTheme,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: _SecondaryButton(
                colors: colors,
                textTheme: textTheme,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final dynamic colors;
  final TextTheme textTheme;

  const _PrimaryButton({
    required this.colors,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: () {
         AppNavigator.popUntil((route)=>route.settings.name==AppRoutes.userWrapperScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Return to Dashboard',
          style: textTheme.labelLarge?.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final dynamic colors;
  final TextTheme textTheme;

  const _SecondaryButton({
    required this.colors,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: () {
          // AppNavigator...
        },
        icon: Icon(
          Icons.help_outline,
          size: 18,
          color: colors.onSurface,
        ),
        label: Text(
          'Help Center',
          style: textTheme.labelLarge?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: colors.surface,
          side: BorderSide(
            color: colors.outlineVariant,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}