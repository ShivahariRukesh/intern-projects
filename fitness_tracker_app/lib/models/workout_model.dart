enum WorkoutType { jogging, pullup }

abstract class WorkoutModel {
  final int duration;
  final double caloriesBurnt;

  WorkoutModel({
    required this.duration,
    required this.caloriesBurnt,
  });

  double getDistance() => 0.0;
}

class Jogging extends WorkoutModel {
  final double distance;

  Jogging({
    required int duration,
    required double caloriesBurnt,
    required this.distance,
  }) : super(
         duration: duration,
         caloriesBurnt: caloriesBurnt,
       );

  @override
  double getDistance() => distance;

  @override
  String toString() => "Jogging";
}

class Pullup extends WorkoutModel {
  Pullup({
    required int duration,
    required double caloriesBurnt,
  }) : super(
         duration: duration,
         caloriesBurnt: caloriesBurnt,
       );

  @override
  String toString() => "Pullup";
}
