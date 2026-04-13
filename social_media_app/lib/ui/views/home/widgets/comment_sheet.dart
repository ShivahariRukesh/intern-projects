import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class CommentSheet extends StatefulWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const CommentSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final TextEditingController _textController =
      TextEditingController();

  late AnimationController _sendController;
  late Animation<double> _scaleAnim;
  late Animation<double> _rotateAnim;
  Widget _commentTile(Map<String, String> comment) {
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

  Widget _inputField() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
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
              if (_textController.text.trim().isEmpty)
                return;

              await _sendController.forward();
              _sendController.reverse();

              setState(() {
                comments.insert(0, {
                  "name": "You",
                  "comment": _textController.text,
                  "time": "now",
                });
              });

              _textController.clear();
            },
            child: AnimatedBuilder(
              animation: _sendController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnim.value,
                  child: Transform.rotate(
                    angle: _rotateAnim.value,
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

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)),
          ),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              Text(
                widget.request.title ?? "Comments",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];

                    return _AnimatedCommentItem(
                      delay: index * 100,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12),
                        child: _commentTile(comment),
                      ),
                    );
                  },
                ),
              ),
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 600),
                tween: Tween<double>(begin: 50, end: 0),
                curve: Curves.easeOut,
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(0, value),
                    child: Opacity(
                      opacity: 1 - (value / 50),
                      child: child,
                    ),
                  );
                },
                child: _inputField(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final comments = [
    {
      "name": "John Doe",
      "comment": "This is awesome 🔥",
      "time": "2h ago"
    },
    {
      "name": "Sarah",
      "comment": "Loved this post!",
      "time": "3h ago"
    },
    {
      "name": "Alex",
      "comment": "Where is this place?",
      "time": "5h ago"
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
        parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();

    _sendController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnim = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.8), weight: 50),
      TweenSequenceItem(
          tween: Tween(begin: 0.8, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _sendController,
      curve: Curves.easeOut,
    ));

    _rotateAnim = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
          parent: _sendController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _sendController.dispose();
    _textController.dispose();
    super.dispose();
  }
}

class _AnimatedCommentItem extends StatefulWidget {
  final Widget child;
  final int delay;

  const _AnimatedCommentItem({
    required this.child,
    required this.delay,
  });

  @override
  State<_AnimatedCommentItem> createState() =>
      _AnimatedCommentItemState();
}

class _AnimatedCommentItemState
    extends State<_AnimatedCommentItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fade = CurvedAnimation(
        parent: _controller, curve: Curves.easeIn);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: widget.delay),
        () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
