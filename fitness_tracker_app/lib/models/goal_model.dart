enum GoalType { duration, distance, calorie }

class GoalModel {
  final String title;
  final GoalType type;
  final num target;

  GoalModel(this.title, this.type, this.target);
}
