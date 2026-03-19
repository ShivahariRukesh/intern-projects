import 'package:fitness_tracker_app/widgets/shared/scaffold_widget.dart';
import 'package:fitness_tracker_app/views/workout_log/widgets/workout_form_widget.dart';
import 'package:flutter/material.dart';

class WorkoutLogScreen extends StatelessWidget {
  const WorkoutLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Workout Log",
      body: Center(child: WorkoutFormWidget()),
    );
  }
}
