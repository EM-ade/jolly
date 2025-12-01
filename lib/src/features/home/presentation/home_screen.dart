import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/section_header.dart';
import 'widgets/hot_podcast_card.dart';
import 'widgets/editor_pick_card.dart';
import 'widgets/bottom_nav_bar.dart';
import '../../../core/animations/animation_widgets.dart';
import '../../../core/common_widgets/loading_indicator.dart';
import '../../podcast/presentation/providers/podcast_providers.dart';
import '../../podcast/data/models/podcast_models.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  void _navigateToPlayer(Episode episode) {
    context.push('/player/${episode.id}');
  }

  @override
  Widget build(BuildContext context) {
    final trendingEpisodesAsync = ref.watch(trendingEpisodesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF001010),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // Hot & Trending Section
            const StaggeredAnimation(
              index: 0,
              child: SectionHeader(
                icon: 'assets/images/hot_podcast.png',
                title: 'Hot & trending episodes',
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 400,
              child: trendingEpisodesAsync.when(
                data: (episodes) {
                  if (episodes.isEmpty) {
                    return const Center(
                      child: Text(
                        'No trending episodes',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      final episode = episodes[index];
                      return StaggeredAnimation(
                        index: index + 1,
                        delay: const Duration(milliseconds: 100),
                        child: HotPodcastCard(
                          imageUrl:
                              episode.imageUrl ??
                              'assets/images/podcast_cover_1.jpg',
                          category: episode.podcast?.title ?? 'Podcast',
                          title: episode.title,
                          description: episode.description ?? '',
                          onPlay: () => _navigateToPlayer(episode),
                          onLike: () {},
                          onAdd: () {},
                          onShare: () {},
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: LoadingIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Failed to load episodes',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => ref.refresh(trendingEpisodesProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Editor's Pick Section with star SVG
            StaggeredAnimation(
              index: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    ScaleBounceAnimation(
                      delay: const Duration(milliseconds: 400),
                      child: SvgPicture.asset(
                        'assets/images/star.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF7B61FF),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Editor\'s pick',
                      style: TextStyle(
                        fontFamily: 'Futura PT',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Consumer(
              builder: (context, ref, child) {
                final editorPickAsync = ref.watch(editorPickProvider);

                return editorPickAsync.when(
                  data: (episode) => StaggeredAnimation(
                    index: 5,
                    child: EditorPickCard(
                      imageUrl:
                          episode.imageUrl ??
                          'assets/images/podcast_cover_3.jpg',
                      title: episode.title,
                      author: episode.podcast?.author ?? 'Unknown',
                      description: episode.description ?? '',
                      onPlay: () => _navigateToPlayer(episode),
                      onFollow: () {},
                      onShare: () {},
                    ),
                  ),
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: LoadingIndicator(),
                    ),
                  ),
                  error: (error, stack) => const SizedBox.shrink(),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
