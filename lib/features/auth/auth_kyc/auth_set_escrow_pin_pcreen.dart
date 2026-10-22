import 'package:homex/ui/global.dart';
class AuthSetEscrowPinScreen extends StatefulWidget {
  const AuthSetEscrowPinScreen({super.key});

  @override
  State<AuthSetEscrowPinScreen> createState() => _AuthSetEscrowPinScreenState();
}

class _AuthSetEscrowPinScreenState extends State<AuthSetEscrowPinScreen> {
  static const int _maxLength = 6;
  String _pin = '';
  bool _isVisible = false;
  bool _biometricEnabled = true;

  void _addDigit(String digit) {
    if (_pin.length < _maxLength) {
      setState(() => _pin += digit);
    }
  }

  void _backspace() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  void _submit() {
    if (_pin.length == _maxLength) {
      // Hook up PIN submission / navigation here.
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN saved & confirmed')));
    }
  }

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 16;
    if (w < 400) return 20;
    return 24;
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colors;
    final hPad = _hPad(context);
    final canSubmit = _pin.length == _maxLength;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 8),
                child: Column(
                  children: [
                    _buildHeroIntro(context),
                    const SizedBox(height: 24),
                    _buildPinCells(context),
                    const SizedBox(height: 8),
                    _buildVisibilityToggle(context),
                    const SizedBox(height: 20),
                    _buildSecurityStandards(context),
                    const SizedBox(height: 10),
                    _buildBiometricBanner(context),
                  ],
                ),
              ),
            ),
            _buildKeypadArea(context, hPad, canSubmit),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  Widget _buildHeader(BuildContext context, double hPad) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScaleOnTap(onTap: () => Navigator.of(context).maybePop(), child: Icon(Icons.arrow_back, color: cs.onSurface)),
          Text('Security & PIN', style: tt.headlineSmall),
          ScaleOnTap(onTap: () {}, child: Icon(Icons.help_outline, color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildHeroIntro(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
          alignment: Alignment.center,
          child: Icon(Icons.shield, size: 26, color: cs.onPrimaryContainer),
        ),
        const SizedBox(height: 10),
        Text('Create Your Escrow PIN', textAlign: TextAlign.center, style: tt.headlineMedium?.copyWith(fontSize: 22)),
        const SizedBox(height: 6),
        Text(
          'Enter a 6-digit PIN to authorize high-value property offers, escrow locks, and wallet disbursements.',
          textAlign: TextAlign.center,
          style: tt.bodyMedium?.copyWith(fontSize: 13, color: cs.onSurfaceVariant, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildPinCells(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Row(
            children: List.generate(_maxLength, (i) {
              final filled = i < _pin.length;
              final isCursor = i == _pin.length;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == _maxLength - 1 ? 0 : 8),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (filled || isCursor) ? cs.secondary : cs.outlineVariant.withValues(alpha: 0.6),
                          width: (filled || isCursor) ? 2 : 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: filled
                          ? (_isVisible
                          ? Text(_pin[i], style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w700))
                          : Container(width: 10, height: 10, decoration: BoxDecoration(color: cs.secondary, shape: BoxShape.circle)))
                          : null,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildVisibilityToggle(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Center(
      child: ScaleOnTap(
        onTap: () => setState(() => _isVisible = !_isVisible),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_isVisible ? Icons.visibility_off : Icons.visibility, size: 16, color: cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Text(_isVisible ? 'Hide PIN' : 'View PIN', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityStandards(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    final items = [
      [Icons.check_circle, cs.onTertiaryContainer, 'Must be exactly 6 numeric digits'],
      [Icons.info, cs.outline, 'Avoid consecutive or repeated patterns (e.g. 123456, 111111)'],
      [Icons.lock_clock, cs.outline, 'Must not match your birth year or BVN sequence'],
    ];

    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4))),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SECURITY STANDARDS', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, letterSpacing: 0.4, fontWeight: FontWeight.w700)),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: cs.onTertiaryContainer, shape: BoxShape.circle)),
                const SizedBox(width: 4),
                Text('Encrypted', style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onTertiaryContainer, fontWeight: FontWeight.w600)),
              ]),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map((it) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(it[0] as IconData, size: 14, color: it[1] as Color),
                const SizedBox(width: 8),
                Expanded(child: Text(it[2] as String, style: tt.labelSmall?.copyWith(fontSize: 11, color: cs.onSurfaceVariant, height: 1.4))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBiometricBanner(BuildContext context) {
    final cs = context.colors;
    final tt = context.textTheme;
    return Container(
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(14), border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3))),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: cs.surfaceContainerLowest, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Icon(Icons.fingerprint, size: 18, color: cs.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Enable Biometric Authorization', style: tt.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                Text('Face ID / Touch ID quick authorization', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          Switch(value: _biometricEnabled, activeThumbColor: cs.primary, onChanged: (v) => setState(() => _biometricEnabled = v)),
        ],
      ),
    );
  }

  Widget _buildKeypadArea(BuildContext context, double hPad, bool canSubmit) {
    final cs = context.colors;
    final tt = context.textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 8, hPad, context.bottomPadding + 12),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.7,
              children: [
                for (final d in ['1', '2', '3', '4', '5', '6', '7', '8', '9']) _keypadButton(context, label: d, onTap: () => _addDigit(d)),
                _keypadIconButton(context, icon: Icons.fingerprint, onTap: () {}),
                _keypadButton(context, label: '0', onTap: () => _addDigit('0')),
                _keypadIconButton(context, icon: Icons.backspace, onTap: _backspace),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Opacity(
              opacity: canSubmit ? 1 : 0.4,
              child: ScaleOnTap(
                onTap: canSubmit ? _submit : () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(12),border: Border.all(color: cs.outlineVariant)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Save & Confirm PIN', style: tt.labelMedium?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 17, color: cs.onPrimary),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 2,
            children: [
              Icon(Icons.verified_user, size: 12, color: cs.onTertiaryContainer),
              Text('Secured with 256-bit bank-grade encryption', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline)),
              Text('•', style: TextStyle(color: cs.outlineVariant)),
              Text('NDIC & SEC compliant escrow rails', style: tt.labelSmall?.copyWith(fontSize: 10, color: cs.outline)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _keypadButton(BuildContext context, {required String label, required VoidCallback onTap}) {
    final cs = context.colors;
    final tt = context.textTheme;
    return ScaleOnTap(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
        ),
        alignment: Alignment.center,
        child: Text(label, style: tt.headlineSmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _keypadIconButton(BuildContext context, {required IconData icon, required VoidCallback onTap}) {
    final cs = context.colors;
    return ScaleOnTap(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Icon(icon, size: 24, color: cs.onSurfaceVariant),
      ),
    );
  }
}