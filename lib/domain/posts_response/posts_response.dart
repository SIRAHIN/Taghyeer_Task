import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_response.freezed.dart';
part 'posts_response.g.dart';

@freezed
class PostsResponse with _$PostsResponse {
  const factory PostsResponse({
    required List<Post> posts,
    required int total,
    required int skip,
    required int limit,
  }) = _PostsResponse;

  factory PostsResponse.fromJson(Map<String, dynamic> json) =>
      _$PostsResponseFromJson(json);
}

@freezed
class Post with _$Post {
  const factory Post({
    required int id,
    required String title,
    required String body,
    required List<String> tags,
    required Reactions reactions,
    required int views,
    required int userId,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);
}

@freezed
class Reactions with _$Reactions {
  const factory Reactions({
    required int likes,
    required int dislikes,
  }) = _Reactions;

  factory Reactions.fromJson(Map<String, dynamic> json) =>
      _$ReactionsFromJson(json);
}