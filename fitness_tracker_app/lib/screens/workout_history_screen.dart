import 'package:fitness_tracker_app/widgets/history_list_widget.dart';
import 'package:fitness_tracker_app/widgets/scaffold_widget.dart';
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
