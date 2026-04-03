import 'package:flutter/material.dart';
import 'package:task_manager_with_api_sync/data/models/task_model.dart';

class TaskFormWidget extends StatefulWidget {
  final TaskModel? task;
  final void Function(TaskModel) onSubmitForm;
  const TaskFormWidget({
    required this.onSubmitForm,
    super.key,
    this.task,
  });

  @override
  State<TaskFormWidget> createState() =>
      _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final TextEditingController titleController =
      TextEditingController();
  final TextEditingController descriptionController =
      TextEditingController();

  late String status;
  late String priority;
  String dueDate =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  final List<String> priorities = <String>[
    'Low',
    'Medium',
    'High',
  ];

  bool showErrors = false;

  bool get isValid =>
      titleController.text.trim().isNotEmpty &&
      descriptionController.text.trim().isNotEmpty;

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 5),
      ),
    );

    String convertedDate = picked == null
        ? '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
        : picked.toString().substring(0, 10);

    setState(() => dueDate = convertedDate);
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    final bool hasError =
        showErrors && controller.text.trim().isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.grey.shade100,
            errorText: hasError
                ? '$label is required'
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }

  Widget statusOption(String value) {
    return InkWell(
      onTap: () => setState(() => status = value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Checkbox(
            value: status == value,
            onChanged: (_) =>
                setState(() => status = value),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              /// Title
              buildTextField(
                label: 'Title',
                controller: titleController,
              ),
              const SizedBox(height: 12),

              /// Description
              buildTextField(
                label: 'Description',
                controller: descriptionController,
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              /// Status
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Task Status'),
                  Wrap(
                    spacing: 0.0,
                    children: <Widget>[
                      statusOption('Pending'),
                      statusOption('In-Progress'),
                      statusOption('Done'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// Priority
              DropdownButtonFormField<String>(
                initialValue: priority,
                items: priorities
                    .map(
                      (String e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Priority',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (String? val) =>
                    setState(() => priority = val!),
              ),
              const SizedBox(height: 16),

              /// Due Date
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Due Date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: pickDate,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Text(dueDate),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => showErrors = true);

                    if (!isValid) return;

                    widget.onSubmitForm(
                      TaskModel(
                        title: titleController.text,
                        description:
                            descriptionController.text,
                        status: status,
                        priority: priority,
                        dueDate: dueDate,
                        isApiData: false,
                      ),
                    );

                    Navigator.pop(context);
                  },
                  child: Text(
                    widget.task == null
                        ? 'Submit Task'
                        : 'Edit Task',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task?.title ?? '';
    descriptionController.text = widget.task?.title ?? '';
    priority = widget.task?.priority ?? 'Low';
    status = widget.task?.status ?? 'Pending';
    dueDate =
        widget.task?.dueDate ??
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
}
