import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view/widgets/task_content_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view_model/task_view_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskViewModel vm = context.watch<TaskViewModel>();
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(color: Colors.blue),

      child: GridView.builder(
        itemCount: vm.taskList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
        itemBuilder: (_, int index) {
          return InkWell(
            child: Card(
              child: TaskContentWidget(
                task: vm.taskList[index],
                id: vm.taskList[index].id,
              ),
            ),
          );
        },
      ),
    );
  }
}
