import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A dashboard widget that displays the recorded information of goals
class DashboardGoalRecordWidget extends StatelessWidget {
  const DashboardGoalRecordWidget({super.key});

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
                            value: goalController
                                .getTotalGoalsCompleted()
                                .toDouble(),
                            radius: 80,
                            color: theme.primaryColor,
                          ),
                          PieChartSectionData(
                            title: 'Incomplete',
                            value:
                                (fitnessService
                                            .goals
                                            .length -
                                        goalController
                                            .getTotalGoalsCompleted())
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
                    '${goalController.getTotalGoalsCompleted()}/${fitnessService.goals.length} Goals are Completed',
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
      ),
    );
  }
}
