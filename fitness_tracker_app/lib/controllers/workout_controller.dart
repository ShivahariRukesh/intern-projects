import '../models/workout_model.dart';
import '../services/fitness_manager.dart';

class WorkoutController {
  final FitnessManager fitnessManager;

  WorkoutController(this.fitnessManager);

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
}
