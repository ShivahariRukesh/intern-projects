import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_with_api_sync/data/models/task_model.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view/widgets/task_form_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view_model/task_view_model.dart';

class TaskCreateWidget extends StatelessWidget {
  const TaskCreateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void createTask(TaskModel task) {
      Provider.of<TaskViewModel>(
        context,
        listen: false,
      ).addTask(task);
    }

    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) =>
              TaskFormWidget(onSubmitForm: createTask),
        );
      },
      child: const Text('Create Task'),
    );
  }
}
