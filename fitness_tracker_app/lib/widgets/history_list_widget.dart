import 'package:fitness_tracker_app/models/workout_model.dart';
import 'package:fitness_tracker_app/services/fitness_manager.dart';
import 'package:flutter/material.dart';

class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: fitnessService.workouts.length,

        separatorBuilder: (context, index) =>
            const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final workout = fitnessService.workouts[index];

          return Container(
            decoration: BoxDecoration(
              color: theme.listTileTheme.tileColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: const CircleAvatar(
                child: Icon(Icons.fitness_center),
              ),
              title: Text(
                workout.toString(),
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 18,
                    ),
                    const SizedBox(width: 4),

                    Text("${workout.caloriesBurnt} kcal"),

                    const SizedBox(width: 20),

                    const Icon(
                      Icons.timer_outlined,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text("${workout.duration} min"),

                    const SizedBox(width: 20),

                    if (workout.distanceCovered !=
                        null) ...[
                      const Icon(
                        Icons.straighten_outlined,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text("${workout.distanceCovered} km"),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
