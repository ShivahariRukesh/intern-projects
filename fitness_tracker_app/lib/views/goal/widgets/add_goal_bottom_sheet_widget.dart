import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fitness_tracker_app/widgets/shared/custom_input_field.dart';
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
        fitnessService.addGoal(
          GoalModel(
            _goalTitleController.text,
            _goalTypeController.text.toLowerCase() ==
                    "calorie"
                ? GoalType.calorie
                : _goalTypeController.text.toLowerCase() ==
                      "distance"
                ? GoalType.distance
                : GoalType.duration,
            num.tryParse(_goalTargetController.text)!,
          ),
        );
        Navigator.pop(context, fitnessService.goals);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                "Add Your New Goal",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10),

              // Subtitle
              Text(
                "Fields marked with (*) are required",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 25),

              // Goal Title Input
              CustomInputField(
                controller: _goalTitleController,
                hint: "Write a title for your goal *",
                icon: Icons.note_add,
                keyboardType: TextInputType.text,
                errorText: _goalTitleError,
              ),

              SizedBox(height: 20),

              // Goal Type Dropdown
              DropdownMenu(
                textStyle: Theme.of(
                  context,
                ).textTheme.displayMedium,
                controller: _goalTypeController,
                hintText: "Select Your Goal Type *",
                width: double.infinity,
                onSelected: (String? value) =>
                    onChangeGoalType(value),
                dropdownMenuEntries: GoalType.values
                    .map(
                      (type) => DropdownMenuEntry(
                        value: type.name,
                        label: type.name.toUpperCase(),
                      ),
                    )
                    .toList(),
              ),
              if (_goalTypeError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    _goalTypeError!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),

              SizedBox(height: 20),

              // Goal Target Input
              CustomInputField(
                controller: _goalTargetController,
                hint: "Your target ($_goalUnit) *",
                icon: Icons.track_changes,
                suffixText: _goalUnit,
                keyboardType:
                    _goalTypeController.text == "DURATION"
                    ? TextInputType.number
                    : const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                inputFormatters: [
                  _goalTypeController.text == "DURATION"
                      ? FilteringTextInputFormatter
                            .digitsOnly
                      : FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                ],
                errorText: _goalTargetError,
              ),
              SizedBox(height: 30),

              // Submit Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  onPressed: _onAddGoalSubmit,
                  child: Text(
                    "Submit",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
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
