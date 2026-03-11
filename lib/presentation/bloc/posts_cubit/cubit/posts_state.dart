part of 'posts_cubit.dart';

@freezed
class PostsState with _$PostsState {
  const factory PostsState.initial() = _Initial;
  const factory PostsState.loading() = _Loading;
  const factory PostsState.success({
    required List<Post> posts,
    @Default(false) bool isLoadingMore,
  }) = _Success;
  const factory PostsState.error({required ErrorResponse errorResponse}) =
      _Error;
}
