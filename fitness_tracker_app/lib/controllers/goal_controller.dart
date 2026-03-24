import 'package:fitness_tracker_app/models/workout_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:flutter/widgets.dart';
import '../models/goal_model.dart';
import '../services/fitness_manager.dart';

/// A controller class responsible for handling goal related logic.
class GoalController {
  /// Service responsible for managing workouts and goals data.
  final FitnessManager fitnessManager;

  /// Creates a [GoalController] with the given [fitnessManager].
  GoalController(this.fitnessManager);

  /// Calculates the progress of a given [goal] as a fraction (0.0 to 1.0).
  ///
  /// The progress is computed by summing relevant workout metrics:
  /// - [GoalType.duration]: total workout duration
  /// - [GoalType.calorie]: total calories burned
  /// - [GoalType.distance]: total distance covered
  ///
  /// Returns:
  /// - A value between `0.0` (no progress) and `1.0` (goal fully achieved).
  /// - Returns `0.0` if the goal target is less than or equal to zero.
  double getProgressFraction(GoalModel goal) {
    double total = fitnessManager.workouts.fold(0.0, (
      double sum,
      WorkoutModel workout,
    ) {
      switch (goal.type) {
        case GoalType.duration:
          return sum + workout.duration;

        case GoalType.calorie:
          return sum + workout.caloriesBurnt;

        case GoalType.distance:
          return sum + workout.getDistance();
      }
    });

    if (goal.target <= 0) return 0.0;
    return (total / goal.target).clamp(0.0, 1.0);
  }

  /// Calculates the total accumulated value for a given [GoalType].
  ///
  /// Aggregates all workouts and returns:
  /// - Total duration for [GoalType.duration]
  /// - Total calories burned for [GoalType.calorie]
  /// - Total distance covered for [GoalType.distance]
  double getTotalMetric(GoalType type) {
    return fitnessManager.workouts.fold(0.0, (
      double sum,
      WorkoutModel workout,
    ) {
      switch (type) {
        case GoalType.duration:
          return sum + workout.duration;

        case GoalType.calorie:
          return sum + workout.caloriesBurnt;

        case GoalType.distance:
          return sum + workout.getDistance();
      }
    });
  }

  /// Returns the total number of goals that have been fully completed.
  ///
  /// A goal is considered completed when its progress reaches `1.0`.
  int getTotalGoalsCompleted() {
    return fitnessManager.goals.fold(0, (
      int acc,
      GoalModel goal,
    ) {
      if (getProgressFraction(goal) == 1) {
        return acc + 1;
      } else {
        return acc;
      }
    });
  }

  /// Handles submission of the adding goal to the goal list.
  ///
  /// This method performs:
  /// - Input validation for goal title, goal type, and goal target
  /// - Updates UI error states using [changeState]
  /// - Creates and adds a new [GoalModel] if inputs are valid
  /// - Closes the current screen and returns updated goals
  ///
  /// Parameters:
  /// - [context]: Build context used for navigation
  /// - [changeState]: Callback to trigger UI state updates like setState
  /// - [getGoalTitleError], [getGoalTypeError], [getGoalTargetError]:
  ///   Functions to retrieve current validation errors
  /// - [setGoalTitleError], [setGoalTypeError], [setGoalTargetError]:
  ///   Functions to update validation errors
  /// - [goalTitleController], [goalTypeController], [goalTargetController]:
  ///   Controllers for form input fields
  ///
  /// Validation rules:
  /// - Title must not be empty
  /// - Type must be selected
  /// - Target must not be empty and must be a valid number
  ///
  /// On success:
  /// - Adds the goal via [fitnessService]
  /// - Pops the current route and returns updated goals
  void onAddGoalSubmit(
    BuildContext context,
    void Function(void Function()) changeState, {
    required String? Function() getGoalTitleError,
    required String? Function() getGoalTypeError,
    required String? Function() getGoalTargetError,

    required void Function(String?) setGoalTitleError,
    required void Function(String?) setGoalTypeError,
    required void Function(String?) setGoalTargetError,

    required TextEditingController goalTitleController,
    required TextEditingController goalTypeController,
    required TextEditingController goalTargetController,
  }) {
    changeState(() {
      setGoalTitleError(null);
      setGoalTypeError(null);
      setGoalTargetError(null);

      // Require goal target
      if (goalTargetController.text.isEmpty) {
        setGoalTargetError('Goal target is required');
      }

      // Require goal title
      if (goalTitleController.text.isEmpty) {
        setGoalTitleError('Goal title is required');
      }

      // Require goal type
      if (goalTypeController.text.isEmpty) {
        setGoalTypeError('Please select goal type');
      }

      //Submit the values if all of the fields are entered
      if (getGoalTypeError() == null &&
          getGoalTitleError() == null &&
          getGoalTargetError() == null) {
        fitnessService.addGoal(
          GoalModel(
            goalTitleController.text,
            goalTypeController.text.toLowerCase() ==
                    'calorie'
                ? GoalType.calorie
                : goalTypeController.text.toLowerCase() ==
                      'distance'
                ? GoalType.distance
                : GoalType.duration,
            num.tryParse(goalTargetController.text)!,
          ),
        );
        Navigator.pop(context, fitnessService.goals);
      }
    });
  }
}
