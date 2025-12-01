// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PodcastImpl _$$PodcastImplFromJson(Map<String, dynamic> json) =>
    _$PodcastImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['picture_url'] as String?,
      author: json['author'] as String?,
      podcastUrl: json['podcast_url'] as String?,
    );

Map<String, dynamic> _$$PodcastImplToJson(_$PodcastImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'picture_url': instance.imageUrl,
      'author': instance.author,
      'podcast_url': instance.podcastUrl,
    };

_$EpisodeImpl _$$EpisodeImplFromJson(Map<String, dynamic> json) =>
    _$EpisodeImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      audioUrl: json['content_url'] as String?,
      imageUrl: json['picture_url'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      podcastId: (json['podcast_id'] as num?)?.toInt(),
      podcast: json['podcast'] == null
          ? null
          : Podcast.fromJson(json['podcast'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EpisodeImplToJson(_$EpisodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'content_url': instance.audioUrl,
      'picture_url': instance.imageUrl,
      'duration': instance.duration,
      'podcast_id': instance.podcastId,
      'podcast': instance.podcast,
    };
