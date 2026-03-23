import '../models/workout_model.dart';
import '../models/goal_model.dart';

class FitnessManager {
  final List<WorkoutModel> _workouts = [];
  final List<GoalModel> _goals = [];

  List<WorkoutModel> get workouts =>
      List.unmodifiable(_workouts);
  List<GoalModel> get goals => List.unmodifiable(_goals);

  void addWorkout(WorkoutModel workout) {
    _workouts.add(workout);
  }

  void addGoal(GoalModel goal) {
    _goals.add(goal);
  }
}
