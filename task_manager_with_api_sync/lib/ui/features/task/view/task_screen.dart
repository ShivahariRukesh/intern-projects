import 'package:flutter/material.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_scaffold_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Task',
      scaffoldBody: Column(
        children: <Widget>[
          OutlinedButton(
            onPressed: () {},
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
