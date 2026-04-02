import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_with_api_sync/data/models/task_model.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view/widgets/task_form_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view_model/task_view_model.dart';

class TaskContentWidget extends StatelessWidget {
  final TaskModel task;
  final int? id;
  const TaskContentWidget({
    super.key,
    required this.task,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    void editTask(TaskModel task) {
      Provider.of<TaskViewModel>(
        context,
        listen: false,
      ).updateTask(task, id!);
    }

    void showEditTaskModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => TaskFormWidget(
          onSubmitForm: editTask,
          task: task,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(task.title),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () =>
                      showEditTaskModal(context),
                  // Provider.of<TaskViewModel>(
                  //   context,
                  //   listen: false,
                  // ).updateTask(),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () =>
                      Provider.of<TaskViewModel>(
                        context,
                        listen: false,
                      ).deleteTask(id),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
        Text(task.status),
        Text(task.description),
        Text(task.priority),
        Text(task.dueDate),
      ],
    );
  }
}
