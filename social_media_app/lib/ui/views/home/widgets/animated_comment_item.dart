import 'package:flutter/material.dart';

class AnimatedCommentItem extends StatefulWidget {
  final Widget child;
  final int delay;

  const AnimatedCommentItem({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  State<AnimatedCommentItem> createState() =>
      _AnimatedCommentItemState();
}

class _AnimatedCommentItemState
    extends State<AnimatedCommentItem>
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
