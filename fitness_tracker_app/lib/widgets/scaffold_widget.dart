import 'package:flutter/material.dart';

List routes = [
  {
    "name": 'Dashboard',
    "route": '/dashboard',
    "icon": Icon(Icons.home),
  },
  {
    "name": 'Log',
    "route": '/log',
    "icon": Icon(Icons.add_box_outlined),
  },
  {
    "name": 'History',
    "route": '/history',
    "icon": Icon(Icons.history),
  },

  {
    "name": 'Goal',
    "route": '/goal',
    "icon": Icon(Icons.ballot),
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
        title: Text(title),
        actions: actions ?? [],
      ),
      body: body,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: routes.indexWhere(
          (route) =>
              route["route"] ==
              ModalRoute.of(context)!.settings.name,
        ),

        onTap: (value) {
          Navigator.pushReplacementNamed(
            context,
            routes[value]["route"],
          );
        },

        items: routes
            .map(
              (route) => BottomNavigationBarItem(
                icon: route["icon"],
                label: route["name"],
              ),
            )
            .toList(),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
