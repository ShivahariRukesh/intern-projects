import 'package:fitness_tracker_app/models/workout_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:fitness_tracker_app/widgets/shared/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkoutFormWidget extends StatefulWidget {
  const WorkoutFormWidget({super.key});

  @override
  State<WorkoutFormWidget> createState() =>
      _WorkoutFormWidgetState();
}

class _WorkoutFormWidgetState
    extends State<WorkoutFormWidget> {
  final TextEditingController _durationTextController =
      TextEditingController();
  final TextEditingController _distanceTextController =
      TextEditingController();
  final TextEditingController _calorieTextController =
      TextEditingController();
  final TextEditingController _workoutTypeController =
      TextEditingController();

  String? _durationError;
  String? _distanceError;
  String? _calorieError;
  String? _workoutError;

  void submitWorkoutForm() {
    setState(() {
      _durationError = null;
      _calorieError = null;
      _workoutError = null;
      _distanceError = null;

      // Require workout
      if (_workoutTypeController.text.isEmpty) {
        _workoutError = "Please select a workout";
      }

      // Require duration
      if (_durationTextController.text.isEmpty) {
        _durationError = "Duration is required";
      }

      // Require calories
      if (_calorieTextController.text.isEmpty) {
        _calorieError = "Calories are required";
      }

      // Require distance
      if (_distanceTextController.text.isEmpty) {
        _distanceError = "Distance is required";
      }

      if (!(_workoutTypeController.text == "CLIMBING" ||
          _workoutTypeController.text == "JOGGING")) {
        _distanceError = null;
      }

      // If all required fields are filled
      if (_workoutError == null &&
          _durationError == null &&
          _calorieError == null &&
          _distanceError == null) {
        // fitnessService.addWorkout(
        //   _workoutTypeController.text.toLowerCase(),
        //   int.parse(_durationTextController.text),
        //   double.parse(_calorieTextController.text),
        //   _distanceTextController.text.isEmpty
        //       ? 0
        //       : double.parse(_distanceTextController.text),
        // );

        workoutController.addWorkout(
          _workoutTypeController.text.toLowerCase() ==
                  "pullup"
              ? WorkoutType.pullup
              : _workoutTypeController.text.toLowerCase() ==
                    "jogging"
              ? WorkoutType.jogging
              : _workoutTypeController.text.toLowerCase() ==
                    "situp"
              ? WorkoutType.situp
              : _workoutTypeController.text.toLowerCase() ==
                    "plank"
              ? WorkoutType.plank
              : WorkoutType.climbing,

          int.parse(_durationTextController.text),
          double.parse(_calorieTextController.text),
          _distanceTextController.text.isEmpty
              ? 0
              : double.parse(_distanceTextController.text),
        );

        // Clear inputs
        _workoutTypeController.clear();
        _durationTextController.clear();
        _distanceTextController.clear();
        _calorieTextController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workout submitted!'),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _durationTextController.dispose();
    _distanceTextController.dispose();
    _calorieTextController.dispose();
    _workoutTypeController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    debugPrint("yo ${_workoutTypeController.text}");
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
              children: [
                // Subtitle
                Text(
                  "Fields marked with (*) are required",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Workout Type Dropdown
                DropdownMenu(
                  textStyle: Theme.of(
                    context,
                  ).textTheme.displayMedium,
                  leadingIcon: Icon(Icons.fitness_center),
                  width: double.infinity,
                  controller: _workoutTypeController,
                  hintText: "Select Your Workout *",
                  onSelected: (String? value) {
                    setState(() {
                      _workoutTypeController.text =
                          value ?? "";
                    });
                  },
                  dropdownMenuEntries: WorkoutType.values
                      .map(
                        (workout) => DropdownMenuEntry(
                          value: workout.name.toUpperCase(),
                          label: workout.name.toUpperCase(),
                        ),
                      )
                      .toList(),
                ),
                if (_workoutError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      _workoutError!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Duration Input
                CustomInputField(
                  controller: _durationTextController,
                  label: "Enter the duration *",
                  icon: Icons.timer_outlined,
                  suffixText: "minutes",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  errorText: _durationError,
                ),
                const SizedBox(height: 20),

                // Distance Input
                if (_workoutTypeController.text ==
                        "CLIMBING" ||
                    _workoutTypeController.text ==
                        "JOGGING") ...[
                  CustomInputField(
                    controller: _distanceTextController,
                    label: "Enter the distance *",
                    icon: Icons.straighten_outlined,
                    suffixText: "km",
                    keyboardType:
                        const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*'),
                      ),
                    ],
                    errorText: _distanceError,
                  ),
                  const SizedBox(height: 20),
                ],

                // Calorie Input
                CustomInputField(
                  controller: _calorieTextController,
                  label: "Enter the calorie *",
                  icon:
                      Icons.local_fire_department_outlined,
                  suffixText: "kCal",
                  keyboardType:
                      const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d*'),
                    ),
                  ],
                  errorText: _calorieError,
                ),
                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: submitWorkoutForm,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
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
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Container(
  //     height: 400,
  //     width: 400,
  //     padding: const EdgeInsets.all(16),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Fields marked with (*) are meant to be required",
  //               style: TextStyle(
  //                 color: const Color.fromARGB(
  //                   255,
  //                   135,
  //                   55,
  //                   149,
  //                 ),
  //               ),
  //             ),
  //             DropdownMenu(
  //               width: 250,
  //               controller: _workoutTypeController,
  //               hintText: "Select Your Workout *",
  //               onSelected: (String? value) =>
  //                   _workoutTypeController.text =
  //                       value ?? "",
  //               dropdownMenuEntries: WorkoutType.values
  //                   .map(
  //                     (workout) => DropdownMenuEntry(
  //                       value: workout.name.toUpperCase(),
  //                       label: workout.name.toUpperCase(),
  //                     ),
  //                   )
  //                   .toList(),
  //             ),
  //             if (_workoutError != null)
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 4),
  //                 child: Text(
  //                   _workoutError!,
  //                   style: const TextStyle(
  //                     color: Colors.red,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),

  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             TextField(
  //               controller: _durationTextController,
  //               keyboardType: TextInputType.number,
  //               inputFormatters: [
  //                 FilteringTextInputFormatter.digitsOnly,
  //               ],
  //               decoration: const InputDecoration(
  //                 prefixIcon: Icon(Icons.timer_outlined),
  //                 labelText: "Enter the duration *",
  //                 suffixText: "minutes",
  //               ),
  //             ),
  //             if (_durationError != null)
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 4),
  //                 child: Text(
  //                   _durationError!,
  //                   style: const TextStyle(
  //                     color: Colors.red,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),

  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             TextField(
  //               controller: _distanceTextController,
  //               keyboardType:
  //                   const TextInputType.numberWithOptions(
  //                     decimal: true,
  //                   ),
  //               inputFormatters: [
  //                 FilteringTextInputFormatter.allow(
  //                   RegExp(r'^\d*\.?\d*'),
  //                 ),
  //               ],
  //               decoration: const InputDecoration(
  //                 prefixIcon: Icon(
  //                   Icons.straighten_outlined,
  //                 ),
  //                 labelText: "Enter the distance",
  //                 suffixText: "km",
  //               ),
  //             ),
  //             if (_distanceError != null)
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 4),
  //                 child: Text(
  //                   _distanceError!,
  //                   style: const TextStyle(
  //                     color: Colors.red,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),

  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             TextField(
  //               controller: _calorieTextController,
  //               keyboardType:
  //                   const TextInputType.numberWithOptions(
  //                     decimal: true,
  //                   ),
  //               inputFormatters: [
  //                 FilteringTextInputFormatter.allow(
  //                   RegExp(r'^\d*\.?\d*'),
  //                 ),
  //               ],
  //               decoration: const InputDecoration(
  //                 prefixIcon: Icon(
  //                   Icons.local_fire_department_outlined,
  //                 ),
  //                 labelText: "Enter the calorie *",
  //                 suffixText: "kCal",
  //               ),
  //             ),
  //             if (_calorieError != null)
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 4),
  //                 child: Text(
  //                   _calorieError!,
  //                   style: const TextStyle(
  //                     color: Colors.red,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),

  //         Center(
  //           child: ElevatedButton(
  //             onPressed: submitWorkoutForm,
  //             child: const Text("Submit"),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
