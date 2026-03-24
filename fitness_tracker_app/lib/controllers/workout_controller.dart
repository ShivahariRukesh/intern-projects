import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/fitness_manager.dart';

/// A controller class responsible for managing workout related operations.
class WorkoutController {
  /// Service responsible for managing workouts and goals data.
  final FitnessManager fitnessManager;

  /// Service responsible for managing workouts and goals data.
  WorkoutController(this.fitnessManager);

  /// Adds a workout based on the provided [type].
  ///
  /// Parameters:
  /// - [type]: The type of workout to add
  /// - [duration]: Duration of the workout (e.g., in seconds)
  /// - [calories]: Calories burned during the workout
  /// - [distance]: Optional distance (required for jogging and climbing)
  void addWorkout(
    WorkoutType type,
    int duration,
    double calories, [
    double? distance,
  ]) {
    switch (type) {
      case WorkoutType.jogging:
        fitnessManager.addWorkout(
          Jogging(
            duration: duration,
            caloriesBurnt: calories,
            distance: distance ?? 0,
          ),
        );
        break;

      case WorkoutType.pullup:
        fitnessManager.addWorkout(
          Pullup(
            duration: duration,
            caloriesBurnt: calories,
          ),
        );

      case WorkoutType.situp:
        fitnessManager.addWorkout(
          Situp(
            duration: duration,
            caloriesBurnt: calories,
          ),
        );

      case WorkoutType.plank:
        fitnessManager.addWorkout(
          Plank(
            duration: duration,
            caloriesBurnt: calories,
          ),
        );

      case WorkoutType.climbing:
        fitnessManager.addWorkout(
          Climbing(
            duration: duration,
            caloriesBurnt: calories,
            distance: distance ?? 0,
          ),
        );
        break;
    }
  }

  /// Handles submission of the workout form.
  ///
  /// This method performs:
  /// - Input validation for workout type, duration, calories, and distance
  /// - Updates UI error states using [changeState]
  /// - Calls [addWorkout] if all inputs are valid
  /// - Clears input fields after successful submission
  /// - Displays a confirmation message using [SnackBar]
  ///
  /// Parameters:
  /// - [context]: Build context used for UI feedback like for Scaffold message
  /// - [changeState]: Callback to trigger UI updates like setState.
  /// - [getDurationError], [getCalorieError], [getWorkoutError], [getDistanceError]:
  ///   Functions to retrieve current validation errors
  /// - [setDurationError], [setCalorieError], [setWorkoutError], [setDistanceError], :
  ///   Functions to update validation errors
  /// - [workoutTypeController], [durationTextController], [calorieTextController], [distanceTextController]:
  ///   Controllers for form input fields
  ///
  /// Validation rules:
  /// - Workout type must be selected
  /// - Duration must not be empty
  /// - Calories must not be empty
  /// - Distance is required only for jogging and climbing workouts
  ///
  /// On success:
  /// - Adds the workout
  /// - Clears all input fields
  /// - Shows a "Workout submitted!" Scaffold message
  void submitWorkoutForm(
    BuildContext context,
    void Function(void Function()) changeState, {
    required String? Function() getDurationError,
    required String? Function() getCalorieError,
    required String? Function() getWorkoutError,
    required String? Function() getDistanceError,
    required void Function(String?) setDurationError,
    required void Function(String?) setCalorieError,
    required void Function(String?) setWorkoutError,
    required void Function(String?) setDistanceError,
    required TextEditingController workoutTypeController,
    required TextEditingController durationTextController,
    required TextEditingController calorieTextController,
    required TextEditingController distanceTextController,
  }) {
    changeState(() {
      setDurationError(null);
      setCalorieError(null);
      setWorkoutError(null);
      setDistanceError(null);
      if (workoutTypeController.text.isEmpty) {
        setWorkoutError('Please select a workout');
      }

      if (durationTextController.text.isEmpty) {
        setDurationError('Duration is required');
      }

      if (calorieTextController.text.isEmpty) {
        setCalorieError('Calories are required');
      }

      if (distanceTextController.text.isEmpty) {
        setDistanceError('Distance is required');
      }

      if (!(workoutTypeController.text == 'CLIMBING' ||
          workoutTypeController.text == 'JOGGING')) {
        setDistanceError(null);
      }

      if (getWorkoutError() == null &&
          getDurationError() == null &&
          getCalorieError() == null &&
          getDistanceError() == null) {
        addWorkout(
          workoutTypeController.text.toLowerCase() ==
                  'pullup'
              ? WorkoutType.pullup
              : workoutTypeController.text.toLowerCase() ==
                    'jogging'
              ? WorkoutType.jogging
              : workoutTypeController.text.toLowerCase() ==
                    'situp'
              ? WorkoutType.situp
              : workoutTypeController.text.toLowerCase() ==
                    'plank'
              ? WorkoutType.plank
              : WorkoutType.climbing,

          int.parse(durationTextController.text),
          double.parse(calorieTextController.text),
          distanceTextController.text.isEmpty
              ? 0
              : double.parse(distanceTextController.text),
        );
        workoutTypeController.clear();
        durationTextController.clear();
        distanceTextController.clear();
        calorieTextController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workout submitted!'),
          ),
        );
      }
    });
  }
}
