import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardGoalRecordWidget extends StatelessWidget {
  DashboardGoalRecordWidget({super.key});

  final int? totalGoalsCompleted = fitnessService.goals.fold(0, (
    int? acc,
    GoalModel goal,
  ) {
    if (goalController.getProgressFraction(goal) == 1) {
      return (acc as int) + 1;
    } else {
      return acc;
    }
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 180,
        child: fitnessService.goals.isEmpty
            ? const Center(
                child: Text(
                  'No Goals Enlisted Yet',
                  style: TextStyle(fontSize: 25),
                ),
              )
            : Row(
                children: <Widget>[
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 10,
                        sectionsSpace: 5,

                        sections: <PieChartSectionData>[
                          PieChartSectionData(
                            title: 'Completed',
                            value: totalGoalsCompleted
                                ?.toDouble(),
                            radius: 80,
                            color: theme.primaryColor,
                          ),

                          PieChartSectionData(
                            title: 'Incomplete',
                            value:
                                (fitnessService
                                            .goals
                                            .length -
                                        totalGoalsCompleted!)
                                    .toDouble(),
                            radius: 80,
                            color:
                                theme.colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '$totalGoalsCompleted/${fitnessService.goals.length} Goals are Completed',
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
      ),
    );
  }
}
