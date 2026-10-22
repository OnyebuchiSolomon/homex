import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class SubmitEvidencePage extends StatefulWidget {
  const SubmitEvidencePage({
    super.key,
    this.onNext,
    this.onBack,
  });

  final VoidCallback? onNext;
  final VoidCallback? onBack;

  @override
  State<SubmitEvidencePage> createState() => _SubmitEvidencePageState();
}

class _SubmitEvidencePageState extends State<SubmitEvidencePage>
    with SingleTickerProviderStateMixin {
  final ImagePicker _imagePicker = ImagePicker();

  late final AnimationController _animationController;

  final TextEditingController _descriptionController =
  TextEditingController();

  File? _photoFile;
  File? _documentFile;
  File? _videoFile;

  bool _isPhotoUploading = false;
  bool _isDocumentUploading = false;
  bool _isVideoUploading = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    if (_isPhotoUploading) return;

    setState(() {
      _isPhotoUploading = true;
    });

    try {
      final XFile? result = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (!mounted) return;

      if (result != null) {
        setState(() {
          _photoFile = File(result.path);
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPhotoUploading = false;
        });
      }
    }
  }

  Future<void> _pickVideo() async {
    if (_isVideoUploading) return;

    setState(() {
      _isVideoUploading = true;
    });

    try {
      final XFile? result = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
      );

      if (!mounted) return;

      if (result != null) {
        setState(() {
          _videoFile = File(result.path);
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isVideoUploading = false;
        });
      }
    }
  }

  Future<void> _pickDocument() async {
    if (_isDocumentUploading) return;

    setState(() {
      _isDocumentUploading = true;
    });

    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'doc',
          'docx',
        ],
      );

      if (!mounted) return;

      if (result != null && result.files.single.path != null) {
        setState(() {
          _documentFile = File(result.files.single.path!);
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDocumentUploading = false;
        });
      }
    }
  }

  bool get _canContinue {
    return _descriptionController.text.trim().isNotEmpty ||
        _photoFile != null ||
        _documentFile != null ||
        _videoFile != null;
  }

  void _continue() {
    if (!_canContinue) return;

    FocusScope.of(context).unfocus();

    if (widget.onNext != null) {
      widget.onNext!();
      return;
    }

    // Connect your Step 3 navigation here.
  }

  void _removePhoto() {
    setState(() {
      _photoFile = null;
    });
  }

  void _removeDocument() {
    setState(() {
      _documentFile = null;
    });
  }

  void _removeVideo() {
    setState(() {
      _videoFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;

    final bool isTablet = width >= 600;
    final bool isDesktop = width >= 1024;

    final double horizontalPadding = isDesktop
        ? 40
        : isTablet
        ? 24
        : 16;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _HomeXTopBar(
              onProfileTap: () {},
            ),

            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: isTablet ? 24 : 16,
                  bottom: 120,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop ? 680 : 640,
                    ),
                    child: _buildContent(
                      context,
                      theme,
                      colorScheme,
                      textTheme,
                    ),
                  ),
                ),
              ),
            ),

            _BottomActionBar(
              enabled: _canContinue,
              onPressed: _continue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      ThemeData theme,
      ColorScheme colorScheme,
      TextTheme textTheme,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.surfaceContainerHighest,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildHeader(
            context,
            theme,
            colorScheme,
            textTheme,
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDescriptionField(
                  context,
                  theme,
                  colorScheme,
                  textTheme,
                ),

                const SizedBox(height: 24),

                _buildEvidenceSection(
                  context,
                  theme,
                  colorScheme,
                  textTheme,
                ),
              ],
            ),
          ),

          _buildCardFooter(
            context,
            theme,
            colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context,
      ThemeData theme,
      ColorScheme colorScheme,
      TextTheme textTheme,
      ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.surfaceContainerHighest,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _IconButton(
                icon: Icons.arrow_back,
                onPressed: widget.onBack ??
                        () {
                      Navigator.of(context).maybePop();
                    },
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  'Submit Evidence',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                   // color: colorScheme.primary,
                  ),
                ),
              ),

              const SizedBox(width: 48),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'STEP 2 OF 3',
                style: textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: colorScheme.secondary,
                ),
              ),
              Text(
                '66%',
                style: textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: 0.66,
              ),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 10,
                  backgroundColor:
                  colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.secondary,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField(
      BuildContext context,
      ThemeData theme,
      ColorScheme colorScheme,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description of the issue',
          style: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: _descriptionController,
          minLines: 4,
          maxLines: 7,
          textInputAction: TextInputAction.newline,
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Provide a detailed account of the issue...',
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            filled: true,
            fillColor: colorScheme.surfaceContainerLowest,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.outlineVariant,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.outlineVariant,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEvidenceSection(
      BuildContext context,
      ThemeData theme,
      ColorScheme colorScheme,
      TextTheme textTheme,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Supporting Evidence',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 8),

        Divider(
          height: 1,
          color: colorScheme.surfaceContainerHighest,
        ),

        const SizedBox(height: 16),

        _EvidenceUploadCard(
          icon: Icons.add_a_photo_outlined,
          title: 'Photo Evidence',
          subtitle: _photoFile == null
              ? 'JPG, PNG (Max 5MB)'
              : _fileName(_photoFile!),
          buttonText: _photoFile == null ? 'Upload' : 'Change',
          iconBackground: colorScheme.primaryContainer,
          iconColor: colorScheme.onPrimaryContainer,
          loading: _isPhotoUploading,
          selected: _photoFile != null,
          onUpload: _pickPhoto,
          onRemove: _photoFile != null ? _removePhoto : null,
        ),

        const SizedBox(height: 12),

        _EvidenceUploadCard(
          icon: Icons.description_outlined,
          title: 'Document/Receipt',
          subtitle: _documentFile == null
              ? 'PDF, DOCX (Max 10MB)'
              : _fileName(_documentFile!),
          buttonText: _documentFile == null ? 'Upload' : 'Change',
          iconBackground: colorScheme.secondaryContainer,
          iconColor: colorScheme.onSecondaryContainer,
          loading: _isDocumentUploading,
          selected: _documentFile != null,
          onUpload: _pickDocument,
          onRemove: _documentFile != null ? _removeDocument : null,
        ),

        const SizedBox(height: 12),

        _EvidenceUploadCard(
          icon: Icons.videocam_outlined,
          title: 'Video',
          subtitle: _videoFile == null
              ? 'MP4 (Max 1 min, 20MB)'
              : _fileName(_videoFile!),
          buttonText: _videoFile == null ? 'Upload' : 'Change',
          iconBackground: colorScheme.tertiaryContainer,
          iconColor: colorScheme.onTertiaryContainer,
          loading: _isVideoUploading,
          selected: _videoFile != null,
          onUpload: _pickVideo,
          onRemove: _videoFile != null ? _removeVideo : null,
        ),
      ],
    );
  }

  Widget _buildCardFooter(
      BuildContext context,
      ThemeData theme,
      ColorScheme colorScheme,
      ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: colorScheme.surfaceContainerHighest,
          ),
        ),
      ),
      child: const SizedBox.shrink(),
    );
  }

  String _fileName(File file) {
    return file.path.split(Platform.pathSeparator).last;
  }
}


