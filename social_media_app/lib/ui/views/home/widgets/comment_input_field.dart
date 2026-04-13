import 'package:flutter/material.dart';

class CommentInputField extends StatelessWidget {
  final TextEditingController textController;
  final AnimationController sendController;
  final List<Map<String, String>> comments;
  final Animation<double> scaleAnim;
  final Animation<double> rotateAnim;
  final void Function(Function()) setState;

  const CommentInputField({
    super.key,
    required this.textController,
    required this.sendController,
    required this.scaleAnim,
    required this.rotateAnim,
    required this.comments,
    required this.setState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Write a comment...",
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () async {
              if (textController.text.trim().isEmpty) {
                return;
              }
              await sendController.forward();
              sendController.reverse();
              setState(() {
                comments.insert(0, {
                  "name": "You",
                  "comment": textController.text,
                  "time": "now",
                });
              });
              textController.clear();
            },
            child: AnimatedBuilder(
              animation: sendController,
              builder: (context, child) {
                return Transform.scale(
                  scale: scaleAnim.value,
                  child: Transform.rotate(
                    angle: rotateAnim.value,
                    child: child,
                  ),
                );
              },
              child: const Icon(Icons.send,
                  color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
