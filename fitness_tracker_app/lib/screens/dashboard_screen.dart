import 'package:fitness_tracker_app/widgets/scaffold_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const DashboardScreen({
    super.key,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Dashboard",
      actions: [
        IconButton(
          icon: Icon(Icons.brightness_6),
          onPressed: toggleTheme,
        ),
      ],

      body: Center(
        child: Text("Welcome to Fitness Tracker!"),
      ),
    );
  }
}
