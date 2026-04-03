import 'package:task_manager_with_api_sync/utils/helper_functions.dart';

class TaskModel {
  int? id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String dueDate;
  bool isApiData;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
    required this.priority,
    required this.isApiData,
  });

  factory TaskModel.fromApi(Map<String, dynamic> json) {
    return TaskModel(
      title: json['todo'] ?? 'Title From Api',
      description: 'Description From Api',
      status: (json['completed'] ?? false)
          ? 'Completed'
          : 'In-Progress',
      dueDate: calculateDateNow(),
      priority: 'Low',
      isApiData: true,
    );
  }

  TaskModel.fromDb(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      description = json['description'],
      status = json['status'],
      dueDate = json['dueDate'],
      priority = json['priority'],
      isApiData = json['isApiData'] as int == 1
          ? true
          : false;

  Map<String, Object?> toJSON() {
    return <String, Object?>{
      'title': title,
      'description': description,
      'status': status,
      'dueDate': dueDate,
      'priority': priority,
      'isApiData': isApiData ? 1 : 0,
    };
  }
}
