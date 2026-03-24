import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fitness_tracker_app/widgets/shared/base_dropdown_required_label_widget.dart';
import 'package:fitness_tracker_app/widgets/shared/base_modal_button_widget.dart';
import 'package:fitness_tracker_app/widgets/shared/base_input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A bottom sheet widget that enables to create a goal
///
/// It has three input fields to write information about the goal
/// - Title is required to identify the goals
/// - Goal Type is required to select a measure for your goal
/// - Target is required to fulfill the goal objective
class AddGoalBottomSheetWidget extends StatefulWidget {
  const AddGoalBottomSheetWidget({super.key});

  @override
  State<AddGoalBottomSheetWidget> createState() =>
      _AddGoalBottomSheetWidgetState();
}

class _AddGoalBottomSheetWidgetState
    extends State<AddGoalBottomSheetWidget> {
  final TextEditingController goalTitleController =
      TextEditingController();
  final TextEditingController goalTypeController =
      TextEditingController();
  final TextEditingController goalTargetController =
      TextEditingController();

  String? goalTitleError;
  String? goalTypeError;
  String? goalTargetError;
  String _goalUnit = 'unit';

  void onChangeGoalType(String? value) {
    goalTargetController.text = '';
    setState(() {
      _goalUnit = switch (value) {
        'calorie' => 'Kcal',
        'distance' => 'km',
        'duration' => 'min',
        _ => 'unit',
      };
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
            children: <Widget>[
              const Text(
                'Add Your New Goal',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Fields marked with (*) are required',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              BaseInputFieldWidget(
                controller: goalTitleController,
                hint: 'Write a title for your goal *',
                icon: Icons.note_add,
                keyboardType: TextInputType.text,
                errorText: goalTitleError,
              ),
              const SizedBox(height: 20),
              _goalTypeDropDown(context),
              BaseDropdownRequiredLabelWidget(
                goalTypeError,
              ),
              const SizedBox(height: 20),
              BaseInputFieldWidget(
                controller: goalTargetController,
                hint: 'Your target ($_goalUnit) *',
                icon: Icons.track_changes,
                suffixText: _goalUnit,
                keyboardType:
                    goalTypeController.text == 'DURATION'
                    ? TextInputType.number
                    : const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                inputFormatters: <TextInputFormatter>[
                  goalTypeController.text == 'DURATION'
                      ? FilteringTextInputFormatter
                            .digitsOnly
                      : FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                ],
                errorText: goalTargetError,
              ),
              const SizedBox(height: 30),
              BaseModalButtonWidget(
                () => goalController.onAddGoalSubmit(
                  context,
                  setState,
                  getGoalTargetError: () => goalTargetError,
                  getGoalTitleError: () => goalTitleError,
                  getGoalTypeError: () => goalTypeError,
                  setGoalTargetError: (String? text) =>
                      goalTargetError = text,
                  setGoalTitleError: (String? text) =>
                      goalTitleError = text,
                  setGoalTypeError: (String? text) =>
                      goalTypeError = text,
                  goalTargetController:
                      goalTargetController,
                  goalTitleController: goalTitleController,
                  goalTypeController: goalTypeController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenu<String> _goalTypeDropDown(
    BuildContext context,
  ) {
    return DropdownMenu<String>(
      textStyle: Theme.of(context).textTheme.displayMedium,
      controller: goalTypeController,
      hintText: 'Select Your Goal Type *',
      width: double.infinity,
      onSelected: (String? value) =>
          onChangeGoalType(value),
      dropdownMenuEntries: GoalType.values
          .map(
            (GoalType type) => DropdownMenuEntry<String>(
              value: type.name,
              label: type.name.toUpperCase(),
            ),
          )
          .toList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    goalTargetController.dispose();
    goalTitleController.dispose();
    goalTypeController.dispose();
  }
}
