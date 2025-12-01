import 'package:freezed_annotation/freezed_annotation.dart';

part 'podcast_models.freezed.dart';
part 'podcast_models.g.dart';

@freezed
class Podcast with _$Podcast {
  const factory Podcast({
    required int id,
    required String title,
    String? description,
    @JsonKey(name: 'picture_url') String? imageUrl,
    String? author,
    @JsonKey(name: 'podcast_url') String? podcastUrl,
  }) = _Podcast;

  factory Podcast.fromJson(Map<String, dynamic> json) =>
      _$PodcastFromJson(json);
}

@freezed
class Episode with _$Episode {
  const factory Episode({
    required int id,
    required String title,
    String? description,
    @JsonKey(name: 'content_url') String? audioUrl,
    @JsonKey(name: 'picture_url') String? imageUrl,
    int? duration,
    @JsonKey(name: 'podcast_id') int? podcastId,
    Podcast? podcast,
  }) = _Episode;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}
