class TaskModel {
  int? id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String dueDate;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
    required this.priority,
  });

  TaskModel.fromJSON(Map<String, Object?> jsonData)
    : id = jsonData['id'] as int?,
      title = jsonData['title'] as String,
      description = jsonData['description'] as String,
      status = jsonData['status'] as String,
      dueDate = jsonData['dueDate'] as String,
      priority = jsonData['priority'] as String;

  Map<String, Object?> toJSON() {
    return <String, Object?>{
      'title': title,
      'description': description,
      'status': status,
      'dueDate': dueDate,
      'priority': priority,
    };
  }
}
