import 'package:fitness_tracker_app/models/workout_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fitness_tracker_app/widgets/shared/base_dropdown_required_label_widget.dart';
import 'package:fitness_tracker_app/widgets/shared/base_modal_button_widget.dart';
import 'package:fitness_tracker_app/widgets/shared/base_input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A form widget for filling out a workout session.
///
/// It has four/three different fields depending on the type of workout selected,
/// - Workout Type which is a dropdown
/// - Distance(Optional) which is a text field that measures the total distance covered.
/// - Duration which is a text field that measures the time taken to complete.
/// -Calorie which is a text field that measures the amount of calorie burnt.
class WorkoutFormWidget extends StatefulWidget {
  const WorkoutFormWidget({super.key});

  @override
  State<WorkoutFormWidget> createState() =>
      _WorkoutFormWidgetState();
}

class _WorkoutFormWidgetState
    extends State<WorkoutFormWidget> {
  final TextEditingController durationTextController =
      TextEditingController();
  final TextEditingController distanceTextController =
      TextEditingController();
  final TextEditingController calorieTextController =
      TextEditingController();
  final TextEditingController workoutTypeController =
      TextEditingController();

  String? durationError;
  String? distanceError;
  String? calorieError;
  String? workoutError;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Fields marked with (*) are required',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _workoutTypeDropDown(context),
                BaseDropdownRequiredLabelWidget(
                  workoutError,
                ),
                const SizedBox(height: 20),
                BaseInputFieldWidget(
                  controller: durationTextController,
                  label: 'Enter the duration *',
                  icon: Icons.timer_outlined,
                  suffixText: 'minutes',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  errorText: durationError,
                ),
                const SizedBox(height: 20),
                ..._distanceInputWidget,
                BaseInputFieldWidget(
                  controller: calorieTextController,
                  label: 'Enter the calorie *',
                  icon:
                      Icons.local_fire_department_outlined,
                  suffixText: 'kCal',
                  keyboardType:
                      const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d*'),
                    ),
                  ],
                  errorText: calorieError,
                ),
                const SizedBox(height: 30),
                BaseModalButtonWidget(
                  () => workoutController.submitWorkoutForm(
                    context,
                    setState,
                    setDurationError: (String? text) =>
                        durationError = text,
                    setCalorieError: (String? text) =>
                        calorieError = text,
                    setDistanceError: (String? text) =>
                        distanceError = text,
                    setWorkoutError: (String? text) =>
                        workoutError = text,
                    getDurationError: () => durationError,
                    getCalorieError: () => calorieError,
                    getWorkoutError: () => workoutError,
                    getDistanceError: () => distanceError,
                    workoutTypeController:
                        workoutTypeController,
                    durationTextController:
                        durationTextController,
                    calorieTextController:
                        calorieTextController,
                    distanceTextController:
                        distanceTextController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenu<String> _workoutTypeDropDown(
    BuildContext context,
  ) {
    return DropdownMenu<String>(
      textStyle: Theme.of(context).textTheme.displayMedium,
      leadingIcon: const Icon(Icons.fitness_center),
      width: double.infinity,
      controller: workoutTypeController,
      hintText: 'Select Your Workout *',
      onSelected: (String? value) {
        setState(() {
          workoutTypeController.text = value ?? '';
        });
      },
      dropdownMenuEntries: WorkoutType.values
          .map(
            (WorkoutType workout) =>
                DropdownMenuEntry<String>(
                  value: workout.name.toUpperCase(),
                  label: workout.name.toUpperCase(),
                ),
          )
          .toList(),
    );
  }

  List<Widget> get _distanceInputWidget {
    if (workoutTypeController.text == 'CLIMBING' ||
        workoutTypeController.text == 'JOGGING') {
      return <Widget>[
        BaseInputFieldWidget(
          controller: distanceTextController,
          label: 'Enter the distance *',
          icon: Icons.straighten_outlined,
          suffixText: 'km',
          keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d*'),
            ),
          ],
          errorText: distanceError,
        ),
        const SizedBox(height: 20),
      ];
    } else {
      return <Widget>[const SizedBox()];
    }
  }

  @override
  void dispose() {
    durationTextController.dispose();
    distanceTextController.dispose();
    calorieTextController.dispose();
    workoutTypeController.dispose();
    super.dispose();
  }
}
