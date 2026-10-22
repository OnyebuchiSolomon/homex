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

class _DisplayOptionsScreenState extends State<DisplayOptionsScreen> {
  // ============================================================
  // STATE
  // ============================================================

  String _appearanceMode = 'system';
  String _currency = 'NGN';
  String _mapLayer = 'cadastral';

  bool _dualCurrency = true;
  bool _compactValues = true;
  bool _privacyMask = false;
  bool _wifiOnlyTours = true;

  bool _showSavedMessage = false;

  // ============================================================
  // SAVE
  // ============================================================

  void _savePreferences() {
    setState(() {
      _showSavedMessage = true;
    });

    widget.onSave?.call();

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;

      setState(() {
        _showSavedMessage = false;
      });
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 448,
                ),
                child: Column(
                  children: [
                    _buildAppBar(
                      colors,
                      textTheme,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          20,
                          16,
                          40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildAppearanceSection(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 24),
                            _buildCurrencySection(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 24),
                            _buildFinancialSection(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 24),
                            _buildMapSection(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 18),
                            _buildSaveButton(
                              colors,
                              textTheme,
                            ),
                            const SizedBox(height: 16),
                            _buildDisclosure(
                              colors,
                              textTheme,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_showSavedMessage)
              _buildToast(
                colors,
                textTheme,
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  Widget _buildAppBar(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest.withValues(
          alpha: 0.92,
        ),
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withValues(
              alpha: 0.40,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _CircleIconButton(
              icon: Icons.arrow_back_rounded,
              onTap: widget.onBack ??
                      () {
                    Navigator.of(context).maybePop();
                  },
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
                          style: textTheme.titleMedium?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            height: 1.15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _SmallBadge(
                        label: 'PREFERENCES',
                        backgroundColor:
                        colors.surfaceContainer,
                        foregroundColor:
                        colors.onSurfaceVariant,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Currency view (₦ NGN), System Theme',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontSize: 11,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: _savePreferences,
              style: TextButton.styleFrom(
                foregroundColor: colors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
                tapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Save',
                style: textTheme.labelMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // APPEARANCE
  // ============================================================

  Widget _buildAppearanceSection(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return _Section(
      title: 'Appearance Mode',
      icon: Icons.palette_outlined,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: colors.secondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            'Auto-sync active',
            style: textTheme.labelSmall?.copyWith(
              color: colors.secondary,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    ).withChild(
      Column(
        children: [
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ThemeOptionCard(
                  title: 'System',
                  subtitle: 'Follows OS',
                  icon: Icons.settings_suggest_outlined,
                  selected: _appearanceMode == 'system',
                  colors: colors,
                  textTheme: textTheme,
                  preview: _ThemePreview.system(
                    colors,
                  ),
                  onTap: () {
                    setState(() {
                      _appearanceMode = 'system';
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ThemeOptionCard(
                  title: 'Light',
                  subtitle: 'Daylight view',
                  icon: Icons.light_mode_outlined,
                  selected: _appearanceMode == 'light',
                  colors: colors,
                  textTheme: textTheme,
                  preview: _ThemePreview.light(
                    colors,
                  ),
                  onTap: () {
                    setState(() {
                      _appearanceMode = 'light';
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ThemeOptionCard(
                  title: 'Dark',
                  subtitle: 'OLED reduced',
                  icon: Icons.dark_mode_outlined,
                  selected: _appearanceMode == 'dark',
                  colors: colors,
                  textTheme: textTheme,
                  preview: _ThemePreview.dark(
                    colors,
                  ),
                  onTap: () {
                    setState(() {
                      _appearanceMode = 'dark';
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CURRENCY
  // ============================================================

  Widget _buildCurrencySection(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(
          title: 'Base Valuation Currency',
          icon: Icons.monetization_on_outlined,
          colors: colors,
          textTheme: textTheme,
        ),
        const SizedBox(height: 4),
        Text(
          'Set reference currency for escrow settlements, '
              'dividend yield calculations, and fractional property allocations.',
          style: textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12),
        _CardContainer(
          colors: colors,
          child: Column(
            children: [
              _CurrencyOption(
                symbol: '₦',
                title: 'Nigerian Naira',
                subtitle: 'NGN (₦) • Local Escrow Baseline',
                badge: 'Primary',
                selected: _currency == 'NGN',
                colors: colors,
                textTheme: textTheme,
                onTap: () {
                  setState(() {
                    _currency = 'NGN';
                  });
                },
              ),
              _Divider(colors: colors),
              _CurrencyOption(
                symbol: r'$',
                title: 'US Dollar',
                subtitle: 'USD (\$) • 1 USD ≈ ₦1,485.50 (CBN)',
                badge: 'Diaspora',
                selected: _currency == 'USD',
                colors: colors,
                textTheme: textTheme,
                onTap: () {
                  setState(() {
                    _currency = 'USD';
                  });
                },
              ),
              _Divider(colors: colors),
              _CurrencyOption(
                symbol: '£',
                title: 'British Pound',
                subtitle: 'GBP (£) • UK Corridor Index',
                selected: _currency == 'GBP',
                colors: colors,
                textTheme: textTheme,
                onTap: () {
                  setState(() {
                    _currency = 'GBP';
                  });
                },
              ),
              _Divider(colors: colors),
              _CurrencyOption(
                symbol: '€',
                title: 'Euro',
                subtitle: 'EUR (€) • European Remittance',
                selected: _currency == 'EUR',
                colors: colors,
                textTheme: textTheme,
                onTap: () {
                  setState(() {
                    _currency = 'EUR';
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _ToggleCard(
          icon: Icons.currency_exchange_rounded,
          title: 'Dual-Currency Valuation',
          description:
          'Displays synchronized ₦ NGN and \$ USD values side-by-side '
              'on all deed contracts & escrow vouchers.',
          value: _dualCurrency,
          colors: colors,
          textTheme: textTheme,
          accentColor: colors.secondary,
          onChanged: (value) {
            setState(() {
              _dualCurrency = value;
            });
          },
        ),
      ],
    );
  }

  // ============================================================
  // FINANCIAL
  // ============================================================

  Widget _buildFinancialSection(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(
          title: 'Financial Numbers & Privacy',
          icon: Icons.format_list_numbered_rounded,
          colors: colors,
          textTheme: textTheme,
        ),
        const SizedBox(height: 12),
        _CardContainer(
          colors: colors,
          child: Column(
            children: [
              _SettingRow(
                title: 'Compact Values',
                description: RichText(
                  text: TextSpan(
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontSize: 11,
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Render ',
                      ),
                      TextSpan(
                        text: '₦450M',
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(
                        text: ' instead of ',
                      ),
                      TextSpan(
                        text: '₦450,000,000',
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(
                        text: ' on portfolio cards.',
                      ),
                    ],
                  ),
                ),
                value: _compactValues,
                colors: colors,
                textTheme: textTheme,
                onChanged: (value) {
                  setState(() {
                    _compactValues = value;
                  });
                },
              ),
              _Divider(colors: colors),
              _SettingRow(
                title: 'Privacy Screen Mask',
                badge: 'Discreet',
                description: Text(
                  'Auto-blur escrow figures and asset values in public '
                      'spaces until tapped.',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
                value: _privacyMask,
                colors: colors,
                textTheme: textTheme,
                onChanged: (value) {
                  setState(() {
                    _privacyMask = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MAP / MEDIA
  // ============================================================

  Widget _buildMapSection(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(
          title: 'Cartography & Media Density',
          icon: Icons.layers_outlined,
          colors: colors,
          textTheme: textTheme,
        ),
        const SizedBox(height: 12),
        _CardContainer(
          colors: colors,
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Default Map Layer',
                style: textTheme.labelMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _MapLayerOption(
                      icon: Icons.domain_outlined,
                      title: 'Architectural',
                      subtitle: 'Street & Cadastral',
                      selected: _mapLayer == 'cadastral',
                      colors: colors,
                      textTheme: textTheme,
                      onTap: () {
                        setState(() {
                          _mapLayer = 'cadastral';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _MapLayerOption(
                      icon: Icons.satellite_alt_outlined,
                      title: 'Satellite',
                      subtitle: 'Topographic GIS',
                      selected: _mapLayer == 'satellite',
                      colors: colors,
                      textTheme: textTheme,
                      onTap: () {
                        setState(() {
                          _mapLayer = 'satellite';
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 1,
                color: colors.outlineVariant.withValues(
                  alpha: 0.30,
                ),
              ),
              const SizedBox(height: 12),
              _SettingRow(
                title: '3D Virtual Tours Over Wi-Fi Only',
                description: Text(
                  'Optimize cellular bandwidth during site surveys.',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
                value: _wifiOnlyTours,
                colors: colors,
                textTheme: textTheme,
                onChanged: (value) {
                  setState(() {
                    _wifiOnlyTours = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SAVE BUTTON
  // ============================================================

  Widget _buildSaveButton(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return SizedBox(
      height: 48,
      child: FilledButton.icon(
        onPressed: _savePreferences,
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(color: colors.outlineVariant,),
          elevation: 2,
        ),
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          size: 18,
        ),
        label: Text(
          'Save Preferences',
          style: textTheme.labelLarge?.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DISCLOSURE
  // ============================================================

  Widget _buildDisclosure(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        8,
        0,
        8,
        16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: 13,
                color: colors.onSurfaceVariant.withValues(
                  alpha: 0.70,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  'CBN / NAFEM MONITORED',
                  textAlign: TextAlign.center,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant.withValues(
                      alpha: 0.70,
                    ),
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Currency conversions are indicative based on official '
                'CBN / NAFEM closing rates. All statutory escrow settlements '
                'and real estate deeds of assignment are legally finalized '
                'in Nigerian Naira (NGN).',
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant.withValues(
                alpha: 0.80,
              ),
              fontSize: 10,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TOAST
  // ============================================================

  Widget _buildToast(
      ColorScheme colors,
      TextTheme textTheme,
      ) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: IgnorePointer(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 360,
            ),
            child: AnimatedOpacity(
              opacity: _showSavedMessage ? 1 : 0,
              duration: const Duration(milliseconds: 180),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: colors.inverseSurface,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withValues(
                        alpha: 0.20,
                      ),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 17,
                      color: colors.tertiaryFixed,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Display preferences updated',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onInverseSurface,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Live',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onInverseSurface.withValues(
                          alpha: 0.70,
                        ),
                        fontSize: 10,
                      ),
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

// ============================================================================
// SECTION
// ============================================================================

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.icon,
    required this.trailing,
  });

  final String title;
  final IconData icon;
  final Widget trailing;

  Widget withChild(Widget child) {
    return _SectionWrapper(
      title: title,
      icon: icon,
      trailing: trailing,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _SectionWrapper extends StatelessWidget {
  const _SectionWrapper({
    required this.title,
    required this.icon,
    required this.trailing,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: textTheme.titleSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: -0.1,
                ),
              ),
            ),
            trailing,
          ],
        ),
        child,
      ],
    );
  }
}

// ============================================================================
// SECTION HEADER
// ============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.colors,
    required this.textTheme,
  });

  final String title;
  final IconData icon;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: colors.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: textTheme.titleSmall?.copyWith(
             // color: colors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// CARD CONTAINER
// ============================================================================

class _CardContainer extends StatelessWidget {
  const _CardContainer({
    required this.colors,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  final ColorScheme colors;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(
            alpha: 0.60,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(
              alpha: 0.04,
            ),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ============================================================================
// THEME OPTION
// ============================================================================

class _ThemeOptionCard extends StatelessWidget {
  const _ThemeOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.colors,
    required this.textTheme,
    required this.preview,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final ColorScheme colors;
  final TextTheme textTheme;
  final Widget preview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? colors.primary
                  : colors.outlineVariant.withValues(
                alpha: 0.50,
              ),
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
              BoxShadow(
                color: colors.shadow.withValues(
                  alpha: 0.05,
                ),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ]
                : null,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 64,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: preview,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    title,
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              if (selected)
                Positioned(
                  top: -3,
                  right: -3,
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 12,
                      color: colors.onPrimary,
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

// ============================================================================
// THEME PREVIEW
// ============================================================================

class _ThemePreview {
  static Widget system(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            colors.surfaceContainerHigh,
            colors.surfaceContainer,
            colors.surfaceContainerLowest,
          ],
        ),
        border: Border.all(
          color: colors.outlineVariant.withValues(
            alpha: 0.40,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PreviewBar(
                width: 24,
                color: colors.primary.withValues(
                  alpha: 0.40,
                ),
              ),
              _PreviewDot(
                color: colors.secondaryContainer,
              ),
            ],
          ),
          Column(
            children: [
              _PreviewLine(
                color: colors.surfaceContainerHighest,
              ),
              const SizedBox(height: 4),
              _PreviewLine(
                widthFactor: 0.75,
                color: colors.surfaceContainerHighest,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget light(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border.all(
          color: colors.outlineVariant.withValues(
            alpha: 0.40,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PreviewBar(
                width: 24,
                color: colors.onSurface.withValues(
                  alpha: 0.30,
                ),
              ),
              _PreviewDot(
                color: colors.outlineVariant,
              ),
            ],
          ),
          Column(
            children: [
              _PreviewLine(
                color: colors.surfaceContainerLow,
              ),
              const SizedBox(height: 4),
              _PreviewLine(
                widthFactor: 0.75,
                color: colors.surfaceContainerLow,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget dark(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colors.inverseSurface,
        border: Border.all(
          color: colors.outlineVariant.withValues(
            alpha: 0.30,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PreviewBar(
                width: 24,
                color: colors.surfaceContainer.withValues(
                  alpha: 0.50,
                ),
              ),
              _PreviewDot(
                color: colors.onTertiaryContainer,
              ),
            ],
          ),
          Column(
            children: [
              _PreviewLine(
                color: colors.surfaceTint.withValues(
                  alpha: 0.20,
                ),
              ),
              const SizedBox(height: 4),
              _PreviewLine(
                widthFactor: 0.75,
                color: colors.surfaceTint.withValues(
                  alpha: 0.20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreviewBar extends StatelessWidget {
  const _PreviewBar({
    required this.width,
    required this.color,
  });

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _PreviewDot extends StatelessWidget {
  const _PreviewDot({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _PreviewLine extends StatelessWidget {
  const _PreviewLine({
    required this.color,
    this.widthFactor = 1,
  });

  final Color color;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: Alignment.centerLeft,
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

// ============================================================================
// CURRENCY OPTION
// ============================================================================

class _CurrencyOption extends StatelessWidget {
  const _CurrencyOption({
    required this.symbol,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.colors,
    required this.textTheme,
    required this.onTap,
    this.badge,
  });

  final String symbol;
  final String title;
  final String subtitle;
  final bool selected;
  final String? badge;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: selected
                      ? colors.surfaceContainer
                      : colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colors.outlineVariant.withValues(
                      alpha: 0.40,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  symbol,
                  style: textTheme.titleMedium?.copyWith(
                    color: selected
                        ? colors.primary
                        : colors.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
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
                            style: textTheme.labelMedium?.copyWith(
                              color: colors.onSurface,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 6),
                          _SmallBadge(
                            label: badge!,
                            backgroundColor: badge == 'Primary'
                                ? colors.primary
                                : colors.surfaceContainer,
                            foregroundColor: badge == 'Primary'
                                ? colors.onPrimary
                                : colors.onSurfaceVariant,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _RadioIndicator(
                selected: selected,
                colors: colors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// TOGGLE CARD
// ============================================================================

class _ToggleCard extends StatelessWidget {
  const _ToggleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.value,
    required this.colors,
    required this.textTheme,
    required this.accentColor,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool value;
  final ColorScheme colors;
  final TextTheme textTheme;
  final Color accentColor;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outlineVariant.withValues(
            alpha: 0.60,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(
              alpha: 0.04,
            ),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: accentColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _HomeXSwitch(
            value: value,
            colors: colors,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SETTING ROW
// ============================================================================

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.title,
    required this.description,
    required this.value,
    required this.colors,
    required this.textTheme,
    required this.onChanged,
    this.badge,
  });

  final String title;
  final Widget description;
  final bool value;
  final ColorScheme colors;
  final TextTheme textTheme;
  final ValueChanged<bool> onChanged;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: textTheme.labelMedium?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: 6),
                      _SmallBadge(
                        label: badge!,
                        backgroundColor: colors.secondaryFixed,
                        foregroundColor:
                        colors.onSecondaryFixed,
                        small: true,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                description,
              ],
            ),
          ),
          const SizedBox(width: 12),
          _HomeXSwitch(
            value: value,
            colors: colors,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// MAP LAYER
// ============================================================================

class _MapLayerOption extends StatelessWidget {
  const _MapLayerOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.colors,
    required this.textTheme,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selected
                ? colors.surfaceContainer
                : colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? colors.primary
                  : colors.outlineVariant.withValues(
                alpha: 0.50,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: selected
                    ? colors.primary
                    : colors.onSurfaceVariant,
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
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontSize: 10,
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

// ============================================================================
// SWITCH
// ============================================================================

class _HomeXSwitch extends StatelessWidget {
  const _HomeXSwitch({
    required this.value,
    required this.colors,
    required this.onChanged,
  });

  final bool value;
  final ColorScheme colors;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: colors.onPrimary,
      activeTrackColor: colors.primary,
      inactiveThumbColor: colors.onSurfaceVariant,
      inactiveTrackColor: colors.surfaceContainerHigh,
      trackOutlineColor: WidgetStateProperty.resolveWith(
            (states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }

          return colors.outlineVariant;
        },
      ),
    );
  }
}

// ============================================================================
// RADIO
// ============================================================================

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({
    required this.selected,
    required this.colors,
  });

  final bool selected;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 18,
      height: 18,
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

// ============================================================================
// BADGE
// ============================================================================

class _SmallBadge extends StatelessWidget {
  const _SmallBadge({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.small = false,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 5 : 6,
        vertical: small ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          small ? 4 : 5,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: textTheme.labelSmall?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w700,
          fontSize: small ? 9 : 10,
          letterSpacing: small ? 0.4 : 0.7,
        ),
      ),
    );
  }
}

// ============================================================================
// DIVIDER
// ============================================================================

class _Divider extends StatelessWidget {
  const _Divider({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: colors.outlineVariant.withValues(
        alpha: 0.30,
      ),
    );
  }
}

// ============================================================================
// CIRCLE BUTTON
// ============================================================================

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            icon,
            size: 22,
            color: colors.onSurface,
          ),
        ),
      ),
    );
  }
}