import 'package:flutter/material.dart';

class HomeFloatingActionWidget extends StatefulWidget {
  const HomeFloatingActionWidget({super.key});

  @override
  State<HomeFloatingActionWidget> createState() =>
      _HomeFloatingActionWidgetState();
}

class _HomeFloatingActionWidgetState extends State<HomeFloatingActionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnim;
  late Animation<double> _rotateAnim;
  bool _isExpanded = false;

  static const _actions = [
    _FabAction(icon: Icons.photo_camera, label: 'Photo'),
    _FabAction(icon: Icons.videocam, label: 'Video'),
    _FabAction(icon: Icons.auto_awesome, label: 'Story'),
    _FabAction(icon: Icons.article_outlined, label: 'Post'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _expandAnim =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _rotateAnim = Tween<double>(begin: 0, end: 0.125)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                action.label,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Material(
                              elevation: 4,
                              shape: const CircleBorder(),
                              color: Colors.white,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: _toggle,
                                child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(action.icon, size: 22),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            })
            .toList()
            .reversed,
        RotationTransition(
          turns: _rotateAnim,
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: const Color(0xFFE91E8C),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }
}

class _FabAction {
  final IconData icon;
  final String label;
  const _FabAction({required this.icon, required this.label});
}
