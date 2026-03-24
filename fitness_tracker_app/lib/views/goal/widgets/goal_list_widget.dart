import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:flutter/material.dart';

/// A widget that displays the lists of all goals created
class GoalListWidget extends StatelessWidget {
  ///[goalList] is the List of [GoalModel] data type that retains the collection of goals.
  final List<GoalModel> goalList;

  /// Takes two named parameters:
  /// - [key] is optional, uniquely identifies widget in the widget tree
  /// - [goalList] is required parameter that has lists of goals that were created.
  const GoalListWidget({super.key, required this.goalList});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: goalList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.8,
              mainAxisSpacing: 12,
            ),
        itemBuilder: (BuildContext context, int index) {
          final GoalModel goal = goalList[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.listTileTheme.tileColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.flag),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        goal.title,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.category,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          goal.type
                              .toString()
                              .split('.')
                              .last,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.track_changes,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text('${goal.target}'),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    LinearProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      value: goalController
                          .getProgressFraction(goal),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${goalController.getProgressFraction(goal) > 1 ? 100 : ((goalController.getProgressFraction(goal) * 100) as num).toStringAsFixed(0)}%',
                        style: theme.textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
