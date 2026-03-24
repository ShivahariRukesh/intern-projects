import 'package:fitness_tracker_app/views/dashboard/widgets/dashboard_goal_record_widget.dart';
import 'package:fitness_tracker_app/views/dashboard/widgets/dashboard_record_widget.dart';
import 'package:fitness_tracker_app/widgets/shared/base_scaffold_widget.dart';
import 'package:flutter/material.dart';

/// One of the screens of an app that shows overview of things or records happening in current instance
class DashboardScreen extends StatelessWidget {
  /// [toggleTheme] is a callback function that is used to toggle theme of an app.
  /// Switch between dark theme and light theme
  final VoidCallback toggleTheme;

  const DashboardScreen({
    super.key,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Dashboard',
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: toggleTheme,
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const DashboardRecordWidget(),
            const DashboardGoalRecordWidget(),
            Container(
              alignment: Alignment.center,
              height: 120,
              child: Text(
                'FITNESS',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withValues(alpha: 0.5),
                  letterSpacing: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
