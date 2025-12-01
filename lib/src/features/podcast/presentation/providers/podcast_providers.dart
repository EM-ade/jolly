import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../../data/models/podcast_models.dart';
import '../../data/repositories/podcast_repository.dart';

// Repository Provider
final podcastRepositoryProvider = Provider<PodcastRepository>((ref) {
  return PodcastRepository();
});

// Trending Episodes Provider
final trendingEpisodesProvider = FutureProvider<List<Episode>>((ref) async {
  final repository = ref.watch(podcastRepositoryProvider);
  return repository.getTrendingEpisodes(page: 1, perPage: 10);
});

// Editor's Pick Provider
final editorPickProvider = FutureProvider<Episode>((ref) async {
  final repository = ref.watch(podcastRepositoryProvider);
  return repository.getEditorPick();
});

// Audio Player Provider
final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  ref.onDispose(() => player.dispose());
  return player;
});

// Player State Provider
class PlayerState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final Episode? currentEpisode;

  PlayerState({
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.currentEpisode,
  });

  PlayerState copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    Episode? currentEpisode,
  }) {
    return PlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      currentEpisode: currentEpisode ?? this.currentEpisode,
    );
  }
}

class PlayerNotifier extends Notifier<PlayerState> {
  late final AudioPlayer _audioPlayer;

  @override
  PlayerState build() {
    _audioPlayer = ref.watch(audioPlayerProvider);
    _setupListeners();
    return PlayerState();
  }

  void _setupListeners() {
    _audioPlayer.playingStream.listen((isPlaying) {
      state = state.copyWith(isPlaying: isPlaying);
    });

    _audioPlayer.positionStream.listen((position) {
      state = state.copyWith(position: position);
    });

    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        state = state.copyWith(duration: duration);
      }
    });
  }

  Future<void> loadEpisode(Episode episode) async {
    if (episode.audioUrl == null) {
      throw Exception('Episode has no audio URL');
    }

    state = state.copyWith(currentEpisode: episode);
    await _audioPlayer.setUrl(episode.audioUrl!);
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> seekRelative(Duration offset) async {
    final newPosition = state.position + offset;
    await seek(newPosition);
  }
}

final playerProvider = NotifierProvider<PlayerNotifier, PlayerState>(
  PlayerNotifier.new,
);
