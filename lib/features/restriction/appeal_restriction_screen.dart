import 'package:flutter/material.dart';
import 'package:homex/res/app_strings.dart';
import 'package:homex/ui/global.dart';

class AppealRestrictionScreen extends StatefulWidget {
  const AppealRestrictionScreen({super.key});

  @override
  State<AppealRestrictionScreen> createState() =>
      _AppealRestrictionScreenState();
}

class _AppealRestrictionScreenState
    extends State<AppealRestrictionScreen> {
  final TextEditingController _appealController =
  TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _appealController.dispose();
    super.dispose();
  }

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appeal saved as draft'),
      ),
    );
  }

  Future<void> _submitAppeal() async {
    if (_appealController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide your appeal statement'),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // TODO: Submit appeal to backend.

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });
AppNavigator.pushAndStackNamed(AppRoutes.appealSubmittedScreen);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Appeal submitted successfully'),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: colors.onSurfaceVariant,
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_balance_rounded,
              color: colors.primary,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              AppStrings.appName,
              style: textTheme.titleLarge?.copyWith(
                //color: colors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: textTheme.labelLarge?.copyWith(
                color: colors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            40,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------------------------------------------------
                  // PAGE HEADER
                  // ---------------------------------------------------------

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Step 1 of 2',
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Appeal Restriction',
                    style: textTheme.headlineLarge?.copyWith(
                      color: colors.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Please provide detailed information to help us review your case.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ---------------------------------------------------------
                  // CONTENT
                  // ---------------------------------------------------------

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 700;

                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 280,
                              child: _buildInformationSection(
                                context,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildAppealForm(
                                context,
                              ),
                            ),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          _buildInformationSection(context),
                          const SizedBox(height: 24),
                          _buildAppealForm(context),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // INFORMATION SECTION
  // ===========================================================================

  Widget _buildInformationSection(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------------------------------------------------------------
        // DISPUTE NOTICE
        // ---------------------------------------------------------------------

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.surfaceContainerHighest,
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: colors.secondaryContainer,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.gavel_rounded,
                              color: colors.secondaryContainer,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Dispute Notice',
                                style: textTheme.titleMedium?.copyWith(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Reference:',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          'HM-ESC-8921',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Divider(
                          height: 1,
                          color: colors.surfaceContainerHighest,
                        ),

                        const SizedBox(height:8),

                        Text(
                          'To lift this restriction, we require additional context regarding the recent transaction anomaly flagged on your escrow account.',
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ---------------------------------------------------------------------
        // HELP CARD
        // ---------------------------------------------------------------------

        CustomCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.help_outline_rounded,
                  color: colors.outline,
                  size: 21,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Need assistance?',
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    GestureDetector(
                      onTap: () {
                        // TODO: Open support screen.
                      },
                      child: Text(
                        'Contact Support Team',
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          decoration:
                          TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // APPEAL FORM
  // ===========================================================================

  Widget _buildAppealForm(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return CustomCard(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------------------------------------------------
          // APPEAL STATEMENT
          // -------------------------------------------------------------------

          Text(
            'Appeal Statement',
            style: textTheme.titleMedium?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Explain the context of the dispute. Be as detailed as possible to expedite the review process.',
            style: textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _appealController,
            maxLines: 7,
            maxLength: 2000,
            textInputAction: TextInputAction.newline,
            style: textTheme.bodyMedium?.copyWith(
              color: colors.onSurface,
            ),
            decoration: InputDecoration(
              hintText:
              'Describe the situation regarding dispute HM-ESC-8921...',
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: colors.outline,
              ),
              filled: true,
              fillColor: colors.surfaceContainerLowest,
              contentPadding: const EdgeInsets.all(16),
              counterStyle: textTheme.labelSmall?.copyWith(
                color: colors.outline,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colors.outlineVariant,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colors.outlineVariant,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Divider(
            height: 1,
            color: colors.surfaceContainerHighest,
          ),

          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SUPPORTING DOCUMENTS
          // -------------------------------------------------------------------

          Text(
            'Supporting Documents',
            style: textTheme.titleMedium?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Upload receipts, correspondence, or any official documents related to the dispute.',
            style: textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          _buildUploadArea(context),

          const SizedBox(height: 24),

          Divider(
            height: 1,
            color: colors.surfaceContainerHighest,
          ),

          const SizedBox(height: 16),

          // -------------------------------------------------------------------
          // ACTION BUTTONS
          // -------------------------------------------------------------------

          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 450;

              if (isSmall) {
                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                      onPressed: _saveDraft,
                      style: OutlinedButton.styleFrom(
                        minimumSize:
                        const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color:
                          colors.surfaceContainerHighest,
                        ),
                      ),
                      child: Text(
                        'Save Draft',
                        style:
                        textTheme.labelLarge?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    _buildSubmitButton(context),
                  ],
                );
              }

              return Row(
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: _saveDraft,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(130, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color:
                        colors.surfaceContainerHighest,
                      ),
                    ),
                    child: Text(
                      'Save Draft',
                      style:
                      textTheme.labelLarge?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  _buildSubmitButton(context),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // UPLOAD AREA
  // ===========================================================================

  Widget _buildUploadArea(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return InkWell(
      onTap: () {
        // TODO: Implement file picker.
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 28,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colors.outlineVariant,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.upload_file_rounded,
                color: colors.outline,
                size: 24,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Click to upload or drag and drop',
              textAlign: TextAlign.center,
              style: textTheme.labelLarge?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'PDF, JPG, PNG (Max 10MB per file)',
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(
                color: colors.outline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SUBMIT BUTTON
  // ===========================================================================

  Widget _buildSubmitButton(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return ElevatedButton(
      onPressed: _isSubmitting ? null : _submitAppeal,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        disabledBackgroundColor:
        colors.surfaceContainerHighest,
        minimumSize: const Size(150, 52),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(
          color:
          colors.outlineVariant,
        ),
      ),
      child: _isSubmitting
          ? SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: colors.onPrimary,
        ),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Submit Appeal',
            style: textTheme.labelLarge?.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_forward_rounded,
            size: 18,
            color: colors.onPrimary,
          ),
        ],
      ),
    );
  }
}