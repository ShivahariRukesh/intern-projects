import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_scaffold_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view/widgets/task_create_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view/widgets/task_list_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view_model/task_view_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Task',
      scaffoldBody: Column(
        children: <Widget>[
          const Expanded(child: TaskListWidget()),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: <Widget>[
              const TaskCreateWidget(),
              ElevatedButton(
                onPressed: () => Provider.of<TaskViewModel>(
                  context,
                  listen: false,
                ).syncApiTasks(),
                child: const Text('Sync Tasks'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
