import 'package:fitness_tracker_app/models/workout_model.dart';
import 'package:fitness_tracker_app/utils/global_instance.dart';
import 'package:flutter/material.dart';

/// Lists all the workout completed
///
/// Keeps the track of history of workouts which was submitted using the workout form.
class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: fitnessService.workouts.length,
        separatorBuilder:
            (BuildContext context, int index) =>
                const SizedBox(height: 12),
        itemBuilder: (BuildContext context, int index) {
          final WorkoutModel workout =
              fitnessService.workouts[index];
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
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.surface,
                child: Icon(
                  Icons.fitness_center,
                  color: theme.primaryColor,
                ),
              ),
              title: Text(
                workout.toString(),
                style: theme.textTheme.displayMedium,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.local_fire_department,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${workout.caloriesBurnt}\t',
                      style: theme.textTheme.displayMedium,
                    ),
                    const Text('kcal'),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.timer_outlined,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${workout.duration}\t',
                      style: theme.textTheme.displayMedium,
                    ),
                    const Text('min'),
                    const SizedBox(width: 20),
                    ..._showDistanceMeasure(workout, theme),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _showDistanceMeasure(
    WorkoutModel workout,
    ThemeData theme,
  ) {
    if (workout is Jogging) {
      return <Widget>[
        const Icon(Icons.straighten_outlined, size: 18),
        const SizedBox(width: 4),
        Text(
          '${workout.distance}\t',
          style: theme.textTheme.displayMedium,
        ),
        const Text('km'),
      ];
    } else if (workout is Climbing) {
      return <Widget>[
        const Icon(Icons.straighten_outlined, size: 18),
        const SizedBox(width: 4),
        Text(
          '${workout.distance}\t',
          style: theme.textTheme.displayMedium,
        ),
        const Text('km'),
      ];
    } else {
      return <Widget>[const SizedBox()];
    }
  }
}
