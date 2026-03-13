import 'package:fitness_tracker_app/models/goal_model.dart';

enum WorkoutEnum { pullup, jogging }

abstract class WorkoutModel {
  final int _duration;
  final double _caloriesBurnt;
  final double? _distanceCovered;

  WorkoutModel(
    int duration,
    double caloriesBurnt, [
    double? distanceCovered,
  ]) : _duration = duration,
       _caloriesBurnt = caloriesBurnt,
       _distanceCovered = distanceCovered;

  int get duration => _duration;
  double get caloriesBurnt => _caloriesBurnt;
  double? get distanceCovered => _distanceCovered;
}

class Jogging extends WorkoutModel {
  Jogging(
    super.duration,
    super.caloriesBurnt,
    super.distanceCovered,
  );

  @override
  String toString() {
    return "Jogging";
  }
}

class Pushup extends WorkoutModel {
  Pushup(super.duration, super.caloriesBurnt);

  @override
  String toString() {
    return "Pushup";
  }
}

List<WorkoutModel> workoutList = [
  Jogging(15, 35.1, 3),
  Pushup(22, 55.1),
];

void addWorkout(
  String type,
  int duration,
  double calorie, [
  double? distance,
]) {
  WorkoutModel newWorkout = switch (type) {
    "jogging" => Jogging(duration, calorie, distance),
    "pushup" => Pushup(duration, calorie),
    _ => Pushup(duration, calorie),
  };

  workoutList.add(newWorkout);

  //Change the state of the goal as new workout has been added
  changeGoalState();
}
