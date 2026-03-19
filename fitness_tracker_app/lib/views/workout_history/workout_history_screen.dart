import 'package:fitness_tracker_app/views/workout_history/widgets/history_list_widget.dart';
import 'package:fitness_tracker_app/widgets/shared/scaffold_widget.dart';
import 'package:flutter/material.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Workout History",
      body: HistoryListWidget(),
    );
  }
}
