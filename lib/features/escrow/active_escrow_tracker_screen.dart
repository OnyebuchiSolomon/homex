import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';


enum _MilestoneState { done, current, upcoming }

class _Milestone {
  final String title;
  final String description;
  final String? dateLabel;
  final IconData icon;
  final _MilestoneState state;

  const _Milestone({
    required this.title,
    required this.description,
    this.dateLabel,
    required this.icon,
    required this.state,
  });
}

class ActiveEscrowTrackerScreen extends StatelessWidget {
  const ActiveEscrowTrackerScreen({super.key});

  static const List<_Milestone> _milestones = [
    _Milestone(
      title: '1. Deposit Paid',
      description: 'Initial 10% commitment fee secured in escrow.',
      dateLabel: 'Completed: Oct 12, 2023',
      icon: Icons.check,
      state: _MilestoneState.done,
    ),
    _Milestone(
      title: '2. Inspection Cleared',
      description: 'Structural and legal diligence completed.',
      dateLabel: 'Completed: Oct 18, 2023',
      icon: Icons.check,
      state: _MilestoneState.done,
    ),
    _Milestone(
      title: '3. Final Payment Funded',
      description: 'Awaiting transfer of remaining 90% balance into escrow account.',
      icon: Icons.sync,
      state: _MilestoneState.current,
    ),
    _Milestone(
      title: '4. Property Handover',
      description: 'Physical keys and title documents exchanged.',
      icon: Icons.key,
      state: _MilestoneState.upcoming,
    ),
    _Milestone(
      title: '5. Funds Released',
      description: 'Escrow disburses full amount to seller.',
      icon: Icons.account_balance,
      state: _MilestoneState.upcoming,
    ),
  ];

