import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homex/ui/global.dart';

class FundingInstructionsScreen extends StatefulWidget {
  const FundingInstructionsScreen({super.key});

  @override
  State<FundingInstructionsScreen> createState() => _FundingInstructionsScreenState();
}

class _FundingInstructionsScreenState extends State<FundingInstructionsScreen> {
  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  void _copyToClipboard(BuildContext context, String value, String label) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied "$value" to clipboard'), duration: const Duration(seconds: 2)),
    );
  }

  void _openUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _UploadReceiptSheet(onSubmitted: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receipt submitted. Reconciling with bank ledger...')),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hPad = _hPad(context);
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeIn(child: _buildAlertBanner(context)),
                    const SizedBox(height: 20),
                    SlideFadeIn(child: _buildBalanceCard(context)),
                    const SizedBox(height: 20),
                    SlideFadeIn(delay: AppAnimations.shortDelay, child: _buildVaultAccountCard(context)),
                    const SizedBox(height: 20),
                    _buildChannelsCard(context),
                    const SizedBox(height: 20),
                    _buildPropertySynopsis(context),
                    const SizedBox(height: 20),
                    _buildPostTransferProtocol(context),
                    const SizedBox(height: 20),
                    _buildActionsArea(context),
                    const SizedBox(height: 16),
                    _buildOfficerCard(context),
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
    return Container(
      color: context.theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      child: Row(
        children: [
          ScaleOnTap(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back, color: context.colors.onSurface),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Funding Instructions', style: textTheme.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(
                  '4 Bedroom Duplex, Lekki (Phase 1)',
                  style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.lightSurfaceContainerLowest,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.lightSurfaceContainerHigh),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified_user, size: 16, color: AppColors.secondary),
                const SizedBox(width: 4),
                Text('Protected', style: textTheme.labelSmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertBanner(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: AppColors.lightSurfaceContainerHigh, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Icon(Icons.shield, size: 18, color: AppColors.secondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Zero Direct Seller Transfer Policy', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Funds deposited into this dedicated trustee vault are held safe and will only be disbursed after your written authorization upon physical handover inspection.',
                  style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text('Milestone 3: Balance Payment', style: textTheme.labelSmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.errorContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.schedule, size: 14, color: AppColors.error),
                    const SizedBox(width: 4),
                    Text('Due in 48 hours (Oct 31, 2023)', style: textTheme.labelSmall?.copyWith(color: AppColors.error, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Total Remaining Amount to Fund', style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: 32),
                children: const [
                  TextSpan(text: '₦135,000,000'),
                  TextSpan(text: '.00', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.lightTextSecondary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.lightSurfaceContainerHigh),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Transaction Progress: 10% Deposited',
                  style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('Total: ₦150,000,000', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(height: 10, color: context.colors.primary),
                ),
                Expanded(
                  flex: 90,
                  child: Container(height: 10, color: AppColors.secondaryContainer),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: context.colors.primary, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text('Initial Deposit: ₦15,000,000 (Funded)', style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary)),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.secondaryContainer, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text('Milestone 3: ₦135,000,000', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVaultAccountCard(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      padding: const EdgeInsets.all(18),
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
                    Text('Dedicated Escrow Vault Account', style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(
                      'Assigned exclusively to transaction #ESC-2023-8942-NG',
                      style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Icon(Icons.account_balance, color: context.colors.primary),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightSurfaceContainerLow,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.lightSurfaceContainerHigh),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning, size: 18, color: AppColors.secondary),
                const SizedBox(width: 10),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: textTheme.labelSmall?.copyWith(color: context.colors.onSurface, height: 1.5),
                      children: const [
                        TextSpan(text: 'Strict Compliance Notice: ', style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: 'Transfer funds '),
                        TextSpan(text: 'only', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w600)),
                        TextSpan(text: ' to the custodian account generated below. Never transfer to private agent accounts, solicitors, or personal seller bank accounts.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildDataRow(context, label: 'Custodian Trustee Bank', value: 'Providus Bank / Stanbic IBTC Escrow Trust', trailingIcon: Icons.domain),
          const SizedBox(height: 10),
          _buildDataRow(
            context,
            label: 'Beneficiary Account Name',
            value: 'HomeX Escrow Custody - Ref #ESC-8942',
            copyValue: 'HomeX Escrow Custody - Ref #ESC-8942',
          ),
          const SizedBox(height: 10),
          _buildAccountNumberCard(context),
          const SizedBox(height: 10),
          _buildReferenceRow(context),
        ],
      ),
    );
  }

  Widget _buildDataRow(BuildContext context, {required String label, required String value, IconData? trailingIcon, String? copyValue}) {
    final textTheme = context.textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary),
                ),
                const SizedBox(height: 2),
                Text(value, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (trailingIcon != null) Icon(trailingIcon, size: 18, color: AppColors.lightTextSecondary),
          if (copyValue != null)
            ScaleOnTap(
              onTap: () => _copyToClipboard(context, copyValue, label),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.content_copy, size: 15, color: context.colors.primary),
                    const SizedBox(width: 4),
                    Text('Copy', style: textTheme.labelSmall?.copyWith(color: context.colors.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAccountNumberCard(BuildContext context) {
    final textTheme = context.textTheme;
    const accountNumber = '9928340192';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ESCROW DEDICATED ACCOUNT NUMBER',
                style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.primaryFixedDim),
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  accountNumber,
                  style: textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                ),
              ),
            ],
          ),
          ScaleOnTap(
            onTap: () => _copyToClipboard(context, accountNumber, 'Account number'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.content_copy, size: 16, color: context.colors.primary),
                  const SizedBox(width: 6),
                  Text('Copy Number', style: textTheme.labelSmall?.copyWith(color: context.colors.primary, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceRow(BuildContext context) {
    final textTheme = context.textTheme;
    const reference = 'HX-8942-FIN';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightSurfaceContainerHighest),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'PAYMENT REFERENCE / REMARK (MANDATORY)',
                    style: textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.lightTextSecondary, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.info, size: 14, color: AppColors.secondary),
                ],
              ),
              const SizedBox(height: 4),
              Text(reference, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontFamily: 'monospace')),
              const SizedBox(height: 2),
              Text(
                "Paste this in your bank's transfer memo/description field.",
                style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary),
              ),
            ],
          ),
          ScaleOnTap(
            onTap: () => _copyToClipboard(context, reference, 'Reference'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.lightSurfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.lightOutlineVariant),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.content_copy, size: 14, color: context.colors.onSurface),
                  const SizedBox(width: 4),
                  Text('Copy Ref', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelsCard(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      padding: const EdgeInsets.all(18),
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
                    Text('Supported Transfer Channels', style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(
                      'Options tailored for large-denomination property transactions',
                      style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 4, bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(999)),
              child: Text('NIP / RTGS / Swift', style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary)),
            ),
          ),
          _buildChannelTile(
            context,
            icon: Icons.bolt,
            title: 'Direct Instant Transfer / RTGS (Recommended)',
            badge: 'Instant - 30 Mins',
            description: 'Initiate via Mobile App, Corporate Banking Portal, or bank branch using RTGS for amounts exceeding standard NIP daily limits.',
          ),
          const SizedBox(height: 10),
          _buildChannelTile(
            context,
            icon: Icons.call_split,
            title: 'Multi-Tranche Split Payments',
            badge: 'Daily Limit Friendly',
            description: 'Subject to daily ₦10M – ₦25M bank app ceilings? Split the ₦135,000,000 across tranches using the same reference — our ledger aggregates deposits automatically.',
          ),
          const SizedBox(height: 10),
          _buildChannelTile(
            context,
            icon: Icons.receipt_long,
            title: "Bank Draft / Manager's Cheque",
            badge: '1–2 Business Days',
            description: 'Make drafts payable to "Stanbic IBTC Trustees Limited / HomeX Escrow" and submit slip details for manual verification.',
          ),
        ],
      ),
    );
  }

  Widget _buildChannelTile(BuildContext context, {required IconData icon, required String title, required String badge, required String description}) {
    final textTheme = context.textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: context.colors.primary),
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
                    Text(title, style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
                    Text(badge, style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.secondary, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(description, style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertySynopsis(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCLkY7LFljKU65RSQzLgQSCr4SgF98R03XzjY-K3lU-pDF9pA6tcy0kA86Mxdu18v7Py5qg6U3t-ddkBaVHdOn93DWiTHt-Jmwfk3I61bXQ5yqa2Mh6Ot_uqWm9mmTg8_8BxkowIvcANhTwO_zkdg5TLF8PXn306PVoURaedlUCD8p59_4_3d8CLD0MSggO4IxOxuFBnJ3tGhbKBySQ4trljanhNTIxycscQdDCN_Ns-vCqlw8mzT1W',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withValues(alpha: 0.8), Colors.black.withValues(alpha: 0.1), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified, size: 14, color: AppColors.secondary),
                      const SizedBox(width: 4),
                      Text('Title Verified', style: textTheme.labelSmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PROPERTY ASSET', style: TextStyle(fontSize: 10, color: Colors.white70, fontWeight: FontWeight.w600)),
                    Text(
                      '4 Bedroom Duplex, Lekki',
                      style: textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: Colors.white70),
                        const SizedBox(width: 3),
                        const Text('Phase 1, Lekki, Lagos State', style: TextStyle(fontSize: 11, color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            color: AppColors.lightSurfaceContainerLow.withValues(alpha: 0.5),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Contract Value', style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary)),
                      FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text('₦150,000,000', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700))),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Escrow Fee Rate', style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary)),
                      Text('Covered by Seller', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
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

  Widget _buildPostTransferProtocol(BuildContext context) {
    final textTheme = context.textTheme;
    final steps = [
      ['Confirm Transfer Narrative', 'Ensure your bank remarks field strictly has HX-8942-FIN to eliminate reconciliation delays.'],
      ["Upload Payment Confirmation", "Tap 'I Have Made This Transfer' below to submit the official debit receipt or RTGS confirmation slip."],
      ['Instant Ledger Reconciliation', 'Once Providus/Stanbic confirms the inbound NIP clearing (usually within 15–30 minutes), Milestone 3 will immediately show as Funded.'],
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.fact_check, size: 16, color: AppColors.secondary),
              const SizedBox(width: 8),
              Text(
                'POST-TRANSFER PROTOCOL',
                style: textTheme.labelSmall?.copyWith(letterSpacing: 0.6, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(color: context.colors.primary, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(steps[i][0], style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(steps[i][1], style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            if (i != steps.length - 1) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }

  Widget _buildActionsArea(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          ScaleOnTap(
            onTap: () => _openUploadSheet(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 18, color: context.colors.onPrimary),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'I Have Made This Transfer',
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
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Generating official HomeX Escrow Payment Slip (PDF)...')),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightOutlineVariant),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download, size: 16, color: context.colors.onSurface),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Download Official Invoice Slip (PDF)',
                      textAlign: TextAlign.center,
                      style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary),
              children: [
                const TextSpan(text: 'Need high-volume wire coordination? '),
                TextSpan(
                  text: 'Call Escrow Desk',
                  style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOfficerCard(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightSurfaceContainerHigh),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('TA', style: textTheme.labelMedium?.copyWith(color: AppColors.onPrimaryContainer, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text('Tunde Adeleke', style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 6),
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.tertiaryFixedDim, shape: BoxShape.circle)),
                  ],
                ),
                Text(
                  'Senior Trustee Officer • HomeX Legal',
                  style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          ScaleOnTap(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.lightSurfaceContainerHigh)),
              child: Icon(Icons.mail, size: 18, color: context.colors.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// UPLOAD RECEIPT BOTTOM SHEET
// ---------------------------------------------------------------------
class _UploadReceiptSheet extends StatefulWidget {
  final VoidCallback onSubmitted;
  const _UploadReceiptSheet({required this.onSubmitted});

  @override
  State<_UploadReceiptSheet> createState() => _UploadReceiptSheetState();
}

class _UploadReceiptSheetState extends State<_UploadReceiptSheet> {
  String? _fileName;
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _amountController = TextEditingController(text: '135,000,000');

  @override
  void dispose() {
    _bankController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: context.bottomPadding),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.lightSurfaceContainerLowest,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(color: AppColors.lightOutlineVariant, borderRadius: BorderRadius.circular(999)),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: Icon(Icons.cloud_upload, color: context.colors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Submit Transfer Proof', style: textTheme.headlineSmall),
                      Text('Escrow Ref: HX-8942-FIN (₦135,000,000)', style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary)),
                    ],
                  ),
                ),
                ScaleOnTap(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ScaleOnTap(
              onTap: () => setState(() => _fileName = 'bank_transfer_receipt.pdf'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.lightOutlineVariant, style: BorderStyle.solid, width: 2),
                  color: AppColors.lightSurface,
                ),
                child: Column(
                  children: [
                    Icon(Icons.receipt, size: 28, color: AppColors.lightTextSecondary),
                    const SizedBox(height: 8),
                    Text('Tap to select receipt or upload a file', style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                    const SizedBox(height: 2),
                    Text(
                      'PDF, JPG, PNG or screenshot of bank transfer confirmation (Max 15MB)',
                      style: textTheme.labelSmall?.copyWith(fontSize: 11, color: AppColors.lightTextSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            if (_fileName != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.lightSurfaceContainerLow, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(Icons.description, size: 18, color: context.colors.primary),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_fileName!, style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
                    ScaleOnTap(
                      onTap: () => setState(() => _fileName = null),
                      child: Text('Remove', style: textTheme.labelSmall?.copyWith(color: AppColors.error, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text('Sending Bank & Account Name', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: _bankController,
              decoration: InputDecoration(
                hintText: 'e.g., Zenith Bank - Alexander Magnus',
                filled: true,
                fillColor: AppColors.lightSurface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.lightSurfaceContainerHigh)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 14),
            Text('Total Amount Transferred (₦)', style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.lightSurface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.lightSurfaceContainerHigh)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ScaleOnTap(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Text('Cancel', style: textTheme.labelSmall?.copyWith(color: AppColors.lightTextSecondary, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 8),
                ScaleOnTap(
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onSubmitted();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(10)),
                    child: Text('Submit for Verification', style: textTheme.labelSmall?.copyWith(color: context.colors.onPrimary, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}