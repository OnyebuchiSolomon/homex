import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:homex/ui/global.dart';

class TrustVerificationPage extends StatefulWidget {
  const TrustVerificationPage({
    super.key,
    this.onBack,
    this.onSkip,
    this.onPublished,
  });

  final VoidCallback? onBack;
  final VoidCallback? onSkip;
  final VoidCallback? onPublished;

  @override
  State<TrustVerificationPage> createState() => _TrustVerificationPageState();
}

class _TrustVerificationPageState extends State<TrustVerificationPage>
    with SingleTickerProviderStateMixin {
  PlatformFile? _certificateOfOccupancy;
  PlatformFile? _surveyPlan;
  PlatformFile? _purchaseReceipt;

  bool _uploadingCertificate = false;
  bool _uploadingSurvey = false;
  bool _uploadingReceipt = false;

  bool _publishing = false;

  double _certificateProgress = 0;
  double _surveyProgress = 0;
  double _receiptProgress = 0;

  // ============================================================
  // ANIMATION
  // ============================================================

  late final AnimationController _pageAnimationController;

  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _pageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _pageAnimationController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _pageAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _pageAnimationController.forward();
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    super.dispose();
  }

  // ============================================================
  // BACKEND API
  // ============================================================

  static const String uploadUrl =
      'https://YOUR-BACKEND-URL.com/api/properties/documents';

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),

            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildAnimatedSection(
                              delay: 0,
                              child: _buildHeader(context),
                            ),

                            const SizedBox(height: 14),

                            _buildAnimatedSection(
                              delay: 100,
                              child: _buildProgressBar(context),
                            ),

                            const SizedBox(height: 24),

                            _buildDocuments(context),

                            const SizedBox(height: 16),

                            _buildAnimatedSection(
                              delay: 400,
                              child: _buildInformationCard(context),
                            ),

                            const SizedBox(height: 40),

                            _buildAnimatedSection(
                              delay: 500,
                              child: _buildBottomActions(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ANIMATED SECTION
  // ============================================================

  Widget _buildAnimatedSection({required int delay, required Widget child}) {
    return _DelayedAnimation(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.94),
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.25),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _AnimatedTapButton(
              onTap: _goBack,
              child: IconButton(
                tooltip: 'Back',
                onPressed: _goBack,
                icon: Icon(Icons.arrow_back, color: colors.onSurface),
              ),
            ),

            Expanded(
              child: Center(
                child: Text(
                  'Step 5 of 6',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Trust & Verification',
          textAlign: TextAlign.center,
          style: AppTextStyles.displayLargeMobile.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Verify Ownership to build trust. Listings with verified '
          'documents receive 3x more inquiries.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROGRESS BAR
  // ============================================================

  Widget _buildProgressBar(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step 5 of 6',
              style: AppTextStyles.labelMedium.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),

            Text(
              '83%',
              style: AppTextStyles.labelSmall.copyWith(color: colors.primary),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            height: 10,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 5 / 6),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  backgroundColor: colors.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DOCUMENTS
  // ============================================================

  Widget _buildDocuments(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedSection(
          delay: 180,
          child: _documentCard(
            context,
            title: 'Certificate of Occupancy (C of O)',
            subtitle: 'PDF, JPG or PNG up to 10MB',
            icon: Icons.description_outlined,
            file: _certificateOfOccupancy,
            uploading: _uploadingCertificate,
            progress: _certificateProgress,
            requiredDocument: true,
            onUpload: () => _selectAndUploadDocument(
              documentType: 'certificate_of_occupancy',
            ),
            onRemove: () => _removeDocument('certificate_of_occupancy'),
          ),
        ),

        const SizedBox(height: 16),

        _buildAnimatedSection(
          delay: 280,
          child: _documentCard(
            context,
            title: 'Survey Plan',
            subtitle: 'PDF, JPG or PNG up to 10MB',
            icon: Icons.map_outlined,
            file: _surveyPlan,
            uploading: _uploadingSurvey,
            progress: _surveyProgress,
            requiredDocument: true,
            onUpload: () =>
                _selectAndUploadDocument(documentType: 'survey_plan'),
            onRemove: () => _removeDocument('survey_plan'),
          ),
        ),

        const SizedBox(height: 16),

        _buildAnimatedSection(
          delay: 380,
          child: _documentCard(
            context,
            title: 'Purchase Receipt',
            subtitle: 'Optional. PDF, JPG or PNG up to 10MB',
            icon: Icons.receipt_long_outlined,
            file: _purchaseReceipt,
            uploading: _uploadingReceipt,
            progress: _receiptProgress,
            requiredDocument: false,
            onUpload: () =>
                _selectAndUploadDocument(documentType: 'purchase_receipt'),
            onRemove: () => _removeDocument('purchase_receipt'),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DOCUMENT CARD
  // ============================================================

  Widget _documentCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required PlatformFile? file,
    required bool uploading,
    required double progress,
    required bool requiredDocument,
    required VoidCallback onUpload,
    required VoidCallback onRemove,
  }) {
    final colors = Theme.of(context).colorScheme;

    final bool uploaded = file != null && !uploading;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: uploaded
            ? colors.primary.withValues(alpha: 0.025)
            : colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: uploaded
              ? colors.primary.withValues(alpha: 0.45)
              : colors.outlineVariant,
          width: uploaded ? 1.2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: uploaded ? 0.08 : 0.05),
            blurRadius: uploaded ? 14 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 560;

          final information = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: uploaded
                      ? colors.primary.withValues(alpha: 0.10)
                      : colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Icon(
                    uploaded ? Icons.check_circle_outline : icon,
                    key: ValueKey(uploaded),
                    color: uploaded ? colors.primary : colors.primary,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axisAlignment: -1,
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        file == null ? subtitle : file.name,
                        key: ValueKey(file?.name ?? subtitle),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: colors.onSurfaceVariant,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: uploading
                          ? Padding(
                              key: const ValueKey('uploading'),
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                        begin: 0,
                                        end: progress,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeOutCubic,
                                      builder:
                                          (context, animatedProgress, child) {
                                            return LinearProgressIndicator(
                                              value: animatedProgress,
                                              minHeight: 6,
                                              backgroundColor:
                                                  colors.surfaceContainerHigh,
                                              color: colors.primary,
                                            );
                                          },
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    'Uploading '
                                    '${(progress * 100).round()}%',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: colors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : file != null
                          ? Padding(
                              key: const ValueKey('uploaded'),
                              padding: const EdgeInsets.only(top: 8),
                              child: _uploadedBadge(context),
                            )
                          : const SizedBox(key: ValueKey('empty')),
                    ),
                  ],
                ),
              ),
            ],
          );

          Widget action;

          if (uploading) {
            action = OutlinedButton.icon(
              onPressed: null,
              icon: const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              label: const Text('Uploading...'),
            );
          } else if (file != null) {
            action = _AnimatedTapButton(
              onTap: onRemove,
              child: OutlinedButton.icon(
                onPressed: onRemove,
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.error,
                  side: BorderSide(color: colors.error),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Remove'),
              ),
            );
          } else {
            action = _AnimatedTapButton(
              onTap: onUpload,
              child: OutlinedButton.icon(
                onPressed: onUpload,
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.primary,
                  side: BorderSide(color: colors.outline),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.upload_outlined, size: 18),
                label: const Text('Upload'),
              ),
            );
          }

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [information, const SizedBox(height: 16), action],
            );
          }

          return Row(
            children: [
              Expanded(child: information),
              const SizedBox(width: 16),
              action,
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // UPLOADED BADGE
  // ============================================================

  Widget _uploadedBadge(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          alignment: Alignment.centerLeft,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: colors.tertiaryFixed.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 14,
              color: colors.onTertiaryFixedVariant,
            ),
            const SizedBox(width: 4),
            Text(
              'Uploaded',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.onTertiaryFixedVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // INFORMATION CARD
  // ============================================================

  Widget _buildInformationCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: colors.secondaryContainer),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verification usually takes 24 hours.',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.onSurface,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Our team manually reviews documents to ensure '
                  'a secure marketplace.',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 11,
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w300,
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
  // BOTTOM ACTIONS
  // ============================================================

  Widget _buildBottomActions(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final requiredDocumentsUploaded =
        _certificateOfOccupancy != null && _surveyPlan != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          height: 56,
          child: _AnimatedTapButton(
            enabled: requiredDocumentsUploaded && !_publishing,
            onTap: requiredDocumentsUploaded && !_publishing
                ? _publishProperty
                : null,
            child: FilledButton(
              onPressed: requiredDocumentsUploaded && !_publishing
                  ? _publishProperty
                  : null,
              style: FilledButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                disabledBackgroundColor: colors.surfaceContainerHigh,
                disabledForegroundColor: colors.onSurfaceVariant,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: _publishing
                    ? SizedBox(
                        key: const ValueKey('publishing'),
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: colors.onPrimary,
                        ),
                      )
                    : Text(
                        'Publish Property',
                        key: const ValueKey('publish'),
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 16,
                          color: requiredDocumentsUploaded
                              ? colors.onPrimary
                              : colors.onSurfaceVariant,
                        ),
                      ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 56,
          child: _AnimatedTapButton(
            enabled: !_publishing,
            onTap: !_publishing ? _skipVerification : null,
            child: OutlinedButton(
              onPressed: _publishing ? null : _skipVerification,
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.primary,
                backgroundColor: colors.surfaceContainerLowest,
                side: BorderSide(color: colors.outlineVariant),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Skip for Now (Unverified)',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: 16,
                  color: colors.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SELECT + UPLOAD
  // ============================================================

  Future<void> _selectAndUploadDocument({required String documentType}) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
      withData: false,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final file = result.files.first;

    const maxFileSize = 10 * 1024 * 1024;

    if (file.size > maxFileSize) {
      _showMessage('The file is larger than 10MB.', isError: true);
      return;
    }

    if (file.path == null) {
      _showMessage('Unable to access the selected file.', isError: true);
      return;
    }

    if (!mounted) return;

    switch (documentType) {
      case 'certificate_of_occupancy':
        setState(() {
          _certificateOfOccupancy = file;
          _uploadingCertificate = true;
          _certificateProgress = 0;
        });
        break;

      case 'survey_plan':
        setState(() {
          _surveyPlan = file;
          _uploadingSurvey = true;
          _surveyProgress = 0;
        });
        break;

      case 'purchase_receipt':
        setState(() {
          _purchaseReceipt = file;
          _uploadingReceipt = true;
          _receiptProgress = 0;
        });
        break;
    }

    try {
      await _uploadFile(file: file, documentType: documentType);

      if (!mounted) return;

      setState(() {
        switch (documentType) {
          case 'certificate_of_occupancy':
            _uploadingCertificate = false;
            _certificateProgress = 1;
            break;

          case 'survey_plan':
            _uploadingSurvey = false;
            _surveyProgress = 1;
            break;

          case 'purchase_receipt':
            _uploadingReceipt = false;
            _receiptProgress = 1;
            break;
        }
      });

      _showMessage('${file.name} uploaded successfully.');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        switch (documentType) {
          case 'certificate_of_occupancy':
            _uploadingCertificate = false;
            _certificateOfOccupancy = null;
            _certificateProgress = 0;
            break;

          case 'survey_plan':
            _uploadingSurvey = false;
            _surveyPlan = null;
            _surveyProgress = 0;
            break;

          case 'purchase_receipt':
            _uploadingReceipt = false;
            _purchaseReceipt = null;
            _receiptProgress = 0;
            break;
        }
      });

      _showMessage('Upload failed. Please try again.', isError: true);
    }
  }

  // ============================================================
  // ACTUAL HTTP UPLOAD
  // ============================================================

  Future<void> _uploadFile({
    required PlatformFile file,
    required String documentType,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

    request.fields['document_type'] = documentType;

    request.files.add(
      await http.MultipartFile.fromPath(
        'document',
        file.path!,
        filename: file.name,
      ),
    );

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Upload failed: ${response.statusCode}');
    }
  }

  // ============================================================
  // REMOVE DOCUMENT
  // ============================================================

  void _removeDocument(String documentType) {
    if (!mounted) return;

    setState(() {
      switch (documentType) {
        case 'certificate_of_occupancy':
          _certificateOfOccupancy = null;
          _certificateProgress = 0;
          break;

        case 'survey_plan':
          _surveyPlan = null;
          _surveyProgress = 0;
          break;

        case 'purchase_receipt':
          _purchaseReceipt = null;
          _receiptProgress = 0;
          break;
      }
    });
  }

  // ============================================================
  // PUBLISH PROPERTY
  // ============================================================

  Future<void> _publishProperty() async {
    if (_certificateOfOccupancy == null || _surveyPlan == null) {
      _showMessage(
        'Please upload the C of O and Survey Plan first.',
        isError: true,
      );
      return;
    }

    if (_publishing) return;

    setState(() {
      _publishing = true;
    });

    try {
      /*
       * At this point the required documents
       * have already been uploaded.
       *
       * Your backend can now mark the property
       * as "pending_verification".
       */

      await Future<void>.delayed(const Duration(milliseconds: 800));

      if (!mounted) return;

      widget.onPublished?.call();

      AppNavigator.pushAndStackNamed(AppRoutes.listingPreviewPage);
    } catch (e) {
      if (!mounted) return;

      _showMessage('Unable to publish property.', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _publishing = false;
        });
      }
    }
  }

  // ============================================================
  // SKIP
  // ============================================================

  void _skipVerification() {
    if (_publishing) return;

    widget.onSkip?.call();

    AppNavigator.pushAndStackNamed(AppRoutes.listingPreviewPage);
  }

  // ============================================================
  // BACK
  // ============================================================

  void _goBack() {
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }

    Navigator.of(context).pop();
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;

    final colors = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? colors.error : colors.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

// ================================================================
// DELAYED ANIMATION
// ================================================================

class _DelayedAnimation extends StatefulWidget {
  const _DelayedAnimation({required this.delay, required this.child});

  final Duration delay;
  final Widget child;

  @override
  State<_DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<_DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _scale = Tween<double>(
      begin: 0.98,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future<void>.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(scale: _scale, child: widget.child),
      ),
    );
  }
}

// ================================================================
// TAP ANIMATION
// ================================================================

class _AnimatedTapButton extends StatefulWidget {
  const _AnimatedTapButton({
    required this.child,
    required this.onTap,
    this.enabled = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  State<_AnimatedTapButton> createState() => _AnimatedTapButtonState();
}

class _AnimatedTapButtonState extends State<_AnimatedTapButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!widget.enabled) return;

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _setPressed(true),
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.enabled ? widget.onTap : null,
          child: widget.child,
        ),
      ),
    );
  }
}
