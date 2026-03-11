import 'package:flutter/material.dart';
import 'package:taghyeer_task/domain/posts_response/posts_response.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;
  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Details"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              post.body,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.thumb_up_alt_outlined, color: Colors.blue),
                const SizedBox(width: 4),
                Text('${post.reactions.likes}'),
                const SizedBox(width: 16),
                const Icon(Icons.thumb_down_alt_outlined, color: Colors.red),
                const SizedBox(width: 4),
                Text('${post.reactions.dislikes}'),
                const Spacer(),
                const Icon(Icons.remove_red_eye_outlined, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${post.views}'),
              ],
            ),
            const SizedBox(height: 24),
            const Text("More Content Here..."),
          ],
        ),
      ),
    );
  }
}
