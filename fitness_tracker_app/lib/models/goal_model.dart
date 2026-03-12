import 'package:flutter/rendering.dart';

enum GoalTypeEnum { duration, distance, calorie }

class GoalModel {
  final String goalTitle;
  final GoalTypeEnum goalType;
  final num goalTarget;

  GoalModel(this.goalTitle, this.goalType, this.goalTarget);
}

List<GoalModel> goalList = [
  GoalModel("Lets Jog", GoalTypeEnum.distance, 12.2),
  GoalModel("Lets Pushup ", GoalTypeEnum.duration, 90),
  GoalModel("Lets Pushup", GoalTypeEnum.calorie, 1000.5),
];

void addGoal(
  String goalTitle,
  String goalType,
  num goalTarget,
) {
  // debugPrint();
  int typeIndex = GoalTypeEnum.values.indexWhere(
    (type) => type.name == goalType,
  );
  goalList.add(
    GoalModel(
      goalTitle,
      GoalTypeEnum.values[typeIndex],
      goalTarget,
    ),
  );
}
