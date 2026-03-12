import 'package:fitness_tracker_app/models/goal_model.dart';
import 'package:fitness_tracker_app/widgets/add_goal_bottom_sheet_widget.dart';
import 'package:fitness_tracker_app/widgets/scaffold_widget.dart';
import 'package:flutter/material.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  var _goalList = goalList;
  void onGoalBottomSheet(BuildContext context) async {
    var resp = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) =>
          AddGoalBottomSheetWidget(),
    );
    setState(() {
      _goalList = goalList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Goals",
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3,
                mainAxisSpacing: 10,
              ),
          itemCount: _goalList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [
                      Text(_goalList[index].goalTitle),
                      Text(_goalList[index].goalType.name),
                      Text(
                        _goalList[index].goalTarget
                            .toString(),
                      ),
                    ],
                  ),
                  Text("Progress Bar"),
                ],
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => onGoalBottomSheet(context),

        child: Icon(Icons.add),
      ),
    );
  }
}
