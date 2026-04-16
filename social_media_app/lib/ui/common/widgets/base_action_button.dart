import 'package:flutter/material.dart';

class BaseActionButton extends StatefulWidget {
  final IconData? icon;
  final IconData outlinedIcon;
  final Color? color;
  final void Function()? handleShowBottomSheet;

  const BaseActionButton({
    super.key,
    this.icon,
    required this.outlinedIcon,
    this.color,
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
  bool get isColoredButton => widget.color != null;

  @override
  Widget build(BuildContext context) {
    final iconColor = isColoredButton && isLiked
        ? widget.color
        : Colors.black;

    final icon = widget.icon != null
        ? isLiked
            ? widget.icon
            : widget.outlinedIcon
        : widget.outlinedIcon;

    return ScaleTransition(
      scale: _scale,
      child: IconButton(
        onPressed: _onTap,
        icon: Icon(
          icon,
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
    // if (isColoredButton) {
    setState(() {
      isLiked = !isLiked;
    });

    _controller.forward(from: 0);
    // }
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
