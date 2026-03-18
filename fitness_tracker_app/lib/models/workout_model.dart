enum WorkoutEnum { jogging, pullup }

abstract class WorkoutModel {
  final int duration;
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
