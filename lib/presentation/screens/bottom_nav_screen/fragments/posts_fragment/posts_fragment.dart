import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_task/presentation/bloc/posts_cubit/cubit/posts_cubit.dart';

class PostsFragment extends StatefulWidget {
  const PostsFragment({super.key});

  @override
  State<PostsFragment> createState() => _PostsFragmentState();
}

class _PostsFragmentState extends State<PostsFragment> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // initial fetch
    context.read<PostsCubit>().getAllPosts();

    // fetch more
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<PostsCubit>().getAllPosts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Posts",
          style: TextStyle(color: Colors.white, wordSpacing: 14),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (posts, isLoadingMore) {
              if (posts.isEmpty) {
                return const Center(child: Text("No Posts Available"));
              }

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(10),
                itemCount: posts.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == posts.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final post = posts[index];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            post.body,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.thumb_up_alt_outlined,
                                  size: 18, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text('${post.reactions.likes}'),
                              const SizedBox(width: 16),
                              const Icon(Icons.thumb_down_alt_outlined,
                                  size: 18, color: Colors.red),
                              const SizedBox(width: 4),
                              Text('${post.reactions.dislikes}'),
                              const Spacer(),
                              const Icon(Icons.remove_red_eye_outlined,
                                  size: 18, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text('${post.views}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            error: (errorResponse) => Center(
              child: Text(errorResponse.message ?? "Something went wrong"),
            ),
          );
        },
      ),
    );
  }
}
