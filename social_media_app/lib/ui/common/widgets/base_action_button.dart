import 'package:flutter/material.dart';

class BaseActionButton extends StatefulWidget {
  final IconData icon;
  final void Function()? handleShowBottomSheet;

  const BaseActionButton({
    super.key,
    required this.icon,
    this.handleShowBottomSheet,
  });

  @override
  State<BaseActionButton> createState() =>
      _BaseActionButtonState();
}

class _BaseActionButtonState extends State<BaseActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  bool isLiked = false;

  bool get isLikeButton =>
      widget.icon == Icons.favorite_border ||
      widget.icon == Icons.favorite;

  @override
  Widget build(BuildContext context) {
    final iconData = isLikeButton
        ? (isLiked ? Icons.favorite : Icons.favorite_border)
        : widget.icon;

    final iconColor =
        isLikeButton && isLiked ? Colors.red : Colors.black;

    return ScaleTransition(
      scale: _scale,
      child: IconButton(
        onPressed: _onTap,
        icon: Icon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scale = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.3)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.3, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  void _onTap() {
    if (isLikeButton) {
      setState(() {
        isLiked = !isLiked;
      });

      _controller.forward(from: 0);
    }
    if (widget.handleShowBottomSheet != null) {
      widget.handleShowBottomSheet!();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
