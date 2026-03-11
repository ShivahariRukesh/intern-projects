import 'package:fitness_tracker_app/screens/dashboard_screen.dart';
import 'package:fitness_tracker_app/screens/goal_screen.dart';
import 'package:fitness_tracker_app/screens/workout_history_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (BuildContext context) =>
            DashboardScreen(),
        '/history': (BuildContext context) =>
            WorkoutHistoryScreen(),

        '/goal': (BuildContext context) => GoalScreen(),
      },
    ),
  );
}
