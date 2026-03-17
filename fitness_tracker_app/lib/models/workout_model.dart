// import 'package:fitness_tracker_app/models/goal_model.dart';

// enum WorkoutEnum { pullup, jogging }

// abstract class WorkoutModel {
//   final int _duration;
//   final double _caloriesBurnt;
//   final double? _distanceCovered;

//   WorkoutModel(
//     int duration,
//     double caloriesBurnt, [
//     double? distanceCovered,
//   ]) : _duration = duration,
//        _caloriesBurnt = caloriesBurnt,
//        _distanceCovered = distanceCovered;

//   int get duration => _duration;
//   double get caloriesBurnt => _caloriesBurnt;
//   double? get distanceCovered => _distanceCovered;
// }

// class Jogging extends WorkoutModel {
//   Jogging(
//     super.duration,
//     super.caloriesBurnt,
//     super.distanceCovered,
//   );

//   @override
//   String toString() {
//     return "Jogging";
//   }
// }

// class Pushup extends WorkoutModel {
//   Pushup(super.duration, super.caloriesBurnt);

//   @override
//   String toString() {
//     return "Pushup";
//   }
// }

// List<WorkoutModel> workoutList = [
//   Jogging(15, 35.1, 3),
//   Pushup(22, 55.1),
// ];

// void addWorkout(
//   String type,
//   int duration,
//   double calorie, [
//   double? distance,
// ]) {
//   WorkoutModel newWorkout = switch (type) {
//     "jogging" => Jogging(duration, calorie, distance),
//     "pushup" => Pushup(duration, calorie),
//     _ => Pushup(duration, calorie),
//   };

//   workoutList.add(newWorkout);

//   //Change the state of the goal as new workout has been added
//   changeGoalState();
// }

enum WorkoutEnum { jogging, pullup }

abstract class WorkoutModel {
  final int duration; // in minutes
  final double caloriesBurnt;
  final double? distanceCovered;

  WorkoutModel({
    required this.duration,
    required this.caloriesBurnt,
    this.distanceCovered,
  });
}

class Jogging extends WorkoutModel {
  Jogging({
    required int duration,
    required double caloriesBurnt,
    required double distance,
  }) : super(
         duration: duration,
         caloriesBurnt: caloriesBurnt,
         distanceCovered: distance,
       );

  @override
  String toString() => "Jogging";
}

class Pushup extends WorkoutModel {
  Pushup({
    required int duration,
    required double caloriesBurnt,
  }) : super(
         duration: duration,
         caloriesBurnt: caloriesBurnt,
       );

  @override
  String toString() => "Pushup";
}
