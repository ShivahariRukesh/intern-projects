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
      ).updateTask(task, id!); //check here firs
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

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Text(
                      task.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                          ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () =>
                          showEditTaskModal(context),
                      icon: const Icon(Icons.edit_outlined),
                      color: Colors.blueAccent,
                      tooltip: 'Edit Task',
                    ),
                    IconButton(
                      onPressed: () =>
                          Provider.of<TaskViewModel>(
                            context,
                            listen: false,
                          ).deleteTask(id),
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                      color: Colors.redAccent,
                      tooltip: 'Delete Task',
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
            ),

            const Divider(height: 32, thickness: 1),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                _buildBadge(
                  icon: Icons.info_outline,
                  text: task.status,
                  color: Colors.teal,
                ),
                _buildBadge(
                  icon: Icons.flag_outlined,
                  text: task.priority,
                  color: Colors.orange.shade700,
                ),
                _buildBadge(
                  icon: Icons.calendar_today_outlined,
                  text: task.dueDate,
                  color: Colors.indigo.shade400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
