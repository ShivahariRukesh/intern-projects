import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';

class PostWidget extends StatelessWidget {
  final List<PostModel> posts;
  const PostWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 200,
      child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) => ListTile(
                title: Text(
                    "HHello There! ${posts[index].title}"),
                tileColor: Colors.amberAccent,
              )),
    );
  }
}
