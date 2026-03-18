import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/models/workout_model.dart';

class FitnessManager {
  final List<WorkoutModel> _workouts = [];
  final List<GoalModel> _goals = [];

  List<WorkoutModel> get workouts =>
      List.unmodifiable(_workouts);
  List<GoalModel> get goals => List.unmodifiable(_goals);

  void addWorkout(
    String type,
    int duration,
    double calorie, [
    double? distance,
  ]) {
    WorkoutModel newWorkout = switch (type) {
      "jogging" => Jogging(
        duration: duration,
        caloriesBurnt: calorie,
        distance: distance!,
      ),
      "pushup" => Pushup(
        duration: duration,
        caloriesBurnt: calorie,
      ),
      _ => Pushup(
        duration: duration,
        caloriesBurnt: calorie,
      ),
    };

    _workouts.add(newWorkout);
  }

  void addGoal(GoalModel goal) {
    _goals.add(goal);
  }

  double getTotalMetric(GoalType type) {
    return _workouts.fold(
      0.0,
      (sum, workout) =>
          sum +
          switch (type) {
            GoalType.duration =>
              workout.duration.toDouble(),
            GoalType.distance =>
              workout.distanceCovered ?? 0,
            GoalType.calorie => workout.caloriesBurnt,
          },
    );
  }
}

final fitnessService = FitnessManager();
