import 'package:fitness_tracker_app/screens/workout_log_screen.dart';
import 'package:fitness_tracker_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fitness_tracker_app/screens/dashboard_screen.dart';
import 'package:fitness_tracker_app/screens/goal_screen.dart';
import 'package:fitness_tracker_app/screens/workout_history_screen.dart';

class FitnessTrackerApp extends StatefulWidget {
  const FitnessTrackerApp({super.key});
  @override
  State<FitnessTrackerApp> createState() =>
      _FitnessTrackerAppState();
}

class _FitnessTrackerAppState
    extends State<FitnessTrackerApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) =>
            DashboardScreen(toggleTheme: _toggleTheme),
        '/history': (context) => WorkoutHistoryScreen(),
        '/goal': (context) => GoalScreen(),
        '/log': (context) => WorkoutLogScreen(),
      },
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
    );
  }
}
