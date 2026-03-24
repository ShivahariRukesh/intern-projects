/// Represents the type of goal a user can set.
///
/// - [duration]: Goal based on time.
/// - [distance]: Goal based on distance.
/// - [calorie]: Goal based on calories burned.
enum GoalType { duration, distance, calorie }

/// A model class that defines a fitness or activity goal.
///
/// This class is used to store information about a specific goal,
/// including its title, type, and target value.
class GoalModel {
  /// The title to identify the goal.
  final String title;

  /// The type of the goal, defined by [GoalType].
  final GoalType type;

  /// The target value to achieve for this goal.
  final num target;

  /// Requires a [title], [type], and [target] value.
  GoalModel(this.title, this.type, this.target);
}
