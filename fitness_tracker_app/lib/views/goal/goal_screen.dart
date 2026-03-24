import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fitness_tracker_app/views/goal/widgets/add_goal_bottom_sheet_widget.dart';
import 'package:fitness_tracker_app/views/goal/widgets/goal_list_widget.dart';
import 'package:fitness_tracker_app/widgets/shared/base_scaffold_widget.dart';
import 'package:flutter/material.dart';

/// One of the screens of an app that wraps everything related  to the goals widget,
///
/// - It has feature to add goal.
/// - It displays the lists of goals created.
class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  List<GoalModel> _goalList = fitnessService.goals;

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
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
}
