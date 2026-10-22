import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homex/core/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';

import 'trust_verification_page.dart';

class PhotosVideoPage extends StatefulWidget {
  const PhotosVideoPage({super.key});

  @override
  State<PhotosVideoPage> createState() => _PhotosVideoPageState();
}

class _PhotosVideoPageState extends State<PhotosVideoPage>
    with TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();

  File? _mainPhoto;
  final List<File?> _additionalPhotos = List<File?>.filled(6, null);

  File? _propertyVideo;

  bool _isSaving = false;

  // ------------------------------------------------------------
  // ANIMATION CONTROLLERS
  // ------------------------------------------------------------

  late final AnimationController _pageController;
  late final AnimationController _progressController;
  late final AnimationController _bottomBarController;

  late final Animation<double> _pageFade;
  late final Animation<Offset> _pageSlide;

  late final Animation<double> _progressAnimation;
  late final Animation<Offset> _bottomBarSlide;

  // ------------------------------------------------------------
  // INIT
  // ------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _bottomBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _pageFade = CurvedAnimation(
      parent: _pageController,
      curve: Curves.easeOut,
    );

    _pageSlide = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _pageController,
        curve: Curves.easeOutCubic,
      ),
    );

    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    );

    _bottomBarSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _bottomBarController,
        curve: Curves.easeOutCubic,
      ),
    );

    _pageController.forward();

    Future.delayed(
      const Duration(milliseconds: 100),
          () {
        if (mounted) {
          _progressController.forward();
        }
      },
    );

    Future.delayed(
      const Duration(milliseconds: 350),
          () {
        if (mounted) {
          _bottomBarController.forward();
        }
      },
    );
  }

  // ------------------------------------------------------------
  // DISPOSE
  // ------------------------------------------------------------

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    _bottomBarController.dispose();

    super.dispose();
  }

  // ------------------------------------------------------------
  // PICK MAIN PHOTO
  // ------------------------------------------------------------

  Future<void> _pickMainPhoto() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (pickedFile == null) return;

      setState(() {
        _mainPhoto = File(pickedFile.path);
      });
    } catch (e) {
      _showMessage('Unable to select the main photo.');
    }
  }

  // ------------------------------------------------------------
  // PICK ADDITIONAL PHOTO
  // ------------------------------------------------------------

  Future<void> _pickAdditionalPhoto(int index) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (pickedFile == null) return;

      setState(() {
        _additionalPhotos[index] = File(pickedFile.path);
      });
    } catch (e) {
      _showMessage('Unable to select the photo.');
    }
  }

  // ------------------------------------------------------------
  // PICK VIDEO
  // ------------------------------------------------------------

  Future<void> _pickPropertyVideo() async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 1),
      );

      if (pickedFile == null) return;

      setState(() {
        _propertyVideo = File(pickedFile.path);
      });
    } catch (e) {
      _showMessage('Unable to select the property video.');
    }
  }

  // ------------------------------------------------------------
  // SAVE DRAFT
  // ------------------------------------------------------------

  Future<void> _saveDraft() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    _showMessage('Property listing saved as draft.');
  }

  // ------------------------------------------------------------
  // NEXT
  // ------------------------------------------------------------

  void _goToStep5() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 550),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (
            context,
            animation,
            secondaryAnimation,
            ) {
          return const TrustVerificationPage();
        },
        transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
            ) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.04, 0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // MESSAGE
  // ------------------------------------------------------------

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ------------------------------------------------------------
  // PHOTO COUNT
  // ------------------------------------------------------------

  int get _additionalPhotoCount {
    return _additionalPhotos.where((photo) => photo != null).length;
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: FadeTransition(
                opacity: _pageFade,
                child: SlideTransition(
                  position: _pageSlide,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      bottom: 110,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 900,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 24,
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              _AnimatedSection(
                                delay: 0,
                                child: _buildMainPhotoSection(
                                  context,
                                  theme,
                                ),
                              ),

                              const SizedBox(height: 48),

                              _AnimatedSection(
                                delay: 100,
                                child:
                                _buildAdditionalPhotosSection(
                                  context,
                                  theme,
                                ),
                              ),

                              const SizedBox(height: 48),

                              _AnimatedSection(
                                delay: 200,
                                child: _buildVideoSection(
                                  context,
                                  theme,
                                ),
                              ),

                              const SizedBox(height: 48),

                              _AnimatedSection(
                                delay: 300,
                                child: _buildVerificationTip(
                                  context,
                                  theme,
                                ),
                              ),

                              const SizedBox(height: 24),
                            ],
                          ),
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

      bottomNavigationBar: SlideTransition(
        position: _bottomBarSlide,
        child: _buildBottomBar(
          context,
          theme,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // HEADER
  // ------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 64,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Row(
                children: [
                  _roundIconButton(
                    context,
                    icon: Icons.arrow_back,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Center(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(
                          begin: 0,
                          end: 1,
                        ),
                        duration: const Duration(
                          milliseconds: 600,
                        ),
                        curve: Curves.easeOut,
                        builder: (
                            context,
                            value,
                            child,
                            ) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(
                                0,
                                8 * (1 - value),
                              ),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          'Photos & Video',
                          style:
                          theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),

                  TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: 0,
                      end: 1,
                    ),
                    duration: const Duration(
                      milliseconds: 700,
                    ),
                    curve: Curves.easeOutBack,
                    builder: (
                        context,
                        value,
                        child,
                        ) {
                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: value.clamp(0, 1),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme
                            .surfaceContainerHighest,
                        borderRadius:
                        BorderRadius.circular(999),
                      ),
                      child: Text(
                        '4 of 6',
                        style:
                        theme.textTheme.labelLarge?.copyWith(
                          color:
                          colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Animated progress bar.
          SizedBox(
            height: 4,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedBuilder(
                animation: _progressAnimation,
                builder: (
                    context,
                    child,
                    ) {
                  return FractionallySizedBox(
                    widthFactor:
                    0.66 * _progressAnimation.value,
                    child: Container(
                      color: colorScheme.primary,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // MAIN PHOTO SECTION
  // ------------------------------------------------------------

  Widget _buildMainPhotoSection(
      BuildContext context,
      ThemeData theme,
      ) {
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Main Photo',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'This is the first image buyers will see.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 16),

        GestureDetector(
          onTap: _pickMainPhoto,
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 350,
            ),
            curve: Curves.easeOutCubic,
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              color:
              colorScheme.surfaceContainerLowest,
              borderRadius:
              BorderRadius.circular(16),
              border: Border.all(
                color: _mainPhoto == null
                    ? colorScheme.outlineVariant
                    : colorScheme.primary,
                width: _mainPhoto == null ? 2 : 2.5,
              ),
              boxShadow: _mainPhoto != null
                  ? [
                BoxShadow(
                  color: colorScheme.primary
                      .withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ]
                  : null,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 450,
              ),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (
                  child,
                  animation,
                  ) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.96,
                      end: 1,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _mainPhoto == null
                  ? KeyedSubtree(
                key: const ValueKey(
                  'main-photo-empty',
                ),
                child: _buildMainPhotoEmptyState(
                  context,
                  theme,
                ),
              )
                  : KeyedSubtree(
                key: const ValueKey(
                  'main-photo-preview',
                ),
                child: _buildMainPhotoPreview(
                  context,
                  theme,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // MAIN PHOTO EMPTY
  // ------------------------------------------------------------

  Widget _buildMainPhotoEmptyState(
      BuildContext context,
      ThemeData theme,
      ) {
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 0.85,
            end: 1,
          ),
          duration: const Duration(
            milliseconds: 800,
          ),
          curve: Curves.easeOutBack,
          builder: (
              context,
              value,
              child,
              ) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add_photo_alternate_outlined,
              size: 32,
              color:
              colorScheme.onPrimaryContainer,
            ),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Upload Main Photo',
          style:
          theme.textTheme.labelLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'PNG, JPG up to 10MB',
          style:
          theme.textTheme.labelSmall?.copyWith(
            color:
            colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // MAIN PHOTO PREVIEW
  // ------------------------------------------------------------

  Widget _buildMainPhotoPreview(
      BuildContext context,
      ThemeData theme,
      ) {
    final colorScheme = theme.colorScheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius:
          BorderRadius.circular(14),
          child: Image.file(
            _mainPhoto!,
            fit: BoxFit.cover,
          ),
        ),

        // Dark gradient.
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.28),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: 12,
          right: 12,
          child: TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0.7,
              end: 1,
            ),
            duration: const Duration(
              milliseconds: 450,
            ),
            curve: Curves.easeOutBack,
            builder: (
                context,
                value,
                child,
                ) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value.clamp(0, 1),
                  child: child,
                ),
              );
            },
            child: Material(
              color: colorScheme.surface
                  .withOpacity(0.90),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder:
                const CircleBorder(),
                onTap: _pickMainPhoto,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.edit),
                ),
              ),
            ),
          ),
        ),

        Positioned(
          left: 12,
          bottom: 12,
          child: Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface
                  .withOpacity(0.90),
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: Text(
              'Main Photo',
              style:
              theme.textTheme.labelMedium
                  ?.copyWith(
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // ADDITIONAL PHOTOS
  // ------------------------------------------------------------

  Widget _buildAdditionalPhotosSection(
      BuildContext context,
      ThemeData theme,
      ) {
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Photos',
                    style: theme
                        .textTheme.titleLarge
                        ?.copyWith(
                      fontWeight:
                      FontWeight.w600,
                      color:
                      colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Add interior and exterior shots.',
                    style: theme
                        .textTheme.bodyMedium
                        ?.copyWith(
                      color: colorScheme
                          .onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            // Animated counter.
            TweenAnimationBuilder<double>(
              key: ValueKey(
                _additionalPhotoCount,
              ),
              tween: Tween(
                begin: 0,
                end: 1,
              ),
              duration: const Duration(
                milliseconds: 350,
              ),
              curve: Curves.easeOutBack,
              builder: (
                  context,
                  value,
                  child,
                  ) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value.clamp(0, 1),
                    child: child,
                  ),
                );
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme
                      .surfaceContainer,
                  borderRadius:
                  BorderRadius.circular(999),
                ),
                child: Text(
                  '$_additionalPhotoCount/6+',
                  style: theme
                      .textTheme.labelSmall
                      ?.copyWith(
                    color: colorScheme
                        .onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (
              context,
              constraints,
              ) {
            final width = constraints.maxWidth;

            final int columns =
            width >= 700 ? 3 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (
                  context,
                  index,
                  ) {
                return _AnimatedGridItem(
                  index: index,
                  child:
                  _buildAdditionalPhotoBox(
                    context,
                    theme,
                    index,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // ADDITIONAL PHOTO BOX
  // ------------------------------------------------------------

  Widget _buildAdditionalPhotoBox(
      BuildContext context,
      ThemeData theme,
      int index,
      ) {
    final colorScheme = theme.colorScheme;
    final photo = _additionalPhotos[index];

    return GestureDetector(
      onTap: () => _pickAdditionalPhoto(index),
      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: colorScheme
              .surfaceContainerLowest,
          borderRadius:
          BorderRadius.circular(16),
          border: Border.all(
            color: photo == null
                ? colorScheme.outlineVariant
                : colorScheme.primary,
            width: photo == null ? 1 : 2,
          ),
          boxShadow: photo != null
              ? [
            BoxShadow(
              color: colorScheme.primary
                  .withOpacity(0.10),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ]
              : null,
        ),
        child: AnimatedSwitcher(
          duration:
          const Duration(milliseconds: 350),
          switchInCurve:
          Curves.easeOutCubic,
          transitionBuilder: (
              child,
              animation,
              ) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.92,
                  end: 1,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: photo == null
              ? KeyedSubtree(
            key: ValueKey(
              'empty-$index',
            ),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0.8,
                    end: 1,
                  ),
                  duration:
                  const Duration(
                    milliseconds: 500,
                  ),
                  curve:
                  Curves.easeOutBack,
                  builder: (
                      context,
                      value,
                      child,
                      ) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.add,
                    size: 28,
                    color:
                    colorScheme.outline,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Add Photo',
                  style: theme
                      .textTheme.labelSmall
                      ?.copyWith(
                    color: colorScheme
                        .onSurfaceVariant,
                  ),
                ),
              ],
            ),
          )
              : KeyedSubtree(
            key: ValueKey(
              'photo-$index-${photo.path}',
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(
                    15,
                  ),
                  child: Image.file(
                    photo,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned.fill(
                  child: DecoratedBox(
                    decoration:
                    BoxDecoration(
                      gradient:
                      LinearGradient(
                        begin: Alignment
                            .topCenter,
                        end: Alignment
                            .bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black
                              .withOpacity(
                            0.22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child:
                  _buildAnimatedDeleteButton(
                    context,
                    index,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // DELETE BUTTON
  // ------------------------------------------------------------

  Widget _buildAnimatedDeleteButton(
      BuildContext context,
      int index,
      ) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0.7,
        end: 1,
      ),
      duration:
      const Duration(milliseconds: 350),
      curve: Curves.easeOutBack,
      builder: (
          context,
          value,
          child,
          ) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value.clamp(0, 1),
            child: child,
          ),
        );
      },
      child: Material(
        color: colorScheme.surface
            .withOpacity(0.90),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder:
          const CircleBorder(),
          onTap: () {
            setState(() {
              _additionalPhotos[index] = null;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(6),
            child: Icon(
              Icons.close,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // VIDEO SECTION
  // ------------------------------------------------------------

  Widget _buildVideoSection(
      BuildContext context,
      ThemeData theme,
      ) {
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Property Video',
          style:
          theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 16),

        GestureDetector(
          onTap: _pickPropertyVideo,
          child: AnimatedContainer(
            duration:
            const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            width: double.infinity,
            padding:
            const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme
                  .surfaceContainerLowest,
              borderRadius:
              BorderRadius.circular(16),
              border: Border.all(
                color: _propertyVideo == null
                    ? colorScheme
                    .outlineVariant
                    : colorScheme.primary,
                width:
                _propertyVideo == null
                    ? 1
                    : 2,
              ),
              boxShadow:
              _propertyVideo != null
                  ? [
                BoxShadow(
                  color: colorScheme
                      .primary
                      .withOpacity(
                    0.10,
                  ),
                  blurRadius: 20,
                  offset:
                  const Offset(
                    0,
                    7,
                  ),
                ),
              ]
                  : null,
            ),
            child: AnimatedSwitcher(
              duration:
              const Duration(milliseconds: 350),
              transitionBuilder: (
                  child,
                  animation,
                  ) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.horizontal,
                    child: child,
                  ),
                );
              },
              child: Row(
                key: ValueKey(
                  _propertyVideo != null,
                ),
                children: [
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: _propertyVideo == null
                          ? colorScheme
                          .surfaceContainerHighest
                          : colorScheme
                          .primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      child: Icon(
                        _propertyVideo == null
                            ? Icons
                            .videocam_outlined
                            : Icons
                            .check_circle_outline,
                        key: ValueKey(
                          _propertyVideo != null,
                        ),
                        color:
                        _propertyVideo == null
                            ? colorScheme
                            .onSurfaceVariant
                            : colorScheme
                            .onPrimaryContainer,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          _propertyVideo == null
                              ? 'Upload 1-minute Video'
                              : 'Property video selected',
                          style: theme
                              .textTheme.labelLarge
                              ?.copyWith(
                            color:
                            colorScheme
                                .onSurface,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          _propertyVideo == null
                              ? 'MP4, MOV up to 50MB'
                              : 'Tap to replace video',
                          style: theme
                              .textTheme.labelSmall
                              ?.copyWith(
                            color: colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  AnimatedRotation(
                    turns:
                    _propertyVideo == null
                        ? 0
                        : 0.25,
                    duration:
                    const Duration(
                      milliseconds: 300,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color:
                      colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // VERIFICATION TIP
  // ------------------------------------------------------------

  Widget _buildVerificationTip(
      BuildContext context,
      ThemeData theme,
      ) {
    final colorScheme = theme.colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0.96,
        end: 1,
      ),
      duration:
      const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (
          context,
          value,
          child,
          ) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        padding:
        const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer
              .withOpacity(0.10),
          borderRadius:
          BorderRadius.circular(16),
          border: Border.all(
            color:
            colorScheme.primaryFixedDim,
          ),
        ),
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: 1,
              ),
              duration:
              const Duration(milliseconds: 900),
              curve: Curves.easeOutBack,
              builder: (
                  context,
                  value,
                  child,
                  ) {
                return Transform.scale(
                  scale: value,
                  child: Transform.rotate(
                    angle:
                    (1 - value) * -0.25,
                    child: child,
                  ),
                );
              },
              child: Icon(
                Icons.verified,
                size: 32,
                color:
                AppColors.secondaryContainer,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verification Tip',
                    style: theme
                        .textTheme.labelLarge
                        ?.copyWith(
                      color:
                      colorScheme.onSurface,
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Verified properties get 3x more requests. '
                        'High quality photos are the first step to '
                        'achieving a verified badge on your listing.',
                    style: theme
                        .textTheme.bodyMedium
                        ?.copyWith(
                      color: colorScheme
                          .onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // BOTTOM BAR
  // ------------------------------------------------------------

  Widget _buildBottomBar(
      BuildContext context,
      ThemeData theme,
      ) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding:
      const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface
            .withOpacity(0.96),
        border: Border(
          top: BorderSide(
            color:
            colorScheme.outlineVariant,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.05),
            blurRadius: 20,
            offset:
            const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints:
          const BoxConstraints(
            maxWidth: 900,
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: _isSaving
                        ? null
                        : _saveDraft,
                    style:
                    OutlinedButton.styleFrom(
                      foregroundColor:
                      colorScheme
                          .onSurface,
                      backgroundColor:
                      colorScheme
                          .surfaceContainer,
                      side: BorderSide(
                        color: colorScheme
                            .outlineVariant,
                      ),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration:
                      const Duration(
                        milliseconds: 250,
                      ),
                      child: _isSaving
                          ? SizedBox(
                        key: const ValueKey(
                          'saving',
                        ),
                        width: 20,
                        height: 20,
                        child:
                        CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme
                              .primary,
                        ),
                      )
                          : Text(
                        key: const ValueKey(
                          'save',
                        ),
                        'Save Draft',
                        style: theme
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _AnimatedButton(
                  onPressed: _goToStep5,
                  child: SizedBox(
                    height: 48,
                    child: FilledButton(
                      onPressed:
                      _goToStep5,
                      style:
                      FilledButton.styleFrom(
                        backgroundColor:
                        colorScheme
                            .primary,
                        foregroundColor:
                        colorScheme
                            .onPrimary,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                            14,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          Text(
                            'Next',
                            style: theme
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                              color:
                              colorScheme
                                  .onPrimary,
                              fontWeight:
                              FontWeight
                                  .w600,
                            ),
                          ),

                          const SizedBox(
                            width: 6,
                          ),

                          const Icon(
                            Icons
                                .arrow_forward,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // ROUND ICON BUTTON
  // ------------------------------------------------------------

  Widget _roundIconButton(
      BuildContext context, {
        required IconData icon,
        required VoidCallback onPressed,
      }) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder:
        const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color:
            colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ANIMATED SECTION
// ============================================================

class _AnimatedSection extends StatefulWidget {
  const _AnimatedSection({
    required this.child,
    required this.delay,
  });

  final Widget child;
  final int delay;

  @override
  State<_AnimatedSection> createState() =>
      _AnimatedSectionState();
}

class _AnimatedSectionState
    extends State<_AnimatedSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration:
      const Duration(milliseconds: 650),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    Future.delayed(
      Duration(milliseconds: 120 + widget.delay),
          () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
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
        child: widget.child,
      ),
    );
  }
}

// ============================================================
// ANIMATED GRID ITEM
// ============================================================

class _AnimatedGridItem extends StatefulWidget {
  const _AnimatedGridItem({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  State<_AnimatedGridItem> createState() =>
      _AnimatedGridItemState();
}

class _AnimatedGridItemState
    extends State<_AnimatedGridItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration:
      const Duration(milliseconds: 550),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scale = Tween<double>(
      begin: 0.88,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    Future.delayed(
      Duration(
        milliseconds: 250 + (widget.index * 80),
      ),
          () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
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
        child: ScaleTransition(
          scale: _scale,
          child: widget.child,
        ),
      ),
    );
  }
}

// ============================================================
// ANIMATED BUTTON
// ============================================================

class _AnimatedButton extends StatefulWidget {
  const _AnimatedButton({
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  State<_AnimatedButton> createState() =>
      _AnimatedButtonState();
}

class _AnimatedButtonState
    extends State<_AnimatedButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onPointerUp: (_) {
        setState(() {
          _pressed = false;
        });
      },
      onPointerCancel: (_) {
        setState(() {
          _pressed = false;
        });
      },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration:
        const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}