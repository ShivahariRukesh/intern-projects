import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/models/workout_model.dart';
import 'package:fitness_tracker_app/widgets/dashboard_stats_card_widget.dart';
import 'package:flutter/material.dart';

class DashboardRecordWidget extends StatelessWidget {
  const DashboardRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: 1.3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          DashboardStatsCardWidget(
            value: workoutList.length.toString(),
            icon: Icons.fitness_center,
            label: 'This week',
            unit: "session",
          ),

          DashboardStatsCardWidget(
            value: getTotalMeasurement("duration"),
            icon: Icons.timer_outlined,
            label: 'Total Time Spent',
            unit: "mins",
          ),

          DashboardStatsCardWidget(
            value: getTotalMeasurement("distance"),
            icon: Icons.straighten_outlined,
            label: 'Total distance covered',
            unit: "km",
          ),

          DashboardStatsCardWidget(
            value: getTotalMeasurement("calorie"),
            icon: Icons.local_fire_department_outlined,
            label: 'Total calories burnt',
            unit: 'Kcal',
          ),
        ],
      ),
    );
  }
}
