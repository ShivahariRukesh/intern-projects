import 'package:fitness_tracker_app/models/workout_model.dart';
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

  void submitWorkoutForm() {
    setState(() {
      addWorkout(
        _workoutTypeController.text,
        int.tryParse(_durationTextController.text)!,
        double.tryParse(_calorieTextController.text)!,
        double.tryParse(_distanceTextController.text),
      );
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _durationTextController.text = "0";
  //   _distanceTextController.text = "0.0";
  //   _calorieTextController.text = "0.0";
  //   _workoutTypeController.text = "";
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color:
      ),
      height: 400,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownMenu(
            onSelected: (String? value) =>
                _workoutTypeController.text = value ?? "",
            controller: _workoutTypeController,
            hintText: "Select Your Workout",
            dropdownMenuEntries: WorkoutEnum.values
                .map(
                  (workout) => DropdownMenuEntry(
                    value: workout.name,
                    label: workout.name.toUpperCase(),
                  ),
                )
                .toList(),
          ),

          //Wrap it up in reusable widget
          TextField(
            controller: _durationTextController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              label: Text("Enter the duration"),
              hintText: "In Min",
            ),
          ),

          TextField(
            controller: _distanceTextController,
            keyboardType:
                const TextInputType.numberWithOptions(
                  decimal: true,
                ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                // Allows digits and one decimal point only
                RegExp(r'^\d*\.?\d*'),
              ),
            ],
            decoration: InputDecoration(
              label: Text("Enter the distance"),
              hintText: "In km",
            ),
          ),

          TextField(
            controller: _calorieTextController,
            keyboardType:
                const TextInputType.numberWithOptions(
                  decimal: true,
                ),
            inputFormatters: [
              // Allows digits and one decimal point only
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*'),
              ),
            ],
            decoration: InputDecoration(
              label: Text("Enter the calorie"),
              hintText: "In kCal",
            ),
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: () => submitWorkoutForm(),

                child: Text("Submit"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Remove controllers from the cache when this widget is disposed
  @override
  void dispose() {
    super.dispose();
    _durationTextController.dispose();
    _distanceTextController.dispose();
    _calorieTextController.dispose();
  }
}
