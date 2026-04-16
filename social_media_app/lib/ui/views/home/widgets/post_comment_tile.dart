import 'package:flutter/material.dart';

class PostCommentTile extends StatelessWidget {
  final Map<String, String> comment;
  const PostCommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey.shade300,
          child: const Icon(Icons.person, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment["name"]!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(comment["comment"]!),
                const SizedBox(height: 6),
                Text(
                  comment["time"]!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
