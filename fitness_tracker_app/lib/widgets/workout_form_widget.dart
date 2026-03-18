import 'package:fitness_tracker_app/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness_tracker_app/services/fitness_manager.dart';

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

      // If all required fields are filled
      if (_workoutError == null &&
          _durationError == null &&
          _calorieError == null) {
        fitnessService.addWorkout(
          _workoutTypeController.text.toLowerCase(),
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
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              DropdownMenu(
                width: 250,
                controller: _workoutTypeController,
                hintText: "Select Your Workout *",
                onSelected: (String? value) =>
                    _workoutTypeController.text =
                        value ?? "",
                dropdownMenuEntries: WorkoutEnum.values
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
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _workoutError!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _durationTextController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.timer_outlined),
                  labelText: "Enter the duration *",
                  suffixText: "minutes",
                ),
              ),
              if (_durationError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _durationError!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _distanceTextController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d*'),
                  ),
                ],
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.straighten_outlined,
                  ),
                  labelText: "Enter the distance",
                  suffixText: "km",
                ),
              ),
              if (_distanceError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _distanceError!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _calorieTextController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d*'),
                  ),
                ],
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.local_fire_department_outlined,
                  ),
                  labelText: "Enter the calorie *",
                  suffixText: "kCal",
                ),
              ),
              if (_calorieError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _calorieError!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),

          Center(
            child: ElevatedButton(
              onPressed: submitWorkoutForm,
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
