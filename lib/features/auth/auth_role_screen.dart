import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class _RoleOption {
  final String id;
  final IconData icon;
  final String title;
  final String badge;
  final String description;

  const _RoleOption({
    required this.id,
    required this.icon,
    required this.title,
    required this.badge,
    required this.description,
  });
}

class ChooseYourRoleScreen extends StatefulWidget {
  const ChooseYourRoleScreen({
    super.key,
  });

  @override
  State<ChooseYourRoleScreen> createState() =>
      _ChooseYourRoleScreenState();
}

class _ChooseYourRoleScreenState
    extends State<ChooseYourRoleScreen> {
  // ============================================================
  // SELECTED ROLES
  // ============================================================

  Set<String> _selectedRoles = {
    'lawyer',
    'manager',
  };

  // ============================================================
  // ROLE DEFINITIONS
  // ============================================================

  static const List<_RoleOption> _roles = [
    _RoleOption(
      id: 'lawyer',
      icon: Icons.gavel_rounded,
      title: 'Lawyer',
      badge: 'Legal',
      description:
      'If properties are managed or represented by legal counsel / attorney.',
    ),
    _RoleOption(
      id: 'manager',
      icon: Icons.apartment_rounded,
      title: 'Real Estate Manager',
      badge: '',
      description:
      'Licensed broker, property manager, or facility management firm.',
    ),
    _RoleOption(
      id: 'rent',
      icon: Icons.home_work_outlined,
      title: 'Rent / Buy',
      badge: 'Popular',
      description:
      'Lease or rent verified residential and commercial properties on HomeX.',
    ),
    _RoleOption(
      id: 'seller',
      icon: Icons.real_estate_agent_rounded,
      title: 'Land Seller',
      badge: 'Verified C-of-O',
      description:
      'Direct property or land owner with title deeds and C-of-O.',
    ),

  ];

  // ============================================================
  // RESPONSIVE PADDING
  // ============================================================

  double _hPad(BuildContext context) {
    final width = context.widthPx;

    if (width < 360) {
      return 12;
    }

    if (width < 400) {
      return 16;
    }

    return 20;
  }

  // ============================================================
  // ROLE STATE
  // ============================================================

  bool _isSelected(String roleId) {
    return _selectedRoles.contains(roleId);
  }

  bool _isRoleEnabled(String roleId) {
    // ----------------------------------------------------------
    // RENT SELECTED
    // ----------------------------------------------------------
    // Rent is completely exclusive.
    if (_selectedRoles.contains('rent')) {
      return roleId == 'rent';
    }

    // ----------------------------------------------------------
    // LAWYER / MANAGER COMBINATION
    // ----------------------------------------------------------
    // Once either Lawyer or Manager is selected,
    // only Lawyer + Manager can participate.
    if (_selectedRoles.contains('lawyer') ||
        _selectedRoles.contains('manager')) {
      return roleId == 'lawyer' || roleId == 'manager';
    }

    // ----------------------------------------------------------
    // SELLER SELECTED
    // ----------------------------------------------------------
    // Seller is exclusive because no seller combination
    // was specified.
    if (_selectedRoles.contains('seller')) {
      return roleId == 'seller';
    }

    // ----------------------------------------------------------
    // NOTHING SELECTED
    // ----------------------------------------------------------
    return true;
  }

  // ============================================================
  // ROLE SELECTION
  // ============================================================

  void _toggleRole(String roleId) {
    if (!_isRoleEnabled(roleId)) {
      return;
    }

    setState(() {
      // --------------------------------------------------------
      // RENT
      // --------------------------------------------------------
      if (roleId == 'rent') {
        if (_selectedRoles.contains('rent')) {
          _selectedRoles.clear();
        } else {
          _selectedRoles = {'rent'};
        }

        return;
      }

      // --------------------------------------------------------
      // SELLER
      // --------------------------------------------------------
      if (roleId == 'seller') {
        if (_selectedRoles.contains('seller')) {
          _selectedRoles.clear();
        } else {
          _selectedRoles = {'seller'};
        }

        return;
      }

      // --------------------------------------------------------
      // LAWYER / MANAGER
      // --------------------------------------------------------
      if (roleId == 'lawyer' || roleId == 'manager') {
        // If rent/seller somehow exists, remove it first.
        _selectedRoles.remove('rent');
        _selectedRoles.remove('seller');

        if (_selectedRoles.contains(roleId)) {
          _selectedRoles.remove(roleId);
        } else {
          _selectedRoles.add(roleId);
        }
      }
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final hPad = _hPad(context);
    final canContinue = _selectedRoles.isNotEmpty;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(
              context,
              hPad,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  hPad,
                  16,
                  hPad,
                  24,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    _buildProgressBar(
                      context,
                      1 / 3,
                    ),
                    const SizedBox(height: 20),
                    _buildHeadline(
                      context,
                    ),
                    const SizedBox(height: 20),

                    ..._roles.map(
                          (role) => Padding(
                        padding:
                        const EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: _buildRoleCard(
                          context,
                          role,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    _buildSelectionInfo(
                      context,
                    ),

                    const SizedBox(height: 12),

                    _buildTrustNote(
                      context,
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomBar(
              context,
              hPad,
              canContinue,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(
      BuildContext context,
      double hPad,
      ) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          ScaleOnTap(
            onTap: () {
              Navigator.of(context).maybePop();
            },
            child: Icon(
              Icons.arrow_back_rounded,
            //  color: colors.surface,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHigh,
              borderRadius:
              BorderRadius.circular(999),
              border: Border.all(
                color: colors.outlineVariant
                    .withValues(alpha: 0.3),
              ),
            ),
            child: Row(
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
                const SizedBox(width: 6),
                Text(
                  'Step 1 of 3',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          ScaleOnTap(
            onTap: () {},
            child: Text(
              'Help',
              style: textTheme.labelMedium?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROGRESS
  // ============================================================

  Widget _buildProgressBar(
      BuildContext context,
      double value,
      ) {
    final colors = context.colors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 4,
        backgroundColor:
        colors.outlineVariant,
        valueColor:
        AlwaysStoppedAnimation<Color>(
          colors.secondary,
        ),
      ),
    );
  }

  // ============================================================
  // HEADLINE
  // ============================================================

  Widget _buildHeadline(
      BuildContext context,
      ) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: colors.secondaryFixed,
            borderRadius:
            BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified_user_rounded,
                size: 12,
                color: colors.onSecondaryFixed,
              ),
              const SizedBox(width: 4),
              Text(
                'Account Setup',
                style: textTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  color: colors.onSecondaryFixed,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Select Your Role(s)',
          style: textTheme.headlineMedium?.copyWith(
            color: colors.onSurface,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Choose how you intend to use HomeX. '
              'Some roles can be combined while others are exclusive.',
          style: textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ROLE CARD
  // ============================================================

  Widget _buildRoleCard(
      BuildContext context,
      _RoleOption role,
      ) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final selected = _isSelected(role.id);
    final enabled = _isRoleEnabled(role.id);

    return AnimatedOpacity(
      duration:
      const Duration(milliseconds: 180),
      opacity: enabled ? 1.0 : 0.45,
      child: ScaleOnTap(
        onTap: enabled
            ? () => _toggleRole(role.id)
            : () {},
        child: AnimatedContainer(
          duration:
          const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected
                ? colors.surfaceContainerLowest
                : colors.surfaceContainerLowest,
            borderRadius:
            BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? colors.primary
                  : colors.outlineVariant
                  .withValues(alpha: 0.5),
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
              BoxShadow(
                color: colors.shadow
                    .withValues(alpha: 0.08),
                blurRadius: 8,
                offset:
                const Offset(0, 3),
              ),
            ]
                : null,
          ),
          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------
              // ICON
              // ------------------------------------------------
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: selected
                      ? colors.primaryContainer
                      : colors.surfaceContainer,
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Icon(
                  role.icon,
                  size: 20,
                  color: selected
                      ? colors.onPrimaryContainer
                      : colors.onSurfaceVariant,
                ),
              ),

              const SizedBox(width: 14),

              // ------------------------------------------------
              // CONTENT
              // ------------------------------------------------
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment:
                      WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          role.title,
                          style: textTheme.bodyLarge
                              ?.copyWith(
                            color:
                            colors.onSurface,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),

                        if (role.badge.isNotEmpty)
                          Container(
                            padding:
                            const EdgeInsets
                                .symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration:
                            BoxDecoration(
                              color:
                              _badgeBackground(
                                context,
                                role.id,
                              ),
                              borderRadius:
                              BorderRadius
                                  .circular(4),
                            ),
                            child: Text(
                              role.badge
                                  .toUpperCase(),
                              style: textTheme
                                  .labelSmall
                                  ?.copyWith(
                                fontSize: 9,
                                color:
                                _badgeForeground(
                                  context,
                                  role.id,
                                ),
                                fontWeight:
                                FontWeight.w800,
                                letterSpacing:
                                0.4,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      role.description,
                      style: textTheme.labelSmall
                          ?.copyWith(
                        color:
                        colors.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),

                    // ------------------------------------------------
                    // DISABLED REASON
                    // ------------------------------------------------
                    if (!enabled) ...[
                      const SizedBox(height: 7),
                      _buildDisabledReason(
                        context,
                        role.id,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ------------------------------------------------
              // CHECKBOX
              // ------------------------------------------------
              Container(
                width: 24,
                height: 24,
                margin:
                const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: selected
                      ? colors.primary
                      : colors.surfaceContainerLowest,
                  borderRadius:
                  BorderRadius.circular(6),
                  border: selected
                      ? null
                      : Border.all(
                    color:
                    colors.outlineVariant,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: selected
                    ? Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: colors.onPrimary,
                )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BADGE COLORS
  // ============================================================

  Color _badgeBackground(
      BuildContext context,
      String roleId,
      ) {
    final colors = context.colors;

    switch (roleId) {
      case 'lawyer':
        return colors.secondaryFixed;

      case 'rent':
        return colors.surfaceContainerHigh;

      case 'seller':
        return colors.tertiaryFixedDim;

      case 'manager':
        return colors.surfaceContainer;

      default:
        return colors.surfaceContainer;
    }
  }

  Color _badgeForeground(
      BuildContext context,
      String roleId,
      ) {
    final colors = context.colors;

    switch (roleId) {
      case 'lawyer':
        return colors.onSecondaryFixed;

      case 'rent':
        return colors.onSurfaceVariant;

      case 'seller':
        return colors.onTertiaryFixed;

      case 'manager':
        return colors.onSurfaceVariant;

      default:
        return colors.onSurfaceVariant;
    }
  }

  // ============================================================
  // DISABLED REASON
  // ============================================================

  Widget _buildDisabledReason(
      BuildContext context,
      String roleId,
      ) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    String message;

    if (_selectedRoles.contains('rent')) {
      message =
      'Unavailable while Rent / Tenant is selected.';
    } else if (_selectedRoles.contains('lawyer') ||
        _selectedRoles.contains('manager')) {
      message =
      'Only Lawyer and Real Estate Manager can be combined.';
    } else if (_selectedRoles.contains('seller')) {
      message =
      'Land Seller is an exclusive role.';
    } else {
      message = 'Not available with the current selection.';
    }

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.lock_outline_rounded,
          size: 13,
          color: colors.onSurfaceVariant,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            message,
            style: textTheme.labelSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontSize: 10,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SELECTION INFO
  // ============================================================

  Widget _buildSelectionInfo(
      BuildContext context,
      ) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    if (_selectedRoles.isEmpty) {
      return const SizedBox.shrink();
    }

    String title;
    String description;

    if (_selectedRoles.contains('rent')) {
      title = 'Rent / Tenant mode';
      description =
      'This role works independently and disables the other roles.';
    } else if (_selectedRoles.contains('lawyer') &&
        _selectedRoles.contains('manager')) {
      title = 'Legal + Estate Management';
      description =
      'Lawyer and Real Estate Manager can operate together.';
    } else if (_selectedRoles.contains('lawyer')) {
      title = 'Lawyer mode';
      description =
      'Real Estate Manager remains available as a compatible role.';
    } else if (_selectedRoles.contains('manager')) {
      title = 'Estate Management mode';
      description =
      'Lawyer remains available as a compatible role.';
    } else {
      title = 'Land Seller mode';
      description =
      'Land Seller operates as an exclusive role.';
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius:
        BorderRadius.circular(10),
        border: Border.all(
          color: colors.outlineVariant
              .withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 17,
            color: colors.secondary,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.labelMedium
                      ?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: textTheme.labelSmall
                      ?.copyWith(
                    color:
                    colors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TRUST NOTE
  // ============================================================

  Widget _buildTrustNote(
      BuildContext context,
      ) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius:
        BorderRadius.circular(10),
        border: Border.all(
          color: colors.outlineVariant
              .withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            size: 18,
            color: colors.secondary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: textTheme.labelSmall
                    ?.copyWith(
                  color:
                  colors.onSurfaceVariant,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text:
                    'Institutional Compliance: ',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text:
                    'Verified accounts unlock deed authentication, '
                        'escrow settlement in Nigerian Naira (₦), and '
                        'legal land registry checks.',
                    style: TextStyle(
                      color:
                      colors.onSurfaceVariant,
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

  // ============================================================
  // BOTTOM BAR
  // ============================================================

  Widget _buildBottomBar(
      BuildContext context,
      double hPad,
      bool canContinue,
      ) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: colors.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        hPad,
        12,
        hPad,
        context.bottomPadding + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: canContinue ? 1 : 0.5,
            child: ScaleOnTap(
              onTap: canContinue
                  ? () {
                AppNavigator
                    .pushAndStackNamed(
                  AppRoutes
                      .createAccountIdentificationScreen,
                  arguments: {
                    "role":_selectedRoles
                  }
                );
              }
                  : () {},
              child: Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius:
                  BorderRadius.circular(12),
                  border: Border.all(color: colors.outlineVariant)
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue to Account Creation',
                      style: textTheme.bodyMedium
                          ?.copyWith(
                        color: colors.onPrimary,
                        fontWeight:
                        FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: colors.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You can update your operational roles later in profile settings.',
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              fontSize: 12,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}