import 'package:homex/ui/global.dart';

enum _TimelineState { done, active, pending }

class _TimelineStep {
  final String title;
  final String dateOrEta;
  final String description;
  final _TimelineState state;
  final String? feedLabel;
  final String? feedText;

  const _TimelineStep({
    required this.title,
    required this.dateOrEta,
    required this.description,
    required this.state,
    this.feedLabel,
    this.feedText,
  });
}

class _Exhibit {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String meta;
  final IconData actionIcon;
  final String actionLabel;

  const _Exhibit({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.meta,
    required this.actionIcon,
    required this.actionLabel,
  });
}

class DisputeCenterScreen extends StatelessWidget {
  const DisputeCenterScreen({super.key});

  static const List<_TimelineStep> _timeline = [
    _TimelineStep(
      title: 'Dispute Lodged by Buyer',
      dateOrEta: 'Oct 18, 2023 · 11:20',
      description: '48h survey discrepancy report submitted with Land Bureau registry search excerpt identifying boundary conflict.',
      state: _TimelineState.done,
    ),
    _TimelineStep(
      title: 'Escrow Frozen & Custodial Injunction',
      dateOrEta: 'Oct 19, 2023 · 09:00',
      description: '₦25,000,000 locked in Stanbic IBTC Trust Vault under custodial freeze order ref: #INJ-7712.',
      state: _TimelineState.done,
    ),
    _TimelineStep(
      title: 'Lagos State Lands Bureau & Surveyor General Audit',
      dateOrEta: 'Estimated 24h remaining',
      description: 'Joint cadastral beacon chart verification in progress by Engr. Babatunde O. (Senior Cadastral Officer, Alausa Office).',
      state: _TimelineState.active,
      feedLabel: 'IN PROGRESS',
      feedText: 'Live Audit Feed: Verification file #LSB-CAD-2023-8991 under dual GIS validation.',
    ),
    _TimelineStep(
      title: 'Neutral Trustee Legal Decree',
      dateOrEta: 'Pending Audit',
      description: "Arbitrated resolution: complete refund of ₦25,000,000 to buyer or rectified governor's consent deed issuance with title guarantee.",
      state: _TimelineState.pending,
    ),
  ];

