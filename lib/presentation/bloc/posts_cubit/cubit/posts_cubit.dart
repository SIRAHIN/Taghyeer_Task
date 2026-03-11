import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/data/api_service/user_api_service.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/domain/posts_response/posts_response.dart';

part 'posts_state.dart';
part 'posts_cubit.freezed.dart';

@injectable
class PostsCubit extends Cubit<PostsState> {
  final UserApiService _userService;
  PostsCubit(this._userService) : super(const PostsState.initial());

  // Posts Pagination
  int skip = 0;
  int limit = 10;
  bool isLoading = false;
  bool hasMore = true;
  List<Post> posts = [];

  Future<void> getAllPosts() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    if (posts.isEmpty) {
      emit(const PostsState.loading());
    } else {
      emit(PostsState.success(posts: List.of(posts), isLoadingMore: true));
    }

    final result = await _userService.getAllPosts(skip: skip);
    result.fold(
      (error) {
        if (posts.isEmpty) {
          emit(PostsState.error(errorResponse: error));
        } else {
          emit(PostsState.success(posts: List.of(posts), isLoadingMore: false));
        }
      },
      (response) {
        posts.addAll(response.posts);
        skip += limit;
        hasMore = response.posts.length == limit;
        emit(PostsState.success(posts: List.of(posts), isLoadingMore: false));
      },
    );
    isLoading = false;
  }
}
