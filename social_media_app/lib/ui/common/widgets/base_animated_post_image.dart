import 'package:flutter/material.dart';

class BaseAnimatedPostImage extends StatefulWidget {
  final Widget child;

  const BaseAnimatedPostImage(
      {super.key, required this.child});

  @override
  State<BaseAnimatedPostImage> createState() =>
      _BaseAnimatedPostImageState();
}

class _BaseAnimatedPostImageState
    extends State<BaseAnimatedPostImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: widget.child,
    );
  }
}
