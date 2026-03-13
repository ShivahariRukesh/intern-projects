import 'package:fitness_tracker_app/models/workout_model.dart';
import 'package:flutter/cupertino.dart';

enum GoalTypeEnum { duration, distance, calorie }

class GoalModel {
  String goalTitle;
  GoalTypeEnum goalType;
  num goalTarget;
  double progress;

  GoalModel(
    this.goalTitle,
    this.goalType,
    this.goalTarget,
    this.progress,
  );
}

List<GoalModel> goalList = [
  // GoalModel("Lets Jog", GoalTypeEnum.distance, 12.2, 0.33),
  // GoalModel(
  //   "Lets Pushup ",
  //   GoalTypeEnum.duration,
  //   90,
  //   0.22,
  // ),
  // GoalModel(
  //   "Lets Pushup",
  //   GoalTypeEnum.calorie,
  //   1000.5,
  //   0.11,
  // ),
];

Map<String, num> progressMap = {
  "totalDuration": 0,
  "totalCaloriesBurnt": 0.0,
  "totalDistanceCovered": 0.0,
};

//Calculate progress of each goal type
void calculateProgress() {
  // workoutList.forEach((workout) {
  //   progressMap["totalDuration"] =
  //       (progressMap["totalDuration"]!) + workout.duration;
  //   progressMap["totalCaloriesBurnt"] =
  //       (progressMap["totalCaloriesBurnt"]!) +
  //       workout.caloriesBurnt;
  //   progressMap["totalDistanceCovered"] =
  //       (progressMap["totalDistanceCovered"]!) +
  //       (workout.distanceCovered ?? 0);
  // });

  for (var workout in workoutList) {
    progressMap["totalDuration"] =
        (progressMap["totalDuration"]!) + workout.duration;

    progressMap["totalCaloriesBurnt"] =
        (progressMap["totalCaloriesBurnt"]!) +
        workout.caloriesBurnt;

    progressMap["totalDistanceCovered"] =
        (progressMap["totalDistanceCovered"]!) +
        (workout.distanceCovered ?? 0);
  }
}

//Change the goal state to update the progress
void changeGoalState() {
  calculateProgress();
  progressMap.forEach(
    (key, value) =>
        debugPrint("The progress is $key $value"),
  );
  // goalList.forEach((goal) {
  //   if (goal.goalType.name == "duration") {
  //     goal.progress =
  //         double.tryParse(
  //           ((progressMap["totalDuration"] ?? 0) /
  //                   goal.goalTarget)
  //               .toStringAsFixed(2),
  //         ) ??
  //         0;
  //     debugPrint("Calc duration ${goal.progress}");
  //   } else if (goal.goalType.name == "calorie") {
  //     goal.progress =
  //         double.tryParse(
  //           ((progressMap["totalCaloriesBurnt"] ?? 0) /
  //                   goal.goalTarget)
  //               .toStringAsFixed(2),
  //         ) ??
  //         0;
  //     debugPrint("Calc calorie ${goal.progress}");
  //   } else if (goal.goalType.name == "distance") {
  //     goal.progress =
  //         double.tryParse(
  //           ((progressMap["totalDistanceCovered"] ?? 0) /
  //                   goal.goalTarget)
  //               .toStringAsFixed(2),
  //         ) ??
  //         0;
  //     debugPrint("Calc distance ${goal.progress}");
  //   }
  // });

  for (var goal in goalList) {
    if (goal.goalType.name == "duration") {
      goal.progress =
          double.tryParse(
            ((progressMap["totalDuration"] ?? 0) /
                    goal.goalTarget)
                .toStringAsFixed(2),
          ) ??
          0;

      debugPrint("Calc duration ${goal.progress}");
    } else if (goal.goalType.name == "calorie") {
      goal.progress =
          double.tryParse(
            ((progressMap["totalCaloriesBurnt"] ?? 0) /
                    goal.goalTarget)
                .toStringAsFixed(2),
          ) ??
          0;

      debugPrint("Calc calorie ${goal.progress}");
    } else if (goal.goalType.name == "distance") {
      goal.progress =
          double.tryParse(
            ((progressMap["totalDistanceCovered"] ?? 0) /
                    goal.goalTarget)
                .toStringAsFixed(2),
          ) ??
          0;

      debugPrint("Calc distance ${goal.progress}");
    }
  }

  progressMap = {
    "totalDuration": 0,
    "totalCaloriesBurnt": 0.0,
    "totalDistanceCovered": 0.0,
  };
}

num handleProgressType(String goalType) {
  return switch (goalType) {
    "duration" => progressMap["totalDuration"] ?? 0,
    "distance" => progressMap["totalDistanceCovered"] ?? 0,
    "calorie" => progressMap["totalCaloriesBurnt"] ?? 0,
    _ => 0,
  };
}

String getTotalMeasurement(String goalType) {
  calculateProgress();
  var currentProgress = handleProgressType(
    goalType,
  ).toStringAsFixed(1);
  //Reset the progress map to zero cause we don't want same previous value to be added when adding new goal
  progressMap = {
    "totalDuration": 0,
    "totalCaloriesBurnt": 0.0,
    "totalDistanceCovered": 0.0,
  };
  return currentProgress;
}

void addGoal(
  String goalTitle,
  String goalType,
  num goalTarget,
) {
  debugPrint(goalType);
  calculateProgress();
  progressMap.forEach(
    (key, value) =>
        debugPrint("The progress is $key $value"),
  );
  // final num progress = switch (goalType) {
  //   "duration" => progressMap["totalDuration"] ?? 0,
  //   "distance" => progressMap["totalDistanceCovered"] ?? 0,
  //   "calorie" => progressMap["totalCaloriesBurnt"] ?? 0,
  //   _ => 0,
  // };
  final num progress = handleProgressType(goalType);
  double progressFraction =
      double.tryParse(
        (progress / goalTarget).toStringAsFixed(2),
      ) ??
      0;

  int typeIndex = GoalTypeEnum.values.indexWhere(
    (type) => type.name == goalType,
  );

  goalList.add(
    GoalModel(
      goalTitle,
      GoalTypeEnum.values[typeIndex],
      goalTarget,
      progressFraction,
    ),
  );

  //Reset the progress map to zero cause we don't want same previous value to be added when adding new goal
  progressMap = {
    "totalDuration": 0,
    "totalCaloriesBurnt": 0.0,
    "totalDistanceCovered": 0.0,
  };
}
