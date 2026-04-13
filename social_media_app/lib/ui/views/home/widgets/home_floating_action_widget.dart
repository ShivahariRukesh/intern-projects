import 'package:flutter/material.dart';
import 'package:social_media_app/utils/home_fab_action.dart';

class HomeFloatingActionWidget extends StatefulWidget {
  const HomeFloatingActionWidget({super.key});

  @override
  State<HomeFloatingActionWidget> createState() =>
      _HomeFloatingActionWidgetState();
}

class _HomeFloatingActionWidgetState
    extends State<HomeFloatingActionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnim;
  late Animation<double> _rotateAnim;
  bool _isExpanded = false;
  final _actions = homeFabActions;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ..._actions
            .asMap()
            .entries
            .map((entry) {
              final delay = entry.key * 0.08;
              final action = entry.value;
              return _homeFabAnimatedBuilder(
                  delay, action.label, action.icon);
            })
            .toList()
            .reversed,
        RotationTransition(
          turns: _rotateAnim,
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: const Color(0xFFE91E8C),
            child: const Icon(Icons.add,
                color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }

  AnimatedBuilder _homeFabAnimatedBuilder(
      double delay, String label, icon) {
    return AnimatedBuilder(
      animation: _expandAnim,
      builder: (_, __) {
        final delayedValue =
            ((_expandAnim.value - delay) / (1 - delay))
                .clamp(0.0, 1.0);
        return Opacity(
          opacity: delayedValue,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - delayedValue)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _homeFabActionTextWidget(label),
                  const SizedBox(width: 12),
                  _homeFabActionIconWidget(icon),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _homeFabActionTextWidget(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13),
      ),
    );
  }

  Material _homeFabActionIconWidget(IconData icon) {
    return Material(
      elevation: 4,
      shape: const CircleBorder(),
      color: Colors.white,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _toggle,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, size: 22),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _expandAnim = CurvedAnimation(
        parent: _controller, curve: Curves.easeOutBack);
    _rotateAnim = Tween<double>(begin: 0, end: 0.125)
        .animate(CurvedAnimation(
            parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}
