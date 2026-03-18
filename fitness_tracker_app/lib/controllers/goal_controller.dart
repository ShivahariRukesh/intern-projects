import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/services/fitness_manager.dart';

class GoalController {
  double getProgressFraction(GoalModel goal) {
    double totalValue = fitnessService.workouts.fold(0.0, (
      sum,
      workout,
    ) {
      switch (goal.type) {
        case GoalType.duration:
          return sum + workout.duration.toDouble();
        case GoalType.distance:
          return sum + (workout.distanceCovered ?? 0.0);
        case GoalType.calorie:
          return sum + workout.caloriesBurnt;
      }
    });

    if (goal.target <= 0) return 0.0;
    return (totalValue / goal.target).clamp(0.0, 1.0);
  }
}

GoalController goalController = GoalController();