  static const List<_Exhibit> _exhibits = [
    _Exhibit(
      icon: Icons.picture_as_pdf,
      iconColor: Colors.black,
      title: 'Lagos Lands Bureau Cadastral Search.pdf',
      meta: '2.4 MB · Stamped by Lands Bureau',
      actionIcon: Icons.download,
      actionLabel: 'Download File',
    ),
    _Exhibit(
      icon: Icons.map,
      iconColor: Colors.black,
      title: 'Registered Survey Plan Beacon Chart',
      meta: '3 items · High-resolution beacon pins',
      actionIcon: Icons.visibility,
      actionLabel: 'View Coordinates',
    ),
    _Exhibit(
      icon: Icons.verified,
      iconColor: Colors.black,
      title: 'Tri-Party Escrow Contract Agreement #ESC-7712.pdf',
      meta: '4.1 MB · Digitally signed & sealed',
      actionIcon: Icons.download,
      actionLabel: 'Download File',
    ),
  ];

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colors;
    final hPad = _hPad(context);

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeIn(child: _buildStatusBanner(context)),
                    const SizedBox(height: 16),
                    SlideFadeIn(child: _buildFinancialSummary(context)),
                    const SizedBox(height: 16),
                    Text('DISPUTING PARTIES', style: context.textTheme.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    SlideFadeIn(delay: AppAnimations.shortDelay, child: _buildPartiesGrid(context)),
                    const SizedBox(height: 16),
                    ScrollReveal(child: _buildTimelineCard(context)),
                    const SizedBox(height: 16),
                    ScrollReveal(child: _buildArbiterCard(context)),
                    const SizedBox(height: 16),
                    Text('STATED POSITIONS OF THE PARTIES', style: context.textTheme.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    ScrollReveal(child: _buildPositionsSection(context)),
                    const SizedBox(height: 16),
                    ScrollReveal(child: _buildEvidenceCard(context)),
                    const SizedBox(height: 20),
                    _buildActionButtons(context),
                    const SizedBox(height: 10),
                    _buildTrusteeLink(context),
                    const SizedBox(height: 12),
                    _buildTrustFootnote(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // ---------------------------------------------------------------------
  Widget _buildHeader(BuildContext context, double hPad) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      child: Row(
        children: [
          ScaleOnTap(onTap: () => Navigator.of(context).maybePop(), child: Icon(Icons.arrow_back, color: cs.primary)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text('Case #DSP-7712-IK', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: cs.secondaryFixed, borderRadius: BorderRadius.circular(999)),
                      child: Text('Active Case', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSecondaryFixed, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                Text('Case Ref: #DSP-7712-IK · Ikoyi, Lagos', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          ScaleOnTap(onTap: () {}, child: Padding(padding: const EdgeInsets.all(6), child: Icon(Icons.share, size: 20, color: cs.onSurfaceVariant))),
          ScaleOnTap(onTap: () {}, child: Padding(padding: const EdgeInsets.all(6), child: Icon(Icons.more_vert, size: 20, color: cs.onSurfaceVariant))),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, {required Widget child, EdgeInsets? padding}) {
    final cs = context.colors;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant)),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildStatusBanner(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: cs.secondaryFixed, borderRadius: BorderRadius.circular(6), border: Border.all(color: cs.secondaryFixedDim)),
                child: Text('UNDER REVIEW', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSecondaryFixed, fontWeight: FontWeight.w800)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: cs.surfaceContainerHigh, borderRadius: BorderRadius.circular(6)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: cs.secondaryContainer, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text('ESCROW FROZEN · SLA: 24h Remaining', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(999)),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              children: [
                Icon(Icons.verified_user, size: 14, color: cs.secondary),
                Text('Statutory Trust Shield Active', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                Text('|', style: TextStyle(color: cs.outline)),
                Text('STANBIC-VAULT-7712', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.primary, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text('Escrow Frozen & Under Legal Deed Cadastral Audit', style: tt.headlineSmall),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              style: tt.bodyMedium?.copyWith(fontSize: 13, color: cs.onSurfaceVariant, height: 1.5),
              children: [
                const TextSpan(text: 'The '),
                TextSpan(text: '₦25,000,000', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                const TextSpan(text: " commitment deposit is securely ring-fenced in the Stanbic IBTC Custodial Vault under SEC Nigeria Rule 184(b). Disputed over Root Title Deed Authenticity & Governor's Consent beacon coordinates."),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: cs.surfaceContainerHigh),
          const SizedBox(height: 10),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.lock, size: 16, color: cs.primary),
                const SizedBox(width: 4),
                Text.rich(TextSpan(style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant), children: [
                  const TextSpan(text: 'Injunction Custodian: '),
                  TextSpan(text: 'Stanbic IBTC Trustees Ltd', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                ])),
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.schedule, size: 16, color: cs.secondary),
                const SizedBox(width: 4),
                Text.rich(TextSpan(style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant), children: [
                  const TextSpan(text: 'Cadastral Audit Due: '),
                  TextSpan(text: 'Tomorrow, 11:20 WAT', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                ])),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FINANCIAL INQUEST SUMMARY', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.secondary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('₦25,000,000.00', style: tt.headlineMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 26)),
                const SizedBox(width: 6),
                Text('(Milestone 1 Commitment Deposit)', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.apartment, size: 15, color: cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Expanded(child: Text('Ikoyi Waterfront Apartment (Unit 4B), Alexander Road, Ikoyi, Lagos', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date Filed', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                    Text('18 Oct 2023 (11:20 WAT)', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: cs.surfaceContainerHigh, borderRadius: BorderRadius.circular(4)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.policy, size: 12, color: cs.onSurface),
                        const SizedBox(width: 4),
                        Flexible(child: Text('Title Deed & Cadastral Verification', style: tt.labelSmall?.copyWith(fontSize: 10), overflow: TextOverflow.ellipsis)),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.surfaceContainerHigh)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning, size: 20, color: cs.secondary),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ROOT ISSUE IDENTIFIED', style: tt.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(
                        "Cadastral Beacon Overlap with Lagos State Coastal Right of Way / Unverified Governor's Consent Memorialization.",
                        style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.4),
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

  Widget _buildPartiesGrid(BuildContext context) {
    final cs = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _partyCard(
            context,
            initials: 'AM',
            roleLabel: 'INITIATOR (BUYER)',
            name: 'Alexander Magnus',
            subLine: 'INV-NG-883920',
            avatarBg: cs.primaryContainer,
            avatarFg: cs.onPrimary,
            badge: 'Tier 3 Verified',
            badgeIcon: Icons.verified,
            badgeBg: cs.tertiaryFixed,
            badgeFg: cs.onTertiaryContainer,
            footerLabel: 'Platform Trust Rating',
            footerValue: '99.4% Trust',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _partyCard(
            context,
            initials: 'AE',
            roleLabel: 'RESPONDENT (SELLER)',
            name: 'Adeyemi Estates Trust',
            subLine: 'Chief T. Adeleke',
            avatarBg: cs.secondaryFixed,
            avatarFg: cs.onSecondaryFixed,
            badge: 'Tier 3 Landlord',
            badgeIcon: Icons.domain_verification,
            badgeBg: cs.secondaryFixed,
            badgeFg: cs.onSecondaryFixed,
            footerLabel: 'Corporate Reg',
            footerValue: 'RC-449102-LA',
            footerMono: true,
          ),
        ),
      ],
    );
  }

  Widget _partyCard(
      BuildContext context, {
        required String initials,
        required String roleLabel,
        required String name,
        required String subLine,
        required Color avatarBg,
        required Color avatarFg,
        required String badge,
        required IconData badgeIcon,
        required Color badgeBg,
        required Color badgeFg,
        required String footerLabel,
        required String footerValue,
        bool footerMono = false,
      }) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: avatarBg, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(initials, style: tt.labelSmall?.copyWith(color: avatarFg, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(roleLabel, style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onSurfaceVariant, fontWeight: FontWeight.w700)),
                    Text(name, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(subLine, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline, fontFamily: footerMono ? 'monospace' : null), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(999)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(badgeIcon, size: 10, color: badgeFg),
              const SizedBox(width: 3),
              Flexible(child: Text(badge, style: tt.labelSmall?.copyWith(fontSize: 9, color: badgeFg, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
            ]),
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: cs.surfaceContainerHigh),
          const SizedBox(height: 6),
          // Stacked instead of a spaceBetween Row — a narrow (~148px) card
          // can't fit a label like "Platform Trust Rating" and its value
          // like "99.4% Trust" side by side without overflowing.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(footerLabel, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
              const SizedBox(height: 2),
              Text(
                footerValue,
                style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, fontFamily: footerMono ? 'monospace' : null),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
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
                    Text('Arbitration Timeline & Progress Tracker', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    Text('Formal adjudicative workflow governed by Lagos Multi-Door Courthouse rules', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(4)),
                child: Text('Phase 3 of 4', style: tt.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: List.generate(_timeline.length, (i) => _timelineRow(context, _timeline[i], isLast: i == _timeline.length - 1)),
          ),
        ],
      ),
    );
  }

  // Fixed-height connector instead of IntrinsicHeight + Expanded, which
  // avoids the fragile intrinsic-sizing layout pass that can misbehave
  // when wrapping content of unpredictable height (long descriptions,
  // optional feed text, etc).
  Widget _timelineRow(BuildContext context, _TimelineStep step, {required bool isLast}) {
    final cs = context.colors;
    final tt = context.textTheme;
    final isDone = step.state == _TimelineState.done;
    final isActive = step.state == _TimelineState.active;

    final Color dotBg = isDone ? cs.primary : (isActive ? cs.secondaryContainer : cs.surfaceContainerHigh);
    final Color dotFg = isDone ? cs.onPrimary : (isActive ? cs.onSecondaryContainer : cs.outline);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: dotBg,
                shape: BoxShape.circle,
                border: !isDone && !isActive ? Border.all(color: cs.outlineVariant, width: 2) : null,
              ),
              alignment: Alignment.center,
              child: Icon(
                isDone ? Icons.check : (isActive ? Icons.hourglass_top : Icons.gavel),
                size: 13,
                color: dotFg,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 64,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: cs.surfaceContainerHighest,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20, top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Text(
                      step.title,
                      style: tt.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: step.state == _TimelineState.pending ? cs.outline : (isActive ? cs.secondary : cs.onSurface),
                      ),
                    ),
                    if (step.feedLabel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(color: cs.secondaryFixed, borderRadius: BorderRadius.circular(3)),
                        child: Text(step.feedLabel!, style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onSecondaryFixed, fontWeight: FontWeight.w800)),
                      ),
                  ],
                ),
                Text(step.dateOrEta, style: tt.labelSmall?.copyWith(fontSize: 10, color: isActive ? cs.secondary : cs.outline, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(step.description, style: tt.labelSmall?.copyWith(fontSize: 11, color: step.state == _TimelineState.pending ? cs.outline : cs.onSurfaceVariant, height: 1.4)),
                if (step.feedText != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.sync, size: 14, color: cs.secondary),
                        const SizedBox(width: 6),
                        Expanded(child: Text(step.feedText!, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant))),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArbiterCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: Icon(Icons.gavel, size: 22, color: cs.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  children: [
                    Text('ASSIGNED REAL ESTATE ARBITER PANEL', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.secondary, fontWeight: FontWeight.w700)),
                    Text('Lagos Multi-Door Courthouse (LMDC)', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Barr. Funke Adeleke (SAN)', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                Text('Senior Registrar, Certified Real Estate Dispute Mediator #LMDC-MED-412', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: [
                      Icon(Icons.fact_check, size: 14, color: cs.secondary),
                      const SizedBox(width: 6),
                      Expanded(child: Text('Status: Auditing Surveyor General Cadastral Chart & C-of-O Folio 44', style: tt.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w600))),
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

  Widget _buildPositionsSection(BuildContext context) {
    final cs = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _positionCard(
            context,
            accent: cs.primary,
            name: 'Alexander Magnus (Buyer)',
            tag: 'Plea for Refund',
            tagBg: cs.surfaceContainer,
            tagFg: cs.onSurfaceVariant,
            statement:
            '"Physical beacon search at Alausa Lands Registry revealed the survey plan coordinates overlap an existing gazetted shoreline reserve. Requesting full ₦25M escrow release back to wallet."',
            footer: 'Submitted: Oct 18, 2023 · Attached 2 Survey Documents',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _positionCard(
            context,
            accent: cs.secondary,
            name: 'Adeyemi Estates (Seller)',
            tag: 'Regularisation In Flight',
            tagBg: cs.secondaryFixed,
            tagFg: cs.onSecondaryFixed,
            statement:
            '"The property possesses an authentic 1998 Governor\'s Consent. Supplemental beacon adjustment submitted to Surveyor General for regularisation."',
            footer: "Submitted: Oct 19, 2023 · Attached Governor's Consent Folio",
          ),
        ),
      ],
    );
  }

  // Single, correct implementation — the earlier duplicate defined
  // outside the class (and its broken `.copyWith` variant) is removed.
  Widget _positionCard(
      BuildContext context, {
        required Color accent,
        required String name,
        required String tag,
        required Color tagBg,
        required Color tagFg,
        required String statement,
        required String footer,
      }) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: accent, width: 4),
          top: BorderSide(color: cs.outlineVariant),
          right: BorderSide(color: cs.outlineVariant),
          bottom: BorderSide(color: cs.outlineVariant),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(color: tagBg, borderRadius: BorderRadius.circular(4)),
            child: Text(tag.toUpperCase(), style: tt.labelSmall?.copyWith(fontSize: 9, color: tagFg, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          Text(statement, style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.4)),
          const SizedBox(height: 6),
          Row(children: [
            Icon(Icons.schedule, size: 11, color: cs.outline),
            const SizedBox(width: 3),
            Expanded(child: Text(footer, style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.outline), overflow: TextOverflow.ellipsis)),
          ]),
        ],
      ),
    );
  }

  Widget _buildEvidenceCard(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Evidentiary Dossier & Attached Exhibits', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    Text('3 authenticated legal filings uploaded to chain of custody', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                  ],
                ),
              ),
              Icon(Icons.folder_zip, color: cs.outline),
            ],
          ),
          const SizedBox(height: 12),
          ..._exhibits.map((e) => Padding(padding: const EdgeInsets.only(bottom: 8), child: _exhibitTile(context, e))),
          const SizedBox(height: 4),
          Container(height: 1, color: cs.surfaceContainerHigh),
          const SizedBox(height: 12),
          ScaleOnTap(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outline, style: BorderStyle.solid)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle, size: 16, color: cs.onSurface),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      '+ Upload Additional Legal Evidence / Addendum',
                      textAlign: TextAlign.center,
                      style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

  Widget _exhibitTile(BuildContext context, _Exhibit e) {
    final cs = context.colors;
    final tt = context.textTheme;
    return ScaleOnTap(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.surfaceContainerHigh)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(6)),
              child: Icon(e.icon, size: 18, color: cs.primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.title, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(e.meta, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
                  const SizedBox(height: 3),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(e.actionIcon, size: 11, color: cs.secondary),
                    const SizedBox(width: 3),
                    Text(e.actionLabel, style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.secondary, fontWeight: FontWeight.w700)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      children: [
        ScaleOnTap(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.handshake, size: 18, color: cs.onPrimary),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Accept Proposed Settlement / Mediation',
                    textAlign: TextAlign.center,
                    style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ScaleOnTap(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outline)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.balance, size: 16, color: cs.primary),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Request Expedited Legal Hearing',
                    textAlign: TextAlign.center,
                    style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700, color: cs.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrusteeLink(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Center(
      child: ScaleOnTap(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.support_agent, size: 16, color: cs.primary),
            const SizedBox(width: 6),
            Text('Contact Assigned Escrow Trustee', style: tt.labelSmall?.copyWith(color: cs.primary, fontWeight: FontWeight.w700, decoration: TextDecoration.underline)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustFootnote(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shield, size: 16, color: cs.secondary),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              'NDIC Insured & SEC Regulated Trust Protection · Stanbic IBTC Trustees Official Injunction #IK-7712',
              textAlign: TextAlign.center,
              style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final cs = context.colors;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, -2))]),
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: context.bottomPadding + 8),
      child: Row(
        children: [
          Expanded(child: _navItem(context, icon: Icons.real_estate_agent, label: 'Properties', selected: false)),
          Expanded(child: _navItem(context, icon: Icons.account_balance_wallet, label: 'Escrow', selected: false)),
          Expanded(child: _navItem(context, icon: Icons.gavel, label: 'Disputes', selected: true)),
          Expanded(child: _navItem(context, icon: Icons.person, label: 'Profile', selected: false)),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, {required IconData icon, required String label, required bool selected}) {
    final cs = context.colors;
    final tt = context.textTheme;
    final color = selected ? cs.primary : cs.onSurfaceVariant;
    return ScaleOnTap(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 2),
          Text(label, style: tt.labelSmall?.copyWith(fontSize: 11, color: color, fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}