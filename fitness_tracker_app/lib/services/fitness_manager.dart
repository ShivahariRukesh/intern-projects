import '../models/workout_model.dart';
import '../models/goal_model.dart';

class FitnessManager {
  final List<WorkoutModel> _workouts = <WorkoutModel>[];
  final List<GoalModel> _goals = <GoalModel>[];

  List<WorkoutModel> get workouts =>
      List<WorkoutModel>.unmodifiable(_workouts);
  List<GoalModel> get goals =>
      List<GoalModel>.unmodifiable(_goals);

  void addWorkout(WorkoutModel workout) {
    _workouts.add(workout);
  }

  void addGoal(GoalModel goal) {
    _goals.add(goal);
  }
}
