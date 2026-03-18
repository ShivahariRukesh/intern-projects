import 'package:fitness_tracker_app/models/workout_model.dart';

enum GoalType { duration, distance, calorie }

class GoalModel {
  final String title;
  final GoalType type;
  final num target;

  GoalModel(this.title, this.type, this.target);

  double calculateProgressFraction(
    List<WorkoutModel> workouts,
  ) {
    double totalValue = workouts.fold(0, (sum, workout) {
      return sum +
          switch (type) {
            GoalType.duration =>
              workout.duration.toDouble(),
            GoalType.distance =>
              workout.distanceCovered ?? 0.0,
            GoalType.calorie => workout.caloriesBurnt,
          };
    });

    if (target < 0) return 0.0;
    return (totalValue / target).clamp(0.0, 1.0);
  }
}
