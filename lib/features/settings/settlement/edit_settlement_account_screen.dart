import 'package:homex/ui/global.dart';

class EditSettlementAccountScreen extends StatefulWidget {
  const EditSettlementAccountScreen({super.key});

  @override
  State<EditSettlementAccountScreen> createState() => _EditSettlementAccountScreenState();
}

class _EditSettlementAccountScreenState extends State<EditSettlementAccountScreen> {
  static const Map<String, String> _banks = {
    'zenith': 'Zenith Bank PLC',
    'access': 'Access Bank PLC',
    'gtb': 'Guaranty Trust Bank (GTBank)',
    'stanbic': 'Stanbic IBTC Bank',
    'firstbank': 'First Bank of Nigeria',
    'providus': 'Providus Bank PLC',
  };

  String _selectedBank = 'zenith';
  String _accountType = 'corporate';
  bool _biometricEnabled = true;

  final TextEditingController _nubanController = TextEditingController(text: '2088 4190 90');
  final List<TextEditingController> _pinControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _pinFocusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    const prefilled = ['8', '4', '1', '9'];
    for (int i = 0; i < prefilled.length; i++) {
      _pinControllers[i].text = prefilled[i];
    }
  }

  @override
  void dispose() {
    _nubanController.dispose();
    for (final c in _pinControllers) c.dispose();
    for (final f in _pinFocusNodes) f.dispose();
    super.dispose();
  }

  String _bankInitials(String bankId) {
    final name = _banks[bankId] ?? '';
    final words = name.split(' ').where((w) => w.isNotEmpty).toList();
    if (words.length >= 2) return '${words[0][0]}${words[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name.substring(0, 2).toUpperCase() : '';
  }

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
        child: Column(
          children: [
            _buildHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCoolingOffBanner(context),
                    const SizedBox(height: 16),
                    _buildCurrentAccountCard(context),
                    const SizedBox(height: 16),
                    _buildFormCard(context),
                    const SizedBox(height: 16),
                    _buildSecurityCard(context),
                    const SizedBox(height: 20),
                    _buildActionButtons(context),
                    const SizedBox(height: 16),
                    _buildFooter(context),
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
  Widget _buildHeader(BuildContext context, double hPad) {
    final textTheme = context.textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      child: Row(
        children: [
          ScaleOnTap(onTap: () => Navigator.of(context).maybePop(), child: Icon(Icons.arrow_back, color: context.colors.onSurface)),
          Expanded(
            child: Column(
              children: [
                Text('Edit Settlement Account', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text('TIER 3 INSTITUTIONAL SECURITY', style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.secondary, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.security, color: AppColors.secondary),
        ],
      ),
    );
  }

  Widget _buildCoolingOffBanner(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryFixed.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondaryFixedDim.withValues(alpha: 0.6)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.15), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Icon(Icons.lock_clock, size: 18, color: AppColors.secondary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Text('24-Hour Disbursement Cooling Lock', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.secondaryFixed, borderRadius: BorderRadius.circular(4)),
                      child: Text('SEC RULE', style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.onSecondaryFixed, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Per SEC & NDIC Anti-Diversion guidelines, updating settlement bank details triggers a temporary 24-hour hold on automated large disbursements (>₦10,000,000). Active in-progress escrow releases will require manual officer verification.',
                  style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.onSecondaryFixedVariant, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentAccountCard(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.5))),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('CURRENT ACTIVE ACCOUNT', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightOutline, fontWeight: FontWeight.w700)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.tertiaryFixedDim, borderRadius: BorderRadius.circular(999)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.check_circle, size: 13, color: AppColors.onTertiaryFixed),
                  const SizedBox(width: 4),
                  Text('100% Name Match', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.onTertiaryFixed, fontWeight: FontWeight.w700)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: AppColors.lightSurfaceContainer),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: AppColors.lightSurfaceContainerHigh, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.4))),
                alignment: Alignment.center,
                child: Text('ZB', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Flexible(child: Text('Zenith Bank PLC', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, size: 15, color: AppColors.secondary),
                    ]),
                    Text('Alexander Magnus', style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary)),
                    Text('NUBAN: 2088 4190 90', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightOutline, fontFamily: 'monospace')),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(4)),
                child: Text('Primary', style: textTheme.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.5))),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Settlement Coordinates', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              Text('Real-time NIBSS API', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightOutline)),
            ],
          ),
          const SizedBox(height: 16),
          Text('Financial Institution', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant)),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.4))),
                  alignment: Alignment.center,
                  child: Text(_bankInitials(_selectedBank), style: textTheme.labelSmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedBank,
                      isExpanded: true,
                      icon: const Icon(Icons.unfold_more, size: 20, color: AppColors.lightOutline),
                      style: textTheme.bodyMedium,
                      items: _banks.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value, overflow: TextOverflow.ellipsis))).toList(),
                      onChanged: (v) => setState(() => _selectedBank = v ?? _selectedBank),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('10-Digit NUBAN Number', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
              Text('NUBAN Standard', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightOutline)),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(Icons.account_balance_wallet, size: 18, color: AppColors.lightOutline),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _nubanController,
                    keyboardType: TextInputType.number,
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontFamily: 'monospace', letterSpacing: 1.2),
                    decoration: const InputDecoration(border: InputBorder.none, isCollapsed: true, contentPadding: EdgeInsets.symmetric(vertical: 12)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.tertiaryFixedDim, borderRadius: BorderRadius.circular(4)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.sync_alt, size: 11, color: AppColors.onTertiaryFixed),
                    const SizedBox(width: 3),
                    Text('NIBSS Synced', style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.onTertiaryFixed, fontWeight: FontWeight.w700)),
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(children: [
            const Icon(Icons.check_circle, size: 15, color: AppColors.tertiaryContainer),
            const SizedBox(width: 6),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary),
                  children: const [
                    TextSpan(text: 'Name Match: '),
                    TextSpan(text: 'Alexander Magnus', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.lightTextPrimary)),
                  ],
                ),
              ),
            ),
          ]),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Verified Account Beneficiary', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.lock, size: 13, color: AppColors.lightOutline),
                const SizedBox(width: 3),
                Text('Statutory Locked', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightOutline, fontWeight: FontWeight.w600)),
              ]),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.6))),
            child: Row(
              children: [
                Expanded(child: Text('Alexander Magnus', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700))),
                const Icon(Icons.verified_user, size: 18, color: AppColors.secondary),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.lightSurfaceContainer.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.3))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info, size: 16, color: AppColors.lightOutline),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary, height: 1.5),
                      children: const [
                        TextSpan(text: 'Strict Statutory Rule: ', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.lightTextPrimary)),
                        TextSpan(text: 'Account holder name must strictly match your BVN/NIN identity record (Alexander Magnus). Third-party payouts are prohibited.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Account Classification & Tax Purpose', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _accountTypeTile(context, id: 'corporate', icon: Icons.domain, label: 'Corporate Current', caption: 'Active')),
              const SizedBox(width: 8),
              Expanded(child: _accountTypeTile(context, id: 'personal', icon: Icons.person, label: 'Personal Savings', caption: 'Tier 2/3')),
              const SizedBox(width: 8),
              Expanded(child: _accountTypeTile(context, id: 'trust', icon: Icons.account_balance, label: 'Special Trust', caption: 'Fiduciary')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _accountTypeTile(BuildContext context, {required String id, required IconData icon, required String label, required String caption}) {
    final textTheme = context.textTheme;
    final selected = _accountType == id;

    return ScaleOnTap(
      onTap: () => setState(() => _accountType = id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: selected ? context.colors.primary.withValues(alpha: 0.05) : AppColors.lightSurfaceContainerLowest,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? context.colors.primary : AppColors.lightOutlineVariant, width: selected ? 2 : 1),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: selected ? context.colors.primary : AppColors.lightOutline),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, color: selected ? context.colors.primary : context.colors.onSurface),
            ),
            Text(caption, style: textTheme.labelSmall?.copyWith(fontSize: 9, color: AppColors.lightOutline)),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityCard(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.lightOutlineVariant.withValues(alpha: 0.5))),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: const Icon(Icons.shield, size: 14, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text('Security Clearance Required', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('6-Digit Escrow Transaction PIN', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
              ScaleOnTap(onTap: () {}, child: Text('Forgot PIN?', style: textTheme.labelSmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(6, (i) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == 5 ? 0 : 8),
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      controller: _pinControllers[i],
                      focusNode: _pinFocusNodes[i],
                      textAlign: TextAlign.center,
                      obscureText: true,
                      obscuringCharacter: '•',
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, fontFamily: 'monospace'),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.lightSurfaceContainerLow,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.lightOutlineVariant)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: context.colors.primary, width: 2)),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && i < 5) {
                          _pinFocusNodes[i + 1].requestFocus();
                        } else if (value.isEmpty && i > 0) {
                          _pinFocusNodes[i - 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: AppColors.lightSurfaceContainer),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.face, size: 22, color: AppColors.lightTextPrimary),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Biometric Signature', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                    Text('Require Face ID confirmation on submit', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightOutline)),
                  ],
                ),
              ),
              Switch(value: _biometricEnabled, activeThumbColor: context.colors.primary, onChanged: (v) => setState(() => _biometricEnabled = v)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      children: [
        ScaleOnTap(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 18, color: context.colors.onPrimary),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Save Changes & Authorize Lock',
                    textAlign: TextAlign.center,
                    style: textTheme.labelMedium?.copyWith(color: context.colors.onPrimary, fontWeight: FontWeight.w700),
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
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.lightOutlineVariant)),
            child: Text(
              'Cancel & Retain Current Account',
              textAlign: TextAlign.center,
              style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 6,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.enhanced_encryption, size: 14, color: AppColors.lightOutline),
              const SizedBox(width: 4),
              Text('256-Bit SSL Encrypted', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightOutline)),
            ]),
            Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.verified, size: 14, color: AppColors.lightOutline),
              const SizedBox(width: 4),
              Text('SEC Nigeria Registered', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightOutline)),
            ]),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Zero-plaintext banking data retention. Bank details are tokenized with NIBSS & CBN-approved settlement custody rails.',
          textAlign: TextAlign.center,
          style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightOutline, height: 1.4),
        ),
      ],
    );
  }
}