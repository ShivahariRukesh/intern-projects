import 'package:flutter/material.dart';
import 'package:social_media_app/ui/views/home/widgets/animated_comment_item.dart';
import 'package:social_media_app/ui/views/home/widgets/comment_input_field.dart';
import 'package:social_media_app/ui/views/home/widgets/post_comment_tile.dart';
import 'package:social_media_app/utils/mock_comments.dart';
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
              _commentListWidget(),
              _commentInputFieldWidget(),
            ],
          ),
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> _commentInputFieldWidget() {
    return TweenAnimationBuilder(
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
      child: CommentInputField(
          textController: _textController,
          sendController: _sendController,
          scaleAnim: _scaleAnim,
          rotateAnim: _rotateAnim,
          comments: comments,
          setState: setState),
    );
  }

  Expanded _commentListWidget() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];

          return AnimatedCommentItem(
            delay: index * 100,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PostCommentTile(comment: comment)),
          );
        },
      ),
    );
  }

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
