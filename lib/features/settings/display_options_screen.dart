import 'package:homex/ui/global.dart';
class DisplayOptionsScreen extends StatefulWidget {
  const DisplayOptionsScreen({
    super.key,
    this.onBack,
    this.onSave,
  });

  final VoidCallback? onBack;
  final VoidCallback? onSave;

  @override
  State<DisplayOptionsScreen> createState() => _DisplayOptionsScreenState();
}

class _DisplayOptionsScreenState extends State<DisplayOptionsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _contentAnimation;

  DisplayTheme _theme = DisplayTheme.system;
  CurrencyOption _currency = CurrencyOption.ngn;
  MapLayer _mapLayer = MapLayer.architectural;

  bool _dualCurrency = true;
  bool _compactValues = true;
  bool _privacyMask = false;
  bool _wifiOnlyTours = true;

  bool _isSaving = false;
  bool _showSavedToast = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: AppAnimations.enter,
    );

    _contentAnimation = Tween<Offset>(
      begin: const Offset(0, 0.012),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.enter,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _savePreferences() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 350));

    if (!mounted) return;

    setState(() {
      _isSaving = false;
      _showSavedToast = true;
    });

    widget.onSave?.call();

    Future<void>.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) {
        setState(() {
          _showSavedToast = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final width = context.widthPx;
    final horizontalPadding = width < 360 ? 16.0 : 20.0;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Stack(
              children: [
                Column(
                  children: [
                    _DisplayOptionsHeader(
                      onBack: widget.onBack,
                      onSave: _savePreferences,
                    ),
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _contentAnimation,
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              SliverPadding(
                                padding: EdgeInsets.fromLTRB(
                                  horizontalPadding,
                                  20,
                                  horizontalPadding,
                                  32,
                                ),
                                sliver: SliverList(
                                  delegate: SliverChildListDelegate([
                                    _AppearanceSection(
                                      selectedTheme: _theme,
                                      onThemeChanged: (theme) {
                                        setState(() {
                                          _theme = theme;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    _CurrencySection(
                                      selectedCurrency: _currency,
                                      dualCurrency: _dualCurrency,
                                      onCurrencyChanged: (currency) {
                                        setState(() {
                                          _currency = currency;
                                        });
                                      },
                                      onDualCurrencyChanged: (value) {
                                        setState(() {
                                          _dualCurrency = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    _NumberFormattingSection(
                                      compactValues: _compactValues,
                                      privacyMask: _privacyMask,
                                      onCompactValuesChanged: (value) {
                                        setState(() {
                                          _compactValues = value;
                                        });
                                      },
                                      onPrivacyMaskChanged: (value) {
                                        setState(() {
                                          _privacyMask = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    _MapMediaSection(
                                      selectedLayer: _mapLayer,
                                      wifiOnlyTours: _wifiOnlyTours,
                                      onLayerChanged: (layer) {
                                        setState(() {
                                          _mapLayer = layer;
                                        });
                                      },
                                      onWifiOnlyChanged: (value) {
                                        setState(() {
                                          _wifiOnlyTours = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 18),
                                    _SavePreferencesButton(
                                      isSaving: _isSaving,
                                      onPressed: _savePreferences,
                                    ),
                                    const SizedBox(height: 14),
                                    const _RegulatoryDisclosure(),
                                    const SizedBox(height: 8),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Save confirmation toast.
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 20,
                  child: IgnorePointer(
                    ignoring: !_showSavedToast,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 220),
                      curve: AppAnimations.enter,
                      offset: _showSavedToast
                          ? Offset.zero
                          : const Offset(0, 0.12),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 180),
                        opacity: _showSavedToast ? 1 : 0,
                        child: _SavedToast(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// ENUMS
// -----------------------------------------------------------------------------

enum DisplayTheme {
  system,
  light,
  dark,
}

enum CurrencyOption {
  ngn,
  usd,
  gbp,
  eur,
}

enum MapLayer {
  architectural,
  satellite,
}

// -----------------------------------------------------------------------------
// HEADER
// -----------------------------------------------------------------------------

class _DisplayOptionsHeader extends StatelessWidget {
  const _DisplayOptionsHeader({
    required this.onBack,
    required this.onSave,
  });

  final VoidCallback? onBack;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest.withValues(alpha: 0.92),
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          _HeaderBackButton(
            onPressed:
            onBack ?? () => Navigator.maybePop(context),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Display Options',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'PREFERENCES',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: colors.onSurfaceVariant,
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Currency view (₦ NGN), System Theme',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.onSurfaceVariant,
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onSave,
            style: TextButton.styleFrom(
              foregroundColor: colors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Save',
              style: AppTextStyles.labelMedium.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderBackButton extends StatelessWidget {
  const _HeaderBackButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            Icons.arrow_back_rounded,
            color: colors.onSurface,
            size: 22,
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SECTION 1 — APPEARANCE
// -----------------------------------------------------------------------------

class _AppearanceSection extends StatelessWidget {
  const _AppearanceSection({
    required this.selectedTheme,
    required this.onThemeChanged,
  });

  final DisplayTheme selectedTheme;
  final ValueChanged<DisplayTheme> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.palette_outlined,
              size: 18,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Appearance Mode',
                style: AppTextStyles.titleSmall.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.circle,
              size: 6,
              color: colors.secondary,
            ),
            const SizedBox(width: 5),
            Text(
              'Auto-sync active',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ThemeOption(
                theme: DisplayTheme.system,
                selected: selectedTheme == DisplayTheme.system,
                title: 'System',
                subtitle: 'Follows OS',
                preview: _ThemePreview.system,
                onTap: () => onThemeChanged(DisplayTheme.system),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ThemeOption(
                theme: DisplayTheme.light,
                selected: selectedTheme == DisplayTheme.light,
                title: 'Light',
                subtitle: 'Daylight view',
                preview: _ThemePreview.light,
                onTap: () => onThemeChanged(DisplayTheme.light),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ThemeOption(
                theme: DisplayTheme.dark,
                selected: selectedTheme == DisplayTheme.dark,
                title: 'Dark',
                subtitle: 'OLED reduced',
                preview: _ThemePreview.dark,
                onTap: () => onThemeChanged(DisplayTheme.dark),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

enum _ThemePreview {
  system,
  light,
  dark,
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.theme,
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.preview,
    required this.onTap,
  });

  final DisplayTheme theme;
  final bool selected;
  final String title;
  final String subtitle;
  final _ThemePreview preview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: AppAnimations.smooth,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? colors.primary
                  : colors.outlineVariant.withValues(alpha: 0.5),
              width: selected ? 2 : 1,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ThemeMiniPreview(type: preview),
                  const SizedBox(height: 9),
                  Text(
                    title,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colors.onSurfaceVariant,
                      fontSize: 9.5,
                    ),
                  ),
                ],
              ),
              if (selected)
                Positioned(
                  top: -18,
                  right: -14,
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: colors.onPrimary,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeMiniPreview extends StatelessWidget {
  const _ThemeMiniPreview({
    required this.type,
  });

  final _ThemePreview type;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final isDark = type == _ThemePreview.dark;

    final background = isDark
        ? colors.inverseSurface
        : colors.surfaceContainerLowest;

    final barColor = isDark
        ? colors.surfaceContainer
        : colors.onSurface.withValues(alpha: 0.25);

    final lineColor = isDark
        ? colors.surfaceTint.withValues(alpha: 0.2)
        : colors.surfaceContainerHigh;

    final accent = type == _ThemePreview.system
        ? colors.secondaryContainer
        : type == _ThemePreview.dark
        ? colors.onTertiaryContainer
        : colors.outlineVariant;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      padding: const EdgeInsets.all(7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 24,
                height: 6,
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: lineColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 0.75,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: lineColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SECTION 2 — CURRENCY
// -----------------------------------------------------------------------------

class _CurrencySection extends StatelessWidget {
  const _CurrencySection({
    required this.selectedCurrency,
    required this.dualCurrency,
    required this.onCurrencyChanged,
    required this.onDualCurrencyChanged,
  });

  final CurrencyOption selectedCurrency;
  final bool dualCurrency;
  final ValueChanged<CurrencyOption> onCurrencyChanged;
  final ValueChanged<bool> onDualCurrencyChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.monetization_on_outlined,
              size: 18,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              'Base Valuation Currency',
              style: AppTextStyles.titleSmall.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Set reference currency for escrow settlements, dividend yield '
              'calculations, and fractional property allocations.',
          style: AppTextStyles.bodySmall.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12),
        _CurrencyList(
          selectedCurrency: selectedCurrency,
          onChanged: onCurrencyChanged,
        ),
        const SizedBox(height: 12),
        _DualCurrencyCard(
          enabled: dualCurrency,
          onChanged: onDualCurrencyChanged,
        ),
      ],
    );
  }
}

class _CurrencyList extends StatelessWidget {
  const _CurrencyList({
    required this.selectedCurrency,
    required this.onChanged,
  });

  final CurrencyOption selectedCurrency;
  final ValueChanged<CurrencyOption> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.6),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _CurrencyTile(
            value: CurrencyOption.ngn,
            selected: selectedCurrency == CurrencyOption.ngn,
            symbol: '₦',
            title: 'Nigerian Naira',
            badge: 'Primary',
            subtitle: 'NGN (₦) • Local Escrow Baseline',
            onTap: () => onChanged(CurrencyOption.ngn),
          ),
          _CurrencyDivider(),
          _CurrencyTile(
            value: CurrencyOption.usd,
            selected: selectedCurrency == CurrencyOption.usd,
            symbol: r'$',
            title: 'US Dollar',
            badge: 'Diaspora',
            subtitle: 'USD (\$) • 1 USD ≈ ₦1,485.50 (CBN)',
            onTap: () => onChanged(CurrencyOption.usd),
          ),
          _CurrencyDivider(),
          _CurrencyTile(
            value: CurrencyOption.gbp,
            selected: selectedCurrency == CurrencyOption.gbp,
            symbol: '£',
            title: 'British Pound',
            subtitle: 'GBP (£) • UK Corridor Index',
            onTap: () => onChanged(CurrencyOption.gbp),
          ),
          _CurrencyDivider(),
          _CurrencyTile(
            value: CurrencyOption.eur,
            selected: selectedCurrency == CurrencyOption.eur,
            symbol: '€',
            title: 'Euro',
            subtitle: 'EUR (€) • European Remittance',
            onTap: () => onChanged(CurrencyOption.eur),
          ),
        ],
      ),
    );
  }
}

class _CurrencyTile extends StatelessWidget {
  const _CurrencyTile({
    required this.value,
    required this.selected,
    required this.symbol,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.badge,
  });

  final CurrencyOption value;
  final bool selected;
  final String symbol;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: selected
          ? colors.surfaceContainerLowest
          : colors.surfaceContainerLowest,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: colors.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  symbol,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: selected
                        ? colors.primary
                        : colors.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: colors.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: badge == 'Primary'
                                  ? colors.primary
                                  : colors.surfaceContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              badge!,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: badge == 'Primary'
                                    ? colors.onPrimary
                                    : colors.onSurfaceVariant,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _RadioIndicator(selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencyDivider extends StatelessWidget {
  const _CurrencyDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: context.colors.outlineVariant.withValues(alpha: 0.3),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({
    required this.selected,
  });

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: AppAnimations.smooth,
      width: 17,
      height: 17,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected
              ? colors.primary
              : colors.outlineVariant,
          width: selected ? 5 : 1.5,
        ),
      ),
    );
  }
}

class _DualCurrencyCard extends StatelessWidget {
  const _DualCurrencyCard({
    required this.enabled,
    required this.onChanged,
  });

  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.6),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.currency_exchange_rounded,
            size: 20,
            color: colors.secondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _SettingDescription(
              title: 'Dual-Currency Valuation',
              description:
              'Displays synchronized ₦ NGN and \$ USD values side-by-side '
                  'on all deed contracts & escrow vouchers.',
            ),
          ),
          const SizedBox(width: 10),
          _HomeXSwitch(
            value: enabled,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SECTION 3 — NUMBERS & PRIVACY
// -----------------------------------------------------------------------------

class _NumberFormattingSection extends StatelessWidget {
  const _NumberFormattingSection({
    required this.compactValues,
    required this.privacyMask,
    required this.onCompactValuesChanged,
    required this.onPrivacyMaskChanged,
  });

  final bool compactValues;
  final bool privacyMask;
  final ValueChanged<bool> onCompactValuesChanged;
  final ValueChanged<bool> onPrivacyMaskChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.format_list_numbered_rounded,
              size: 18,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              'Financial Numbers & Privacy',
              style: AppTextStyles.titleSmall.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.6),
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _SettingToggleRow(
                title: 'Compact Values',
                description:
                'Render ₦450M instead of ₦450,000,000 on portfolio cards.',
                value: compactValues,
                onChanged: onCompactValuesChanged,
              ),
              Divider(
                height: 1,
                color: colors.outlineVariant.withValues(alpha: 0.3),
              ),
              _SettingToggleRow(
                title: 'Privacy Screen Mask',
                badge: 'Discreet',
                description:
                'Auto-blur escrow figures and asset values in public '
                    'spaces until tapped.',
                value: privacyMask,
                onChanged: onPrivacyMaskChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingToggleRow extends StatelessWidget {
  const _SettingToggleRow({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
    this.badge,
  });

  final String title;
  final String description;
  final bool value;
  final String? badge;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Expanded(
            child: _SettingDescription(
              title: title,
              description: description,
              badge: badge,
            ),
          ),
          const SizedBox(width: 12),
          _HomeXSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _SettingDescription extends StatelessWidget {
  const _SettingDescription({
    required this.title,
    required this.description,
    this.badge,
  });

  final String title;
  final String description;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            Text(
              title,
              style: AppTextStyles.labelMedium.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: colors.secondaryFixed,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge!,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.onSecondaryFixed,
                    fontSize: 8.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          description,
          style: AppTextStyles.labelSmall.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// SECTION 4 — MAP & MEDIA
// -----------------------------------------------------------------------------

class _MapMediaSection extends StatelessWidget {
  const _MapMediaSection({
    required this.selectedLayer,
    required this.wifiOnlyTours,
    required this.onLayerChanged,
    required this.onWifiOnlyChanged,
  });

  final MapLayer selectedLayer;
  final bool wifiOnlyTours;
  final ValueChanged<MapLayer> onLayerChanged;
  final ValueChanged<bool> onWifiOnlyChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.layers_outlined,
              size: 18,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              'Cartography & Media Density',
              style: AppTextStyles.titleSmall.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.6),
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Default Map Layer',
                style: AppTextStyles.labelMedium.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _MapLayerOption(
                      selected:
                      selectedLayer == MapLayer.architectural,
                      icon: Icons.domain_rounded,
                      title: 'Architectural',
                      subtitle: 'Street & Cadastral',
                      onTap: () {
                        onLayerChanged(MapLayer.architectural);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _MapLayerOption(
                      selected: selectedLayer == MapLayer.satellite,
                      icon: Icons.satellite_alt_rounded,
                      title: 'Satellite',
                      subtitle: 'Topographic GIS',
                      onTap: () {
                        onLayerChanged(MapLayer.satellite);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Divider(
                height: 1,
                color: colors.outlineVariant.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _SettingDescription(
                      title: '3D Virtual Tours Over Wi-Fi Only',
                      description:
                      'Optimize cellular bandwidth during site surveys.',
                    ),
                  ),
                  const SizedBox(width: 10),
                  _HomeXSwitch(
                    value: wifiOnlyTours,
                    onChanged: onWifiOnlyChanged,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapLayerOption extends StatelessWidget {
  const _MapLayerOption({
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: AppAnimations.smooth,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selected
                ? colors.surfaceContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: selected
                  ? colors.primary
                  : colors.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected
                    ? colors.primary
                    : colors.onSurfaceVariant,
                size: 17,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.onSurfaceVariant,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SWITCH
// -----------------------------------------------------------------------------

class _HomeXSwitch extends StatelessWidget {
  const _HomeXSwitch({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      button: true,
      toggled: value,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: AppAnimations.smooth,
          width: 44,
          height: 24,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: value
                ? colors.primary
                : colors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(999),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            curve: AppAnimations.smooth,
            alignment: value
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                shape: BoxShape.circle,
                border: Border.all(
                  color: value
                      ? colors.surfaceContainerLowest
                      : colors.outlineVariant,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SAVE BUTTON
// -----------------------------------------------------------------------------

class _SavePreferencesButton extends StatelessWidget {
  const _SavePreferencesButton({
    required this.isSaving,
    required this.onPressed,
  });

  final bool isSaving;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isSaving ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.primary.withValues(
            alpha: 0.7,
          ),
          disabledForegroundColor: colors.onPrimary,
          elevation: 2,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          switchInCurve: AppAnimations.enter,
          switchOutCurve: AppAnimations.exit,
          child: isSaving
              ? const SizedBox(
            key: ValueKey('saving'),
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : Row(
            key: const ValueKey('save'),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Save Preferences',
                style: AppTextStyles.labelMedium.copyWith(
                  color: colors.onPrimary,
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

// -----------------------------------------------------------------------------
// REGULATORY DISCLOSURE
// -----------------------------------------------------------------------------

class _RegulatoryDisclosure extends StatelessWidget {
  const _RegulatoryDisclosure();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_user_rounded,
                size: 13,
                color: colors.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 6),
              Text(
                'CBN / NAFEM MONITORED',
                style: AppTextStyles.labelSmall.copyWith(
                  color:
                  colors.onSurfaceVariant.withValues(alpha: 0.7),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Currency conversions are indicative based on official '
                'CBN / NAFEM closing rates. All statutory escrow settlements '
                'and real estate deeds of assignment are legally finalized '
                'in Nigerian Naira (NGN).',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall.copyWith(
              color:
              colors.onSurfaceVariant.withValues(alpha: 0.8),
              fontSize: 9.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SAVE TOAST
// -----------------------------------------------------------------------------

class _SavedToast extends StatelessWidget {
  const _SavedToast();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(9),
      color: colors.inverseSurface,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 11,
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: colors.tertiaryFixed,
              size: 17,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Display preferences updated',
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.onInverseSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              'Live',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.onInverseSurface.withValues(
                  alpha: 0.7,
                ),
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}