/// ------------------------------------------------------------
/// HOME X TOP BAR
/// ------------------------------------------------------------

class _HomeXTopBar extends StatelessWidget {
  const _HomeXTopBar({
    required this.onProfileTap,
  });

  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: colorScheme.surfaceContainerLowest,
      elevation: 2,
      child: SizedBox(
        height: 58,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.gavel_rounded,
                color: colorScheme.primary,
                size: 24,
              ),

              const SizedBox(width: 8),

              Text(
                'HomeX',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),

              const Spacer(),

              InkWell(
                onTap: onProfileTap,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surfaceContainerHighest,
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 19,
                    color: colorScheme.onSurfaceVariant,
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


/// ------------------------------------------------------------
/// EVIDENCE UPLOAD CARD
/// ------------------------------------------------------------

class _EvidenceUploadCard extends StatefulWidget {
  const _EvidenceUploadCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.iconBackground,
    required this.iconColor,
    required this.onUpload,
    required this.loading,
    required this.selected,
    this.onRemove,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final Color iconBackground;
  final Color iconColor;
  final VoidCallback onUpload;
  final VoidCallback? onRemove;
  final bool loading;
  final bool selected;

  @override
  State<_EvidenceUploadCard> createState() => _EvidenceUploadCardState();
}

class _EvidenceUploadCardState extends State<_EvidenceUploadCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AnimatedScale(
      scale: _pressed ? 0.985 : 1,
      duration: const Duration(milliseconds: 100),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.selected
              ? colorScheme.surfaceContainerLow
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.selected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            width: widget.selected ? 1.3 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: widget.iconBackground,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                widget.selected
                    ? Icons.check_circle_outline
                    : widget.icon,
                color: widget.iconColor,
                size: 24,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 4),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      widget.subtitle,
                      key: ValueKey(widget.subtitle),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelSmall?.copyWith(
                        color: widget.selected
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            if (widget.loading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              )
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.selected &&
                      widget.onRemove != null) ...[
                    IconButton(
                      tooltip: 'Remove',
                      onPressed: widget.onRemove,
                      icon: Icon(
                        Icons.close,
                        size: 19,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],

                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        _pressed = true;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _pressed = false;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _pressed = false;
                      });
                    },
                    child: OutlinedButton(
                      onPressed: widget.onUpload,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: colorScheme.outlineVariant,
                        ),
                        foregroundColor: colorScheme.primary,
                      ),
                      child: Text(
                        widget.buttonText,
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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


/// ------------------------------------------------------------
/// BOTTOM ACTION BAR
/// ------------------------------------------------------------

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: colorScheme.surfaceContainerLowest,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 680,
              ),
              child: SizedBox(
                width: double.infinity,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: enabled ? 1 : 0.5,
                  child: ElevatedButton(
                    onPressed: enabled ? ()=>AppNavigator.pushAndStackNamed(AppRoutes.disputeSummaryPage) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      disabledBackgroundColor:
                      colorScheme.primary.withValues(alpha: 0.35),
                      disabledForegroundColor:
                      colorScheme.onPrimary,
                      elevation: 2,
                      minimumSize: const Size(
                        double.infinity,
                        52,
                      ),
                      side: BorderSide(color: colorScheme.outlineVariant),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/// ------------------------------------------------------------
/// ICON BUTTON
/// ------------------------------------------------------------

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: colorScheme.onSurface,
            size: 22,
          ),
        ),
      ),
    );
  }
}