import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fitness_tracker_app/views/goal/widgets/add_goal_bottom_sheet_widget.dart';
import 'package:fitness_tracker_app/views/goal/widgets/goal_list_widget.dart';
import 'package:fitness_tracker_app/widgets/shared/scaffold_widget.dart';
import 'package:flutter/material.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  List<GoalModel> _goalList = fitnessService.goals;

  void onGoalBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) =>
          const AddGoalBottomSheetWidget(),
    );
    setState(() {
      _goalList = fitnessService.goals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'Goals',

      body: fitnessService.goals.isNotEmpty
          ? GoalListWidget(goalList: _goalList)
          : const Center(
              child: Text('Goals not yet created'),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => onGoalBottomSheet(context),

        child: const Icon(Icons.add),
      ),
    );
  }
}
