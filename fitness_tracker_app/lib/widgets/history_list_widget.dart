import 'package:fitness_tracker_app/models/workout_model.dart';
import 'package:flutter/material.dart';

class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: workoutList.length,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
              leading: Icon(Icons.work),
              title: Text(workoutList[index].toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize
                    .min, // Only take what's needed for horizontal space
                spacing: 50,
                children: [
                  //Wrap it up with reusable widget
                  Row(
                    children: [
                      Text(
                        "${workoutList[index].caloriesBurnt}",
                      ),
                      Icon(Icons.run_circle),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${workoutList[index].duration}",
                      ),
                      Icon(Icons.exit_to_app),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
