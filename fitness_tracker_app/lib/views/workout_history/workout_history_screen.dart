import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fitness_tracker_app/views/workout_history/widgets/history_list_widget.dart';
import 'package:fitness_tracker_app/widgets/shared/base_scaffold_widget.dart';
import 'package:flutter/material.dart';

/// One of the screens of an app that displays the workout history.
class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Workout History',
      body: fitnessService.workouts.isEmpty
          ? const Center(child: Text('No history yet'))
          : const HistoryListWidget(),
    );
  }
}
