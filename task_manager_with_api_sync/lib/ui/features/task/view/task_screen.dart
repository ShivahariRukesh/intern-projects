import 'package:flutter/material.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_scaffold_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view/widgets/task_create_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view/widgets/task_list_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      title: 'Task',
      scaffoldBody: Column(
        children: <Widget>[
          Expanded(child: TaskListWidget()),
          TaskCreateWidget(),
        ],
      ),
    );
  }
}
