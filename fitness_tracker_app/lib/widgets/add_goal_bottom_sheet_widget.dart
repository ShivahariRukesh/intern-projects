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

  String? _goalTitleError;
  String? _goalTypeError;
  String? _goalTargetError;
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
    setState(() {
      _goalTitleError = null;
      _goalTypeError = null;
      _goalTargetError = null;

      // Require goal target
      if (_goalTargetController.text.isEmpty) {
        _goalTargetError = "Goal target is required";
      }

      // Require goal title
      if (_goalTitleController.text.isEmpty) {
        _goalTitleError = "Goal title is required";
      }

      // Require goal type
      if (_goalTypeController.text.isEmpty) {
        _goalTypeError = "Please select goal type";
      }

      //Submit the values if all of the fields are entered
      if (_goalTypeError == null &&
          _goalTitleError == null &&
          _goalTargetError == null) {
        addGoal(
          _goalTitleController.text,
          _goalTypeController.text.toLowerCase(),
          num.tryParse(_goalTargetController.text)!,
        );
        Navigator.pop(context, goalList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Add Your New Goal",
            style: TextStyle(fontSize: 25),
          ),
          Text(
            "Fields marked with (*) are meant to be required",
            style: TextStyle(
              color: const Color.fromARGB(
                255,
                135,
                55,
                149,
              ),
            ),
          ),
          TextField(
            controller: _goalTitleController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.note_add),
              hintText: "Write a title for your goal *",
            ),
          ),
          if (_goalTitleError != null)
            Text(
              _goalTitleError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
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
          if (_goalTypeError != null)
            Text(
              _goalTypeError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
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
              prefixIcon: Icon(Icons.track_changes),
              hintText: "Your target ($_goalUnit)",
              suffixText: _goalUnit
            ),
          ),
          if (_goalTargetError != null)
            Text(
              _goalTargetError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
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

  @override
  void dispose() {
    super.dispose();

    _goalTargetController.dispose();
    _goalTitleController.dispose();
    _goalTypeController.dispose();
  }
}
