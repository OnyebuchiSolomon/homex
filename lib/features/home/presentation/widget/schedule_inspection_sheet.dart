import 'package:homex/ui/global.dart';

import '../screens/inspection_confirmed_screen.dart';
class ScheduleInspectionSheet extends StatefulWidget {
  const ScheduleInspectionSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ScheduleInspectionSheet(),
    );
  }

  @override
  State<ScheduleInspectionSheet> createState() => _ScheduleInspectionSheetState();
}

class _ScheduleInspectionSheetState extends State<ScheduleInspectionSheet> {
  int _inspectionType = 0; // 0 physical, 1 video, 2 technical
  int _dateIndex = 0; // 0 Tomorrow, 1 Upcoming, 2 Weekend, 3 Custom
  int _timeSlotIndex = 0;
  int _guestOption = 0; // 0 self, 1 plus1, 2 surveyor
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.94,
      minChildSize: 0.5,
      maxChildSize: 0.96,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              _buildHandleAndHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPropertySummary(context),
                      const SizedBox(height: 12),
                      _buildHostTrustStrip(context),
                      const SizedBox(height: 20),
                      _buildInspectionTypeSection(context),
                      const SizedBox(height: 20),
                      _buildDateTimeSection(context),
                      const SizedBox(height: 20),
                      _buildSecuritySection(context),
                      const SizedBox(height: 20),
                      _buildNoteSection(context),
                      const SizedBox(height: 16),
                      _buildAntiExtortionNote(context),
                    ],
                  ),
                ),
              ),
              _buildFooter(context),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------
  Widget _buildHandleAndHeader(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: 44,
          height: 4,
          decoration: BoxDecoration(color: cs.outlineVariant, borderRadius: BorderRadius.circular(999)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: cs.secondaryFixed, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(Icons.calendar_month, size: 16, color: cs.onSecondaryFixed),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Schedule Visit', style: tt.headlineSmall),
                    Text('Reserve verified direct walkthrough', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                  ],
                ),
              ),
              ScaleOnTap(onTap: () => Navigator.of(context).pop(), child: Icon(Icons.close, color: cs.onSurfaceVariant)),
            ],
          ),
        ),
        Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.3)),
      ],
    );
  }

  Widget _buildPropertySummary(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 76,
                  height: 76,
                  child: ImageView.networkCached(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBTm7qsCD8zr8NYmNxZ4vjpqU2y25cbmT27MrR2mBrR-qf927t77dpIho1KPPQcPOx-EiBpN8dvvy8Dhi_Qy7jILsLA9jc60193NlrDWg201nsRRfBrlLZWlbwguy0bZomypvXl7QEQhKOoLx0W8SN5KlLStJooHpEs-nMDggdkNEaF-r8A2VB5kkbDWw2rLXgVmWihC7jFT5Gu6UWuCqQrKb9OqdSjtivBbsqXmZ0SHmj2ucdlBEka',
                    fit: BoxFit.cover,
                    errorWidget: Container(color: cs.surfaceContainer, child: const Icon(Icons.image_not_supported_outlined)),
                  ),
                ),
              ),
              Positioned(
                bottom: 3,
                left: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(color: cs.primary.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(4)),
                  child: Text('#LX-1092', style: tt.labelSmall?.copyWith(fontSize: 8, color: cs.onPrimary)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.secondaryContainer, borderRadius: BorderRadius.circular(4)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.verified, size: 10, color: cs.secondary),
                        const SizedBox(width: 2),
                        Text('Verified Listing', style: tt.labelSmall?.copyWith(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w700)),
                      ]),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    //   decoration: BoxDecoration(color: cs.tertiaryFixed, borderRadius: BorderRadius.circular(4)),
                    //   child: Text('LASRERA Registered', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onTertiaryContainer, fontWeight: FontWeight.w600)),
                    // ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Luxury 4-Bedroom Semi-Detached Duplex', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                Row(children: [
                  Icon(Icons.location_on, size: 12, color: cs.outline),
                  const SizedBox(width: 3),
                  Text('Lekki Phase 1, Lagos State', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
                ]),
                const SizedBox(height: 6),
                Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.3)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w800),
                          children: [
                            const TextSpan(text: '₦45,000,000 '),
                            TextSpan(text: '/ yr', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400, color: cs.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(color: cs.tertiaryFixed.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(4)),
                      child: Text('0% Broker Markup', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onTertiaryContainer, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHostTrustStrip(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: cs.primaryContainer, shape: BoxShape.circle, border: Border.all(color: cs.primary.withValues(alpha: 0.2))),
            alignment: Alignment.center,
            child: Text('JO', style: tt.labelSmall?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('John Okafor', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(3)),
                    child: Text('Direct Landlord', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onSurfaceVariant)),
                  ),
                ]),
                Row(children: [
                  Icon(Icons.star, size: 12, color: cs.secondary),
                  const SizedBox(width: 3),
                  Expanded(child: Text('99% Trust Score • Lekki Resident Landlord', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant), overflow: TextOverflow.ellipsis)),
                ]),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(color: cs.tertiaryFixed, borderRadius: BorderRadius.circular(6)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.security, size: 11, color: cs.onTertiaryFixed),
              const SizedBox(width: 3),
              Text('KYC Validated', style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.onTertiaryFixed, fontWeight: FontWeight.w700)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionTypeSection(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select Inspection Format', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
            Text('Choose preferred mode', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 10),
        _inspectionOption(
          context,
          index: 0,
          title: 'Physical Walkthrough',
          badge: 'Most Popular',
          badgeColor: cs.secondaryFixed,
          badgeTextColor: cs.onSecondaryFixed,
          price: 'Free',
          description: 'On-site access with estate gate clearance code. Accompanied by certified HomeX Resident Escort.',
          tags: const ['LASRERA Escort', 'Instant Gate Code'],
          tagIcons: const [Icons.badge, Icons.pin],
        ),
        const SizedBox(height: 8),
        _inspectionOption(
          context,
          index: 1,
          title: 'Live Virtual Video Tour',
          price: 'Free',
          description: '1-on-1 private video inspection with John Okafor or property manager. HD room-by-room review.',
          tags: const ['Google Meet / Zoom', '30 Mins'],
          tagIcons: const [Icons.videocam, Icons.timer],
        ),
        const SizedBox(height: 8),
        _inspectionOption(
          context,
          index: 2,
          title: 'Structural & MEP Audit',
          price: 'Accredited',
          priceColor: cs.secondary,
          description: 'Full technical survey with accredited Nigerian Institute of Civil Engineers (NICE) registered surveyor.',
          tags: const ['Structural Report', 'Moisture & Inverter Check'],
          tagIcons: const [Icons.architecture, Icons.bolt],
        ),
      ],
    );
  }

  Widget _inspectionOption(
      BuildContext context, {
        required int index,
        required String title,
        String? badge,
        Color? badgeColor,
        Color? badgeTextColor,
        required String price,
        Color? priceColor,
        required String description,
        required List<String> tags,
        required List<IconData> tagIcons,
      }) {
    final cs = context.colors;
    final tt = context.textTheme;
    final selected = _inspectionType == index;

    return ScaleOnTap(
      onTap: () => setState(() => _inspectionType = index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? cs.surfaceContainerLow : cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? cs.primary : cs.outlineVariant.withValues(alpha: 0.6), width: selected ? 2 : 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 18,
              height: 18,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: selected ? cs.primary : cs.outline, width: 2)),
              alignment: Alignment.center,
              child: selected ? Container(width: 9, height: 9, decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle)) : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            Text(title, style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
                            if (badge != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),
                                child: Text(badge.toUpperCase(), style: tt.labelSmall?.copyWith(fontSize: 8, color: badgeTextColor, fontWeight: FontWeight.w800)),
                              ),
                          ],
                        ),
                      ),
                      Text(price, style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: priceColor ?? cs.primary)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(description, style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.4)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    children: List.generate(tags.length, (i) {
                      return Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(tagIcons[i], size: 12, color: cs.outline),
                        const SizedBox(width: 3),
                        Text(tags[i], style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
                      ]);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeSection(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    final dates = [
      ['Tomorrow', 'Thu, Oct 31'],
      ['Upcoming', 'Fri, Nov 1'],
      ['Weekend', 'Sat, Nov 2'],
    ];
    final slots = ['10:00 - 11:30 AM', '02:00 - 03:30 PM', '04:30 - 06:00 PM'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Inspection Date', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
            Text('Lagos Local Time (WAT)', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.secondary, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ...List.generate(dates.length, (i) {
              final selected = _dateIndex == i;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ScaleOnTap(
                    onTap: () => setState(() => _dateIndex = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? cs.primary : cs.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: selected ? cs.primary : cs.outlineVariant, width: selected ? 2 : 1),
                      ),
                      child: Column(
                        children: [
                          Text(dates[i][0], style: tt.labelSmall?.copyWith(fontSize: 9, color: selected ? cs.primaryFixedDim : cs.onSurfaceVariant)),
                          Text(dates[i][1], style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, color: selected ? cs.onPrimary : cs.onSurface)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            Expanded(
              child: ScaleOnTap(
                onTap: () => setState(() => _dateIndex = 3),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cs.outlineVariant, style: BorderStyle.solid),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.event, size: 15, color: _dateIndex == 3 ? cs.primary : cs.onSurfaceVariant),
                      Text('Custom', style: tt.labelSmall?.copyWith(fontSize: 9, fontWeight: FontWeight.w700, color: _dateIndex == 3 ? cs.primary : cs.onSurfaceVariant)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('Available Walkthrough Slots', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 8),
        Row(
          children: List.generate(slots.length, (i) {
            final selected = _timeSlotIndex == i;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i == slots.length - 1 ? 0 : 8),
                child: ScaleOnTap(
                  onTap: () => setState(() => _timeSlotIndex = i),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: selected ? cs.surfaceContainer : cs.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: selected ? cs.primary : cs.outlineVariant.withValues(alpha: 0.6), width: selected ? 2 : 1),
                    ),
                    child: Text(
                      slots[i],
                      textAlign: TextAlign.center,
                      style: tt.labelSmall?.copyWith(fontSize: 10, fontWeight: selected ? FontWeight.w700 : FontWeight.w500, color: selected ? cs.primary : cs.onSurfaceVariant),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSecuritySection(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    final guests = ['Just Me (Self)', '+1 (Partner/Spouse)', '+ Architect/Surveyor'];

    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.shield_moon, size: 18, color: cs.secondary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Estate Security Protocol', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(
                      "Lekki Phase 1 Estate Association mandates guest pre-registration. A secure 6-digit visitor access PIN will be SMS'd to your verified phone number once John approves.",
                      style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(8), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(color: cs.tertiaryFixed, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Icon(Icons.done, size: 12, color: cs.onTertiaryFixed),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BVN & NIN Identity Verified', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
                      Text('Automated gate check-in enabled for this visit', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
                    ],
                  ),
                ),
                Text('Active', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onTertiaryContainer, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text('Accompanying Attendees', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            children: List.generate(guests.length, (i) {
              final selected = _guestOption == i;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == guests.length - 1 ? 0 : 6),
                  child: ScaleOnTap(
                    onTap: () => setState(() => _guestOption = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? cs.surfaceContainer : cs.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: selected ? cs.primary : cs.outlineVariant, width: selected ? 2 : 1),
                      ),
                      child: Text(
                        guests[i],
                        textAlign: TextAlign.center,
                        style: tt.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w600, color: cs.onSurfaceVariant),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteSection(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text('Note for John Okafor ', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
          Text('(Optional)', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant)),
        ]),
        const SizedBox(height: 6),
        TextField(
          controller: _noteController,
          maxLines: 2,
          style: tt.labelSmall,
          decoration: InputDecoration(
            hintText: 'e.g., Interested in checking electrical inverter setup, borehole water filtration...',
            filled: true,
            fillColor: cs.surfaceContainerLowest,
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: cs.outlineVariant)),
          ),
        ),
        const SizedBox(height: 4),
        Text('Direct message delivered via encrypted HomeX Relay.', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildAntiExtortionNote(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerHighest.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user, size: 15, color: cs.secondary),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant, height: 1.5),
                children: [
                  TextSpan(text: 'HomeX Zero-Extortion Guarantee: ', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                  const TextSpan(text: 'In compliance with LASRERA guidelines, viewing fees, illegal agent levies, or unsolicited middleman demands are strictly prohibited. Contact '),
                  TextSpan(text: 'Directly with Property Custodian', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, border: Border(top: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.4)))),
      padding: EdgeInsets.fromLTRB(20, 12, 20, context.bottomPadding + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleOnTap(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const InspectionConfirmedScreen()));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12),border: Border.all(color: cs.outlineVariant)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Confirm & Send Inspection Request',
                      textAlign: TextAlign.center,
                      style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w800),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18, color: cs.onPrimary),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          ScaleOnTap(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Cancel & Return to Lekki Duplex Details',
                style: tt.labelSmall?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}