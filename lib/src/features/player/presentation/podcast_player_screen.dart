import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'widgets/playback_controls.dart';
import 'widgets/player_action_button.dart';
import 'widgets/player_progress_bar.dart';
import '../../../core/animations/animation_widgets.dart';
import '../../podcast/data/models/podcast_models.dart';
import '../../podcast/presentation/providers/podcast_providers.dart';

class PodcastPlayerScreen extends ConsumerStatefulWidget {
  final int episodeId;

  const PodcastPlayerScreen({super.key, required this.episodeId});

  @override
  ConsumerState<PodcastPlayerScreen> createState() =>
      _PodcastPlayerScreenState();
}

class _PodcastPlayerScreenState extends ConsumerState<PodcastPlayerScreen> {
  Episode? _episode;
  bool _isLoading = true;
  String? _error;
  List<Episode> _episodeList = [];
  int _currentIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadEpisode();
    _loadEpisodeList();
  }

  Future<void> _loadEpisodeList() async {
    try {
      final repository = ref.read(podcastRepositoryProvider);
      final episodes = await repository.getTrendingEpisodes(
        page: 1,
        perPage: 50,
      );

      if (mounted) {
        setState(() {
          _episodeList = episodes;
          _currentIndex = episodes.indexWhere((e) => e.id == widget.episodeId);
        });
      }
    } catch (e) {
      // Silently fail - navigation will just be disabled
      print('Failed to load episode list: $e');
    }
  }

  Future<void> _loadEpisode() async {
    try {
      final repository = ref.read(podcastRepositoryProvider);
      final episode = await repository.getEpisodeDetails(widget.episodeId);

      if (mounted) {
        setState(() {
          _episode = episode;
          _isLoading = false;
        });

        // Load the episode into the player
        ref.read(playerProvider.notifier).loadEpisode(episode);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToNextEpisode() {
    if (_currentIndex >= 0 && _currentIndex < _episodeList.length - 1) {
      final nextEpisode = _episodeList[_currentIndex + 1];
      context.pushReplacement('/player/${nextEpisode.id}');
    }
  }

  void _navigateToPreviousEpisode() {
    if (_currentIndex > 0) {
      final previousEpisode = _episodeList[_currentIndex - 1];
      context.pushReplacement('/player/${previousEpisode.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF19AF48).withOpacity(0.85),
                const Color(0xFF0F8F38).withOpacity(0.85),
              ],
            ),
          ),
          child: SafeArea(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : _error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.white, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load episode',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Go Back'),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 16),
                      // Collapse button
                      StaggeredAnimation(
                        index: 0,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              // Podcast cover image
                              StaggeredAnimation(
                                index: 1,
                                child: ScaleBounceAnimation(
                                  delay: const Duration(milliseconds: 200),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child:
                                        _episode!.imageUrl != null &&
                                            _episode!.imageUrl!.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: _episode!.imageUrl!,
                                            width: 320,
                                            height: 320,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                                  width: 320,
                                                  height: 320,
                                                  color: Colors.grey[800],
                                                  child:
                                                      const CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                            errorWidget: (context, url, error) {
                                              print(
                                                'Image load error: $error for URL: $url',
                                              );
                                              return Container(
                                                width: 320,
                                                height: 320,
                                                color: Colors.grey[800],
                                                child: const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.error,
                                                      color: Colors.white,
                                                      size: 48,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      'Failed to load image',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            width: 320,
                                            height: 320,
                                            color: Colors.grey[800],
                                            child: const Icon(
                                              Icons.image_not_supported,
                                              color: Colors.white,
                                              size: 48,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Episode title
                              StaggeredAnimation(
                                index: 2,
                                child: Text(
                                  _episode!.title,
                                  style: const TextStyle(
                                    fontFamily: 'Futura PT',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Episode description
                              StaggeredAnimation(
                                index: 3,
                                child: Text(
                                  _episode!.description ??
                                      'No description available',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                    height: 1.5,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Progress bar
                              StaggeredAnimation(
                                index: 4,
                                child: PlayerProgressBar(
                                  currentTime: playerState.position,
                                  totalDuration: playerState.duration,
                                  onSeek: (position) {
                                    ref
                                        .read(playerProvider.notifier)
                                        .seek(position);
                                  },
                                ),
                              ),
                              const SizedBox(height: 32),
                              // Playback controls
                              StaggeredAnimation(
                                index: 5,
                                child: PlaybackControls(
                                  isPlaying: playerState.isPlaying,
                                  onPlay: () {
                                    ref.read(playerProvider.notifier).play();
                                  },
                                  onPause: () {
                                    ref.read(playerProvider.notifier).pause();
                                  },
                                  onNext: _navigateToNextEpisode,
                                  onPrevious: _navigateToPreviousEpisode,
                                  onRewind: () {
                                    ref
                                        .read(playerProvider.notifier)
                                        .seekRelative(
                                          const Duration(seconds: -10),
                                        );
                                  },
                                  onForward: () {
                                    ref
                                        .read(playerProvider.notifier)
                                        .seekRelative(
                                          const Duration(seconds: 10),
                                        );
                                  },
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Action buttons - Row 1
                              StaggeredAnimation(
                                index: 6,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: PlayerActionButton(
                                        iconPath: 'assets/images/library.svg',
                                        text: 'Add to queue',
                                        onPressed: () {},
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: PlayerActionButton(
                                        iconPath: 'assets/images/heart.svg',
                                        text: 'Save',
                                        onPressed: () {},
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: PlayerActionButton(
                                        iconPath: 'assets/images/share.svg',
                                        text: 'Share',
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Action buttons - Row 2
                              StaggeredAnimation(
                                index: 7,
                                child: Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: PlayerActionButton(
                                            iconPath: 'assets/images/add.svg',
                                            text: 'Add to playlist',
                                            onPressed: () {},
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: PlayerActionButton(
                                            text: 'Go to episode page →',
                                            onPressed: () {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
