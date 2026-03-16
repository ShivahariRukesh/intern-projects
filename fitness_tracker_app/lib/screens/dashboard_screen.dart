import 'package:fitness_tracker_app/widgets/dashboard_record_widget.dart';
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
          icon: const Icon(Icons.brightness_6),
          onPressed: toggleTheme,
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const DashboardRecordWidget(),
            const SizedBox(height: 20),

            Container(
              alignment: Alignment.center,
              height: 120,
              child: Text(
                "FITNESS",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withValues(alpha: 0.5),
                  letterSpacing: 20,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Icon(Icons.fitness_center, size: 40),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Start tracking your workouts and build your fitness streak",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
