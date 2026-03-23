import 'package:fitness_tracker_app/utils/route_map.dart';
import 'package:flutter/material.dart';

/// A reusable scaffold widget that provides a consistent layout across
/// the app's screens.
///
/// The bottom navigation bar automatically highlights the current screen
/// and handles navigation between routes.
class ScaffoldWidget extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  /// Parameters:
  /// - [title]: The text displayed in the AppBar which is required to identify.
  /// - [actions]: Optional list of widgets displayed on the AppBar.
  /// - [floatingActionButton]: Optional widget displayed in the scaffold.
  const ScaffoldWidget({
    super.key,
    required this.body,
    required this.title,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ClipOval(
          child: Image.asset(
            'assets/images/fitness_logo.webp',
            color: const Color.fromARGB(255, 223, 210, 210),
            colorBlendMode: BlendMode.modulate,
          ),
        ),
        title: Text(title),
        actions: actions ?? <Widget>[],
        elevation: 3,
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: routes.indexWhere(
          (Map<String, Object> route) =>
              route['route'] ==
              ModalRoute.of(context)!.settings.name,
        ),
        onTap: (int value) {
          Navigator.pushReplacementNamed(
            context,
            routes[value]['route'] as String,
          );
        },
        items: routes
            .map(
              (Map<String, Object> route) =>
                  BottomNavigationBarItem(
                    icon: route['icon'] as Icon,
                    label: route['name'] as String,
                  ),
            )
            .toList(),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
