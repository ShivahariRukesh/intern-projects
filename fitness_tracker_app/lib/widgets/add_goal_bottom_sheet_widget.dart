import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddGoalBottomSheetWidget extends StatefulWidget {
  const AddGoalBottomSheetWidget({super.key});

  @override
  State<AddGoalBottomSheetWidget> createState() =>
      _AddGoalBottomSheetWidgetState();
}

class _AddGoalBottomSheetWidgetState
    extends State<AddGoalBottomSheetWidget> {
  final TextEditingController _goalTitleController =
      TextEditingController();
  final TextEditingController _goalTypeController =
      TextEditingController();
  final TextEditingController _goalTargetController =
      TextEditingController();

  String _goalUnit = "unit";

  void onChangeGoalType(String? value) {
    _goalTargetController.text = "";

    setState(() {
      _goalUnit = switch (value) {
        "calorie" => "Kcal",
        "distance" => "km",
        "duration" => "min",
        _ => "unit",
      };
    });
  }

  void _onAddGoalSubmit() {
    addGoal(
      _goalTitleController.text,
      _goalTypeController.text.toLowerCase(),
      num.tryParse(_goalTargetController.text)!,
    );

    Navigator.pop(context, goalList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Add Your New Goal, Champ!"),
          TextField(
            controller: _goalTitleController,
            decoration: InputDecoration(
              hintText: "Write a title for your goal",
            ),
          ),

          DropdownMenu(
            controller: _goalTypeController,
            hintText: "Select Your Goal Type",
            width: 400,
            onSelected: (String? value) =>
                onChangeGoalType(value),

            dropdownMenuEntries: GoalTypeEnum.values
                .map(
                  (workout) => DropdownMenuEntry(
                    value: workout.name,
                    label: workout.name.toUpperCase(),
                  ),
                )
                .toList(),
          ),
          TextField(
            keyboardType:
                _goalTypeController.text == "DURATION"
                ? TextInputType.number
                : TextInputType.numberWithOptions(
                    decimal: true,
                  ),

            inputFormatters: [
              _goalTypeController.text == "DURATION"
                  ? FilteringTextInputFormatter.digitsOnly
                  : FilteringTextInputFormatter.allow(
                      // Allows digits and one decimal point only
                      RegExp(r'^\d*\.?\d*'),
                    ),
            ],
            controller: _goalTargetController,
            decoration: InputDecoration(
              hintText: "Your target ($_goalUnit)",
            ),
          ),

          OutlinedButton(
            onPressed: _onAddGoalSubmit,
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
