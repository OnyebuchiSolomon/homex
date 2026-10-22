  import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:homex/ui/global.dart';
class PropertyVideoCard extends StatefulWidget {
  final String url;

  const PropertyVideoCard({super.key,
    required this.url,
  });

  @override
  State<PropertyVideoCard> createState() =>
      _PropertyVideoState();
}

class _PropertyVideoState
    extends State<PropertyVideoCard> {
  VideoPlayerController? _controller;

  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      final controller =
      VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
      );

      _controller = controller;

      await controller.initialize();

      if (!mounted) {
        controller.dispose();
        return;
      }

      setState(() {
        _isInitialized = true;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  void _togglePlay() {
    final controller = _controller;

    if (controller == null ||
        !_isInitialized) {
      return;
    }

    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors =
        Theme.of(context).colorScheme;

    if (_hasError) {
      return ColoredBox(
        color:
        colors.surfaceContainerHighest,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam_off_outlined,
                size: 48,
                color:
                colors.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                'Unable to load video',
                style:
                AppTextStyles.bodyMedium.copyWith(
                  color:
                  colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized ||
        _controller == null) {
      return ColoredBox(
        color:
        colors.surfaceContainerHighest,
        child: Center(
          child: CircularProgressIndicator(
            color: colors.primary,
          ),
        ),
      );
    }

    final controller = _controller!;

    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width:
            controller.value.size.width,
            height:
            controller.value.size.height,
            child: VideoPlayer(controller),
          ),
        ),

        // Dark overlay.
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.scrim.withValues(
                      alpha: 0.08,
                    ),
                    colors.scrim.withValues(
                      alpha: 0.0,
                    ),
                    colors.scrim.withValues(
                      alpha: 0.35,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Play / pause button.
        Center(
          child: Material(
            color: colors.primary,
            shape: const CircleBorder(),
            elevation: 4,
            child: InkWell(
              onTap: _togglePlay,
              customBorder:
              const CircleBorder(),
              child: Padding(
                padding:
                const EdgeInsets.all(18),
                child: Icon(
                  controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 34,
                  color: colors.onPrimary,
                ),
              ),
            ),
          ),
        ),

        // Video label.
        Positioned(
          left: 16,
          bottom: 16,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surface.withValues(
                alpha: 0.88,
              ),
              borderRadius:
              BorderRadius.circular(999),
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              child: Row(
                mainAxisSize:
                MainAxisSize.min,
                children: [
                  Icon(
                    Icons.videocam_outlined,
                    size: 16,
                    color:
                    colors.onSurface,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Property Video',
                    style: AppTextStyles.labelSmall
                        .copyWith(
                      color:
                      colors.onSurface,
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
}
