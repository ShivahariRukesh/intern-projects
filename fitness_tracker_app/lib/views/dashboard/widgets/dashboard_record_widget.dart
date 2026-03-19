import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fitness_tracker_app/views/dashboard/widgets/dashboard_stats_card_widget.dart';
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
            value: fitnessService.workouts.length
                .toString(),

            icon: Icons.fitness_center,
            label: 'This week',
            unit: "session",
          ),

          DashboardStatsCardWidget(
            value: goalController
                .getTotalMetric(GoalType.duration)
                .toString(),
            icon: Icons.timer_outlined,
            label: 'Total Time Spent',
            unit: "mins",
          ),

          DashboardStatsCardWidget(
            value: goalController
                .getTotalMetric(GoalType.distance)
                .toString(),
            icon: Icons.straighten_outlined,
            label: 'Total distance covered',
            unit: "km",
          ),

          DashboardStatsCardWidget(
            value: goalController
                .getTotalMetric(GoalType.calorie)
                .toString(),
            icon: Icons.local_fire_department_outlined,
            label: 'Total calories burnt',
            unit: 'Kcal',
          ),
        ],
      ),
    );
  }
}
