/// Represents different types of workouts.
///
/// - [jogging]: A jogging workout with distance tracking.
/// - [pullup]: A pullup workout.
/// - [situp]: A situp workout.
/// - [plank]: A plank workout.
/// - [climbing]: A climbing workout with distance tracking.
enum WorkoutType { jogging, pullup, situp, plank, climbing }

/// An abstract base class representing a workout.
abstract class WorkoutModel {
  /// Duration of the workout in seconds
  final int duration;

  /// Total calories burned during the workout.
  final double caloriesBurnt;

  /// Creates a [WorkoutModel] with required [duration] and [caloriesBurnt].
  WorkoutModel({
    required this.duration,
    required this.caloriesBurnt,
  });

  double getDistance() => 0.0;
}

/// A workout model representing a jogging activity.
class Jogging extends WorkoutModel {
  /// Distance covered during jogging.
  final double distance;

  /// Creates a [Jogging] workout instance.
  ///
  /// Requires [duration], [caloriesBurnt], and [distance].
  Jogging({
    required super.duration,
    required super.caloriesBurnt,
    required this.distance,
  });

  @override
  double getDistance() => distance;

  @override
  String toString() => 'Jogging';
}

/// A workout model representing a climbing activity.
class Climbing extends WorkoutModel {
  /// Distance covered during climbing.
  final double distance;

  /// Creates a [Climbing] workout instance.
  ///
  /// Requires [duration], [caloriesBurnt], and [distance].
  Climbing({
    required super.duration,
    required super.caloriesBurnt,
    required this.distance,
  });

  @override
  double getDistance() => distance;

  @override
  String toString() => 'Climbing';
}

/// A workout model representing a pullup exercise.
class Pullup extends WorkoutModel {
  /// Creates a [Pullup] workout instance.
  ///
  /// Requires [duration] and [caloriesBurnt].
  Pullup({
    required super.duration,
    required super.caloriesBurnt,
  });

  @override
  String toString() => 'Pullup';
}

/// A workout model representing a sit-up exercise.
class Situp extends WorkoutModel {
  /// Creates a [Situp] workout instance.
  ///
  /// Requires [duration] and [caloriesBurnt].
  Situp({
    required super.duration,
    required super.caloriesBurnt,
  });

  @override
  String toString() => 'Situp';
}

/// A workout model representing a plank exercise.
class Plank extends WorkoutModel {
  /// Creates a [Plank] workout instance.
  ///
  /// Requires [duration] and [caloriesBurnt].
  Plank({
    required super.duration,
    required super.caloriesBurnt,
  });

  @override
  String toString() => 'Plank';
}
