enum WorkoutType { jogging, pullup, situp, plank, climbing }

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

class Climbing extends WorkoutModel {
  final double distance;

  Climbing({
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
  String toString() => "Climbing";
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

class Situp extends WorkoutModel {
  Situp({
    required int duration,
    required double caloriesBurnt,
  }) : super(
         duration: duration,
         caloriesBurnt: caloriesBurnt,
       );

  @override
  String toString() => "Situp";
}

class Plank extends WorkoutModel {
  Plank({
    required int duration,
    required double caloriesBurnt,
  }) : super(
         duration: duration,
         caloriesBurnt: caloriesBurnt,
       );

  @override
  String toString() => "Plank";
}
