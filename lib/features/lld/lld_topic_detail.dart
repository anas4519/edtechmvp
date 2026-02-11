import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/topic.dart';

/// Default video URL used for all LLD topics
const _defaultVideoUrl =
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

class LldTopicDetail extends StatefulWidget {
  final Topic topic;

  const LldTopicDetail({super.key, required this.topic});

  @override
  State<LldTopicDetail> createState() => _LldTopicDetailState();
}

class _LldTopicDetailState extends State<LldTopicDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CachedVideoPlayerPlusController? _videoController;
  bool _isVideoInitialized = false;
  bool _showControls = true;
  bool _isCompleted = false;
  bool _isStudyView = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initVideo();
  }

  void _initVideo() {
    _videoController =
        CachedVideoPlayerPlusController.networkUrl(Uri.parse(_defaultVideoUrl))
          ..initialize().then((_) {
            if (mounted) setState(() => _isVideoInitialized = true);
          });
    _videoController!.addListener(_videoListener);
  }

  void _videoListener() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    super.dispose();
  }

  void _seekRelative(int seconds) {
    if (_videoController == null || !_isVideoInitialized) return;
    final current = _videoController!.value.position;
    _videoController!.seekTo(current + Duration(seconds: seconds));
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.topic.title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          if (!_isStudyView) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
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
                                  child: CachedVideoPlayerPlus(
                                    _videoController!,
                                  ),
                                ),
                                AnimatedOpacity(
                                  opacity: _showControls ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 250),
                                  child: Container(
                                    color: Colors.black.withValues(alpha: 0.45),
                                    child: Column(
                                      children: [
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
                                                      : Icons
                                                            .play_arrow_rounded,
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
            ),

            // Completed checkbox
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => setState(() => _isCompleted = !_isCompleted),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: _isCompleted
                              ? AppColors.success
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _isCompleted
                                ? AppColors.success
                                : (isDark
                                      ? AppColors.textGray
                                      : AppColors.textMuted),
                            width: 1.5,
                          ),
                        ),
                        child: _isCompleted
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              )
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Completed',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textGray
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ], // end study view condition

          const SizedBox(height: 8),

          // Theory / Discussion tabs
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 0.5,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: AppColors.amber,
              unselectedLabelColor: isDark
                  ? AppColors.textGray
                  : AppColors.textMuted,
              indicatorColor: AppColors.amber,
              indicatorWeight: 2.5,
              labelStyle: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.menu_book_rounded, size: 16),
                      const SizedBox(width: 6),
                      const Text('Theory'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat_bubble_outline_rounded, size: 16),
                      const SizedBox(width: 6),
                      const Text('Discussion'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _TheoryTab(
                  topicTitle: widget.topic.title,
                  isDark: isDark,
                  isStudyView: _isStudyView,
                  onStudyViewChanged: (val) =>
                      setState(() => _isStudyView = val),
                ),
                _DiscussionTab(isDark: isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Theory Tab
// ─────────────────────────────────────────────────────────────────────────────

class _TheoryTab extends StatelessWidget {
  final String topicTitle;
  final bool isDark;
  final bool isStudyView;
  final ValueChanged<bool> onStudyViewChanged;

  const _TheoryTab({
    required this.topicTitle,
    required this.isDark,
    required this.isStudyView,
    required this.onStudyViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description pill + Study view toggle
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 0.5,
                  ),
                ),
                child: Text(
                  'Description',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Study view',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                height: 24,
                child: Switch(
                  value: isStudyView,
                  onChanged: onStudyViewChanged,
                  activeColor: AppColors.amber,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Introduction section
          Text(
            'Introduction',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.amber,
            ),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.7,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
              ),
              children: [
                const TextSpan(
                  text: 'Structural design patterns are concerned with the ',
                ),
                TextSpan(
                  text: 'composition of classes and objects',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
                const TextSpan(
                  text:
                      '. They help in forming large object structures while keeping them manageable, decoupled, and easy to work with. One such pattern is the ',
                ),
                TextSpan(
                  text: 'Facade Pattern',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
                const TextSpan(
                  text:
                      ', which simplifies complex systems by providing a unified interface. Let\'s dive deeper.',
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Facade Pattern heading
          Text(
            'Facade Pattern',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.amber,
            ),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.7,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
              ),
              children: [
                const TextSpan(text: 'The '),
                TextSpan(
                  text: 'Facade Pattern',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
                const TextSpan(
                  text:
                      ' is a structural design pattern that provides a simplified, unified interface to a complex subsystem or group of classes.\n\n',
                ),
                const TextSpan(
                  text:
                      'Instead of interacting with multiple classes directly, the client communicates through a ',
                ),
                TextSpan(
                  text: 'single facade class',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
                const TextSpan(
                  text:
                      ' that delegates the calls to the appropriate subsystem components.',
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // When to use
          Text(
            'When to Use',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ..._buildBulletList([
            'When you want to provide a simple interface to a complex subsystem.',
            'When you want to decouple the client from subsystem implementation details.',
            'When you want to layer your subsystems and define entry points.',
          ], theme),

          const SizedBox(height: 28),

          // Code example
          Text(
            'Code Example',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          _CodeBlock(
            isDark: isDark,
            code: '''// Subsystem classes
class CPU {
  void freeze() => print("CPU frozen");
  void jump(int addr) => print("Jump to \$addr");
  void execute() => print("CPU executing");
}

class Memory {
  void load(int addr, String data) =>
      print("Loading '\$data' at \$addr");
}

class HardDrive {
  String read(int lba, int size) => "boot_data";
}

// Facade
class ComputerFacade {
  final CPU _cpu = CPU();
  final Memory _mem = Memory();
  final HardDrive _hd = HardDrive();

  void start() {
    _cpu.freeze();
    _mem.load(0, _hd.read(0, 1024));
    _cpu.jump(0);
    _cpu.execute();
  }
}

// Client code
void main() {
  final computer = ComputerFacade();
  computer.start(); // Simple!
}''',
          ),

          const SizedBox(height: 28),

          // Class diagram
          Text(
            'Class Diagram',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          _ClassDiagram(isDark: isDark),

          const SizedBox(height: 28),

          // Key points
          Text(
            'Key Points',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ..._buildBulletList([
            'Facade doesn\'t encapsulate subsystem classes — clients can still use them directly if needed.',
            'It promotes weak coupling between the subsystem and its clients.',
            'It\'s often used with other patterns like Singleton (for the facade) or Abstract Factory (to create subsystem objects).',
            'It follows the Principle of Least Knowledge (Law of Demeter).',
          ], theme),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  List<Widget> _buildBulletList(List<String> items, ThemeData theme) {
    return items
        .map(
          (text) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.amber,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.5,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.85,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Code Block Widget
// ─────────────────────────────────────────────────────────────────────────────

class _CodeBlock extends StatelessWidget {
  final String code;
  final bool isDark;

  const _CodeBlock({required this.code, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0D0B08) : const Color(0xFFE8E3DC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: GoogleFonts.robotoMono(
            fontSize: 12,
            height: 1.5,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Class Diagram (drawn with CustomPainter)
// ─────────────────────────────────────────────────────────────────────────────

class _ClassDiagram extends StatelessWidget {
  final bool isDark;

  const _ClassDiagram({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0D0B08) : const Color(0xFFF5F0EA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // Client
          _DiagramBox(
            label: 'Client',
            subtitle: 'Uses Facade only',
            color: AppColors.textGray,
            isDark: isDark,
          ),
          _Arrow(isDark: isDark),
          // Facade
          _DiagramBox(
            label: 'ComputerFacade',
            subtitle: '+ start()',
            color: AppColors.amber,
            isDark: isDark,
          ),
          _Arrow(isDark: isDark),
          // Subsystems row
          Row(
            children: [
              Expanded(
                child: _DiagramBox(
                  label: 'CPU',
                  subtitle: 'freeze()\njump()\nexecute()',
                  color: AppColors.teal,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DiagramBox(
                  label: 'Memory',
                  subtitle: 'load()',
                  color: AppColors.teal,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DiagramBox(
                  label: 'HardDrive',
                  subtitle: 'read()',
                  color: AppColors.teal,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiagramBox extends StatelessWidget {
  final String label;
  final String subtitle;
  final Color color;
  final bool isDark;

  const _DiagramBox({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.robotoMono(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoMono(
              fontSize: 10,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  final bool isDark;
  const _Arrow({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Icon(
        Icons.arrow_downward_rounded,
        size: 20,
        color: isDark ? AppColors.textGray : AppColors.textMuted,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Discussion Tab (placeholder)
// ─────────────────────────────────────────────────────────────────────────────

class _DiscussionTab extends StatelessWidget {
  final bool isDark;

  const _DiscussionTab({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 48,
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
          const SizedBox(height: 12),
          Text(
            'No discussions yet.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Fullscreen Video Player (reused pattern from DSA editorial)
// ─────────────────────────────────────────────────────────────────────────────

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
