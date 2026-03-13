import 'package:flutter/material.dart';

class GoalListWidget extends StatelessWidget {
  final List goalList;

  const GoalListWidget({super.key, required this.goalList});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        itemBuilder: (context, index) {
          final goal = goalList[index];

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.listTileTheme.tileColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flag),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        goal.goalTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.category,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          goal.goalType
                              .toString()
                              .split('.')
                              .last,
                        ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    Row(
                      children: [
                        const Icon(
                          Icons.track_changes,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text("${goal.goalTarget}"),
                      ],
                    ),
                  ],
                ),

                Column(
                  children: [
                    LinearProgressIndicator(
                      value: goal.progress ?? 0,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${goal.progress > 1 ? 100 : ((goal.progress * 100) as num).toStringAsFixed(0)}%",
                        style: theme.textTheme.bodySmall,
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
