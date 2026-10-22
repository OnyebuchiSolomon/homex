import 'package:homex/ui/global.dart';
class _BankOption {
  final String code;
  final String name;
  final String subtitle;

  const _BankOption({required this.code, required this.name, required this.subtitle});
}

class AuthLinkSettlementBankScreen extends StatefulWidget {
  const AuthLinkSettlementBankScreen({super.key});

  @override
  State<AuthLinkSettlementBankScreen> createState() => _AuthLinkSettlementBankScreenState();
}

class _AuthLinkSettlementBankScreenState extends State<AuthLinkSettlementBankScreen> {
  int _accountType = 0; // 0 savings, 1 corporate
  int _selectedBank = 0;
  final TextEditingController _nubanController = TextEditingController(text: '0124893910');

  static const List<_BankOption> _banks = [
    _BankOption(code: 'GTB', name: 'GTBank', subtitle: 'Guaranty Trust'),
    _BankOption(code: 'ACC', name: 'Access Bank', subtitle: 'Access Corp'),
    _BankOption(code: 'ZEN', name: 'Zenith Bank', subtitle: 'Zenith Plc'),
    _BankOption(code: 'PRV', name: 'Providus', subtitle: 'Commercial'),
  ];

  @override
  void dispose() {
    _nubanController.dispose();
    super.dispose();
  }

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
                padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeIn(child: _buildIntroSection(context)),
                    const SizedBox(height: 20),
                    SlideFadeIn(child: _buildAccountTypeSwitch(context)),
                    const SizedBox(height: 20),
                    SlideFadeIn(delay: AppAnimations.shortDelay, child: _buildBankSelector(context)),
                    const SizedBox(height: 16),
                    _buildNubanField(context),
                    const SizedBox(height: 20),
                    ScrollReveal(child: _buildTrustCallout(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildFooterActions(context, hPad),
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
          ScaleOnTap(onTap: () => Navigator.of(context).maybePop(), child: Icon(Icons.arrow_back, color: cs.onSurface)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Text('Link Bank Account', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 6, height: 6, decoration: BoxDecoration(color: cs.secondaryContainer, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text('DIRECT NIBSS PAYOUT', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.secondary, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
          ScaleOnTap(onTap: () {}, child: Icon(Icons.help_outline, size: 22, color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildIntroSection(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: cs.surfaceContainerHigh, borderRadius: BorderRadius.circular(999)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.verified_user, size: 14, color: cs.secondary),
            const SizedBox(width: 5),
            Text('SEC & NDIC Insured Rails', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
          ]),
        ),
        const SizedBox(height: 10),
        Text('Link Settlement Bank', style: tt.headlineMedium?.copyWith(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          'Connect your personal or institutional Nigerian bank account for automated, zero-fee escrow settlements and direct deal payouts.',
          style: tt.bodyMedium?.copyWith(fontSize: 13, color: cs.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5))),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: cs.primaryContainer, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text('AM', style: tt.labelSmall?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('VERIFIED BENEFICIARY', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline, letterSpacing: 0.4)),
                    Row(children: [
                      Flexible(child: Text('Alexander Magnus', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                      const SizedBox(width: 4),
                      Icon(Icons.check_circle, size: 15, color: cs.secondary),
                    ]),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(4)),
                child: Text('Tier 1 BVN', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountTypeSwitch(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    final options = [
      [Icons.person, 'Savings / Individual'],
      [Icons.domain, 'Corporate Current'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ACCOUNT TYPE', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.outline, letterSpacing: 0.4)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: cs.surfaceContainer, borderRadius: BorderRadius.circular(14), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
          child: Row(
            children: List.generate(2, (i) {
              final selected = _accountType == i;
              return Expanded(
                child: ScaleOnTap(
                  onTap: () => setState(() => _accountType = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: selected ? cs.surfaceContainerLowest : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: selected ? const [BoxShadow(color: Color(0x0D000000), blurRadius: 4)] : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(options[i][0] as IconData, size: 16, color: selected ? cs.onSurface : cs.onSurfaceVariant),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            options[i][1] as String,
                            style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: selected ? FontWeight.w700 : FontWeight.w500, color: selected ? cs.onSurface : cs.onSurfaceVariant),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildBankSelector(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SELECT BANK', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.outline, letterSpacing: 0.4)),
            ScaleOnTap(
              onTap: () {},
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text('All Banks', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.secondary, fontWeight: FontWeight.w600)),
                Icon(Icons.chevron_right, size: 14, color: cs.secondary),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 62,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _banks.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final selected = _selectedBank == i;
              final bank = _banks[i];
              return ScaleOnTap(
                onTap: () => setState(() => _selectedBank = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: selected ? cs.primary : cs.outlineVariant.withValues(alpha: 0.6), width: selected ? 2 : 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(color: selected ? cs.primaryContainer : cs.surfaceContainer, borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: Text(bank.code, style: tt.labelSmall?.copyWith(fontSize: 9, fontWeight: FontWeight.w800, color: selected ? cs.onPrimary : cs.onSurfaceVariant)),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(bank.name, style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: selected ? FontWeight.w800 : FontWeight.w600)),
                          Text(bank.subtitle, style: tt.labelSmall?.copyWith(fontSize: 9, color: cs.outline)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNubanField(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('10-DIGIT NUBAN NUMBER', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.outline, letterSpacing: 0.4)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: cs.outlineVariant)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Icon(Icons.account_balance, size: 20, color: cs.onSurfaceVariant),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _nubanController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: 1.2),
                  decoration: const InputDecoration(border: InputBorder.none, isCollapsed: true, counterText: '', contentPadding: EdgeInsets.symmetric(vertical: 14)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(color: cs.secondaryFixed, borderRadius: BorderRadius.circular(4)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.check, size: 12, color: cs.onSecondaryFixedVariant),
                  const SizedBox(width: 3),
                  Text('VALID', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSecondaryFixedVariant, fontWeight: FontWeight.w800)),
                ]),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Pulse(
                    duration: const Duration(milliseconds: 1400),
                    child: Container(width: 10, height: 10, decoration: BoxDecoration(color: cs.onTertiaryContainer.withValues(alpha: 0.5), shape: BoxShape.circle)),
                  ),
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: cs.onTertiaryContainer, shape: BoxShape.circle)),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant),
                    children: [
                      const TextSpan(text: '100% NIBSS Match: '),
                      TextSpan(text: 'Alexander Magnus', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                    ],
                  ),
                ),
              ),
              Icon(Icons.check_circle, size: 18, color: cs.onTertiaryContainer),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrustCallout(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(16), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.security, size: 18, color: cs.secondary),
            const SizedBox(width: 8),
            Text('INSTITUTIONAL ESCROW PROTOCOLS', style: tt.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
          ]),
          const SizedBox(height: 8),
          Text(
            'Instant NIBSS Name Resolution • 256-bit AES banking encryption • Payouts protected under SEC Rule 184(b) Escrow Governance.',
            style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.5),
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.3)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.lock, size: 12, color: cs.outline),
                const SizedBox(width: 4),
                Text('Zero Third-Party Routing', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline)),
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.bolt, size: 12, color: cs.outline),
                const SizedBox(width: 4),
                Text('Instant Liquidity', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline)),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterActions(BuildContext context, double hPad) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, border: Border(top: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.3)))),
      padding: EdgeInsets.fromLTRB(hPad, 14, hPad, context.bottomPadding + 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleOnTap(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 17, color: cs.onPrimary),
                  const SizedBox(width: 8),
                  Text('Link Settlement Account', style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          ScaleOnTap(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text("Skip for Now / I'll Link Later", style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: cs.onSurfaceVariant)),
            ),
          ),
        ],
      ),
    );
  }
}