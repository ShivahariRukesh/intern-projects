import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/ui/views/home/widgets/post_card_widget.dart';

class PostFeedWidget extends StatelessWidget {
  final List<PostModel> posts;
  final Map<int, String> usernameMap;

  const PostFeedWidget({
    super.key,
    required this.posts,
    required this.usernameMap,
  });

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const Center(
          child: CircularProgressIndicator());
    }

    return Column(
      children: posts.map((post) {
        return PostCardWidget(
          post: post,
          username: usernameMap[post.userId] ?? 'Anonymous',
        );
      }).toList(),
    );
  }
}
