import 'package:fitness_tracker_app/controllers/goal_controller.dart';
import 'package:fitness_tracker_app/controllers/workout_controller.dart';
import 'package:fitness_tracker_app/services/fitness_manager.dart';

final FitnessManager fitnessService = FitnessManager();
final GoalController goalController = GoalController(
  fitnessService,
);

final WorkoutController workoutController =
    WorkoutController(fitnessService);
