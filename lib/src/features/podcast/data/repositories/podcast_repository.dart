import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/podcast_models.dart';

class PodcastRepository {
  final ApiClient _apiClient;

  PodcastRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<List<Episode>> getTrendingEpisodes({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/episodes/trending',
        queryParameters: {'page': page, 'per_page': perPage},
      );

      final List<dynamic> episodesJson = response.data['data']['data']['data'];
      return episodesJson.map((json) => Episode.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch trending episodes: ${e.message}');
    }
  }

  Future<Episode> getEpisodeDetails(int episodeId) async {
    try {
      final response = await _apiClient.dio.get('/api/episodes/$episodeId');
      return Episode.fromJson(response.data['data']['data']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Episode not found');
      }
      throw Exception('Failed to fetch episode details: ${e.message}');
    }
  }

  Future<List<Podcast>> getTopPodcasts({int page = 1, int perPage = 10}) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/podcasts/top-jolly',
        queryParameters: {'page': page, 'per_page': perPage},
      );

      final List<dynamic> podcastsJson = response.data['data']['data'];
      return podcastsJson.map((json) => Podcast.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch top podcasts: ${e.message}');
    }
  }

  Future<Episode> getEditorPick() async {
    try {
      final response = await _apiClient.dio.get('/api/episodes/editor-pick');

      // Check if response has nested data structure
      final data = response.data['data'];
      if (data is Map && data.containsKey('data')) {
        return Episode.fromJson(data['data']);
      }
      return Episode.fromJson(data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch editor\'s pick: ${e.message}');
    }
  }
}
