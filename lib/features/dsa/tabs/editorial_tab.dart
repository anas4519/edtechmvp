import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/problem.dart';
import '../../../data/models/problem_content.dart';

class EditorialTab extends StatefulWidget {
  final Problem problem;

  const EditorialTab({super.key, required this.problem});

  @override
  State<EditorialTab> createState() => _EditorialTabState();
}

class _EditorialTabState extends State<EditorialTab> {
  CachedVideoPlayerPlusController? _videoController;
  bool _isVideoInitialized = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  void _initVideo() {
    final videoUrl = widget.problem.editorial?.videoUrl;
    if (videoUrl != null && videoUrl.isNotEmpty) {
      _videoController =
          CachedVideoPlayerPlusController.networkUrl(Uri.parse(videoUrl))
            ..initialize().then((_) {
              if (mounted) {
                setState(() => _isVideoInitialized = true);
              }
            });
      _videoController!.addListener(_videoListener);
    }
  }

  void _videoListener() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    super.dispose();
  }

  void _seekRelative(int seconds) {
    if (_videoController == null || !_isVideoInitialized) return;
    final current = _videoController!.value.position;
    final target = current + Duration(seconds: seconds);
    _videoController!.seekTo(target);
  }

  void _togglePlayPause() {
    if (_videoController == null || !_isVideoInitialized) return;
    setState(() {
      _videoController!.value.isPlaying
          ? _videoController!.pause()
          : _videoController!.play();
    });
  }

  void _openFullscreen() {
    if (_videoController == null || !_isVideoInitialized) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _FullscreenVideoPlayer(controller: _videoController!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final editorial = widget.problem.editorial;

    if (editorial == null) {
      return Center(
        child: Text(
          'No editorial available yet.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video player
          if (_videoController != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.black,
                  child: _isVideoInitialized
                      ? GestureDetector(
                          onTap: () =>
                              setState(() => _showControls = !_showControls),
                          child: Stack(
                            children: [
                              Center(
                                child: CachedVideoPlayerPlus(_videoController!),
                              ),
                              // Controls overlay
                              AnimatedOpacity(
                                opacity: _showControls ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 250),
                                child: Container(
                                  color: Colors.black.withValues(alpha: 0.45),
                                  child: Column(
                                    children: [
                                      // Top row — fullscreen
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: GestureDetector(
                                            onTap: _openFullscreen,
                                            child: const Icon(
                                              Icons.fullscreen_rounded,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Center controls
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () => _seekRelative(-10),
                                              child: const Icon(
                                                Icons.replay_10_rounded,
                                                color: Colors.white,
                                                size: 36,
                                              ),
                                            ),
                                            const SizedBox(width: 32),
                                            GestureDetector(
                                              onTap: _togglePlayPause,
                                              child: Icon(
                                                _videoController!
                                                        .value
                                                        .isPlaying
                                                    ? Icons.pause_rounded
                                                    : Icons.play_arrow_rounded,
                                                color: Colors.white,
                                                size: 48,
                                              ),
                                            ),
                                            const SizedBox(width: 32),
                                            GestureDetector(
                                              onTap: () => _seekRelative(10),
                                              child: const Icon(
                                                Icons.forward_10_rounded,
                                                color: Colors.white,
                                                size: 36,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Progress bar
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: VideoProgressIndicator(
                                          _videoController!,
                                          allowScrubbing: true,
                                          colors: VideoProgressColors(
                                            playedColor: AppColors.amber,
                                            bufferedColor: Colors.white
                                                .withValues(alpha: 0.3),
                                            backgroundColor: Colors.white
                                                .withValues(alpha: 0.1),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                ),
              ),
            ),
          const SizedBox(height: 24),

          // Tutorial heading
          Text(
            'Tutorial',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),

          // Approaches
          ...editorial.approaches.asMap().entries.map((entry) {
            final idx = entry.key;
            final approach = entry.value;
            return _ApproachCard(
              approach: approach,
              index: idx,
              isDark: isDark,
            );
          }),
        ],
      ),
    );
  }
}

/// Fullscreen video player shown as a new route
class _FullscreenVideoPlayer extends StatefulWidget {
  final CachedVideoPlayerPlusController controller;

  const _FullscreenVideoPlayer({required this.controller});

  @override
  State<_FullscreenVideoPlayer> createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<_FullscreenVideoPlayer> {
  bool _showControls = true;

  void _listener() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  void _seekRelative(int seconds) {
    final current = widget.controller.value.position;
    widget.controller.seekTo(current + Duration(seconds: seconds));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => setState(() => _showControls = !_showControls),
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio > 0
                      ? widget.controller.value.aspectRatio
                      : 16 / 9,
                  child: CachedVideoPlayerPlus(widget.controller),
                ),
              ),
              AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.45),
                  child: Column(
                    children: [
                      // Close button
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => _seekRelative(-10),
                              child: const Icon(
                                Icons.replay_10_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(width: 40),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.controller.value.isPlaying
                                      ? widget.controller.pause()
                                      : widget.controller.play();
                                });
                              },
                              child: Icon(
                                widget.controller.value.isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 56,
                              ),
                            ),
                            const SizedBox(width: 40),
                            GestureDetector(
                              onTap: () => _seekRelative(10),
                              child: const Icon(
                                Icons.forward_10_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: VideoProgressIndicator(
                          widget.controller,
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            playedColor: AppColors.amber,
                            bufferedColor: Colors.white.withValues(alpha: 0.3),
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
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

class _ApproachCard extends StatefulWidget {
  final Approach approach;
  final int index;
  final bool isDark;

  const _ApproachCard({
    required this.approach,
    required this.index,
    required this.isDark,
  });

  @override
  State<_ApproachCard> createState() => _ApproachCardState();
}

class _ApproachCardState extends State<_ApproachCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final approach = widget.approach;
    final isDark = widget.isDark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      approach.name,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.amber,
                      ),
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: isDark ? AppColors.textGray : AppColors.textMuted,
                  ),
                ],
              ),
            ),
          ),

          if (_expanded) ...[
            Divider(
              height: 1,
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Intuition
                  Text(
                    'Intuition',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    approach.intuition,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.5,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.85,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Code block
                  Text(
                    'Code',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF0D0B08)
                          : const Color(0xFFE8E3DC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        approach.code,
                        style: GoogleFonts.robotoMono(
                          fontSize: 12,
                          height: 1.5,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.85,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Complexity
                  Row(
                    children: [
                      _ComplexityChip(
                        label: 'Time: ${approach.timeComplexity}',
                        isDark: isDark,
                      ),
                      const SizedBox(width: 8),
                      _ComplexityChip(
                        label: 'Space: ${approach.spaceComplexity}',
                        isDark: isDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ComplexityChip extends StatelessWidget {
  final String label;
  final bool isDark;

  const _ComplexityChip({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.teal.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.robotoMono(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.teal,
        ),
      ),
    );
  }
}