  static const Color _forestGreen = Color(0xFF166534);

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final hPad = _hPad(context);

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeIn(child: _buildHeaderRow(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(child: _buildPropertySnapshot(context)),
                    const SizedBox(height: 24),
                    Text('Milestone Progress', style: context.textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    _buildTimeline(context),
                    const SizedBox(height: 8),
                    _buildEscrowProtectedCard(context),
                    const SizedBox(height: 16),
                    _buildDocumentsCard(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  // ---------------------------------------------------------------------
  Widget _buildTopBar(BuildContext context, double hPad) {
    final textTheme = context.textTheme;
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 8),
            child: Row(
              children: [
                ScaleOnTap(
                  onTap: () =>AppNavigator.pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                // const SizedBox(width: 8),
                // Expanded(
                //   child: FittedBox(
                //     fit: BoxFit.scaleDown,
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       'HomeX',
                //       style: AppTextStyles.displayLargeMobile.copyWith(color: context.colors.primary),
                //     ),
                //   ),
                // ),
                // const SizedBox(width: 8),
                // ScaleOnTap(
                //   onTap: () {},
                //   child: Padding(
                //     padding: const EdgeInsets.all(6),
                //     child: Icon(Icons.search, color: context.colors.primary),
                //   ),
                // ),
                // const SizedBox(width: 4),
                // ScaleOnTap(
                //   onTap: () {},
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(20),
                //     child: Container(
                //       width: 36,
                //       height: 36,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         border: Border.all(color: AppColors.lightOutlineVariant),
                //       ),
                //       child: ImageView.networkCached(
                //         'https://lh3.googleusercontent.com/aida-public/AB6AXuBLPTyrj9Py7NLph4V2eZx6GTEWxXMgsVY7UoEH1VQS8sy_QDGeqIoN7fJuNIb1pnnajtfyvbWdy7ADgtMTri-mm2zjx1mh_tnKrTSpjuE3OtdVGPz7yFL6W9YGG_RB6W-IpQFUO5adMjLZEruQVe1zsUlhHvvg0OGAN4wsysGQrYlpS4mPaG2xLhzS9LY95pAo_3FWi8XM3nBcBDbAyR9WJffhVpPu6Zutg8_U7S7b1uBlTvE3DWJL',
                //         fit: BoxFit.cover,
                //         errorWidget: const Icon(Icons.person, size: 18),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(height: 1, color: context.colors.outlineVariant),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Escrow Tracker', style: textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text('Ref: ESC-2023-8942-NG', style: textTheme.bodyMedium?.copyWith(color: AppColors.lightTextSecondary)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _forestGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock, size: 16, color: _forestGreen),
              const SizedBox(width: 6),
              Text('Active', style: textTheme.labelMedium?.copyWith(color: _forestGreen, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPropertySnapshot(BuildContext context) {
    final textTheme = context.textTheme;
    const goldAccent = Color(0xFFD4AF37);
    final color = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.outlineVariant),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ImageView.networkCached(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDTJTQNCaC4TV-Lc9MYc3u0qWg-hB6prA3sXdMol2cQODcuILTjTR-SVZOr4b5JYu5kLQp9yvS3fLbsG8m-4J5B5neP5WYhywwNBkLNXpA34Mh1KkdhYq09FU3vJzyzXR59uNfhspabSl8KckeKIJuGIHZo6NMQFFGyLIz-ZIcOwMyGhlzybUdzBpEM1SbO7eRQ0WS6RFu9UzBwRtTuOMyOAmV-fRgPgpbiaLqObaGfFv9713ovPKsd',
                fit: BoxFit.cover,
                errorWidget: Container(
                  color: color.surfaceContainer,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text('4 Bedroom Duplex, Lekki', style: textTheme.headlineSmall),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16,),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Phase 1, Lekki, Lagos',
                  style: textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text('₦ 150,000,000', style: textTheme.headlineSmall),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: goldAccent),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified, size: 14, color: goldAccent),
                    const SizedBox(width: 3),
                    Text('Verified', style: textTheme.labelSmall?.copyWith(color: goldAccent)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return Column(
      children: List.generate(_milestones.length, (index) {
        final m = _milestones[index];
        final isLast = index == _milestones.length - 1;
        return _buildMilestoneRow(context, m, isLast: isLast);
      }),
    );
  }

  Widget _buildMilestoneRow(BuildContext context, _Milestone m, {required bool isLast}) {
    final textTheme = context.textTheme;
    final isDone = m.state == _MilestoneState.done;
    final isCurrent = m.state == _MilestoneState.current;
final color = context.colors;
    final Color dotBg = isDone
        ? _forestGreen
        : isCurrent
        ? AppColors.primaryContainer
        : AppColors.lightSurfaceContainer;
    final Color dotFg = isDone
        ? Colors.white
        : isCurrent
        ? AppColors.onPrimaryContainer
        : AppColors.lightOutline;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                margin: EdgeInsets.only(top: isCurrent ? 4 : 4),
                decoration: BoxDecoration(
                  color: dotBg,
                  shape: BoxShape.circle,
                  border: !isDone && !isCurrent ? Border.all(color: color.outlineVariant) : null,
                  boxShadow: isCurrent
                      ? [BoxShadow(color: color.primaryFixed.withValues(alpha: 0.6), blurRadius: 0, spreadRadius: 3)]
                      : null,
                ),
                alignment: Alignment.center,
                child: Icon(m.icon, size: 16, color: dotFg),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color.surfaceContainerHigh,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Opacity(
              opacity: m.state == _MilestoneState.upcoming ? 0.6 : 1,
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                child: isCurrent ? _buildCurrentMilestoneCard(context, m) : _buildPlainMilestone(context, m),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlainMilestone(BuildContext context, _Milestone m) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(m.title, style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(m.description, style: textTheme.bodySmall),
        if (m.dateLabel != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.surfaceContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(m.dateLabel!, style: textTheme.labelSmall),
          ),
        ],
      ],
    );
  }

  Widget _buildCurrentMilestoneCard(BuildContext context, _Milestone m) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.outlineVariant),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(m.title, style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.secondaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Action Required',
                  style: textTheme.labelSmall?.copyWith(color: color.onSecondaryContainer, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(m.description, style: textTheme.bodySmall),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.10,
              minHeight: 10,
              backgroundColor: color.surfaceContainer,
              valueColor: const AlwaysStoppedAnimation<Color>(_forestGreen),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₦15M Funded', style: textTheme.labelSmall),
              Text('₦135M Pending', style: textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 12),
          ScaleOnTap(
            onTap: () =>AppNavigator.pushAndStackNamed(AppRoutes.fundingInstructionsScreen),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: color.outlineVariant),
                color: color.primaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'View Funding Instructions',
                textAlign: TextAlign.center,
                style: textTheme.labelMedium?.copyWith(color: color.onPrimaryContainer, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEscrowProtectedCard(BuildContext context) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: color.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            right: -16,
            top: -16,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.security, size: 100, color: color.onPrimaryContainer),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Escrow Protected', style: textTheme.headlineSmall),
              const SizedBox(height: 6),
              Text(
                'Your funds are held securely until all conditions are met.',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              ScaleOnTap(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(color: color.primary, borderRadius: BorderRadius.circular(999)),
                  child: Text(
                    'Contact Escrow Officer',
                    textAlign: TextAlign.center,
                    style: textTheme.labelMedium?.copyWith( fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard(BuildContext context) {
    final textTheme = context.textTheme;
    final color = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.outlineVariant),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Documents', style: textTheme.headlineSmall),
          const SizedBox(height: 8),
          _buildDocumentRow(context, 'Sale Agreement.pdf'),
          _buildDocumentRow(context, 'Inspection Report.pdf'),
          const SizedBox(height: 8),
          ScaleOnTap(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: color.outlineVariant),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 18, color: context.colors.primary),
                  const SizedBox(width: 8),
                  Text('View All Documents', style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentRow(BuildContext context, String name) {
    final textTheme = context.textTheme;
    return ScaleOnTap(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.description, size: 20, color: AppColors.lightOutline),
            const SizedBox(width: 8),
            Expanded(
              child: Text(name, style: textTheme.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            const Icon(Icons.download, size: 20, color: AppColors.lightOutline),
          ],
        ),
      ),
    );
  }
}