import '../models/goal_model.dart';
import '../services/fitness_manager.dart';

class GoalController {
  final FitnessManager fitnessManager;

  GoalController(this.fitnessManager);

  double getProgressFraction(GoalModel goal) {
    double total = fitnessManager.workouts.fold(0.0, (
      sum,
      workout,
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

  double getTotalMetric(GoalType type) {
    return fitnessManager.workouts.fold(0.0, (
      sum,
      workout,
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
}
