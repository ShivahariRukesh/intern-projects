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

  TaskModel.fromJSON(Map<String, String> jsonData)
    : id = jsonData['id'] as int?,
      title = jsonData['title'] ?? 'Untitled',
      description = jsonData['description'] ?? '',
      status = jsonData['status'] ?? 'incomplete',
      dueDate = jsonData['dueDate'] ?? '${DateTime.now()}',
      priority = jsonData['priority'] ?? 'low';

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
