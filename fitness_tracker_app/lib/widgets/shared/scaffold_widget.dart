import 'package:flutter/material.dart';

List<Map<String, Object>> routes = <Map<String, Object>>[
  <String, Object>{
    'name': 'Dashboard',
    'route': '/dashboard',
    'icon': const Icon(Icons.grid_view_rounded),
  },
  <String, Object>{
    'name': 'Log',
    'route': '/log',
    'icon': const Icon(Icons.add_box_outlined),
  },
  <String, Object>{
    'name': 'History',
    'route': '/history',
    'icon': const Icon(Icons.history),
  },

  <String, Object>{
    'name': 'Goal',
    'route': '/goal',
    'icon': const Icon(Icons.ballot),
  },
];

class ScaffoldWidget extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

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
