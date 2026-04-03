import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:task_manager_with_api_sync/data/repositories/task_repository.dart';
import 'package:task_manager_with_api_sync/data/services/database/task_database_service.dart';
import 'package:task_manager_with_api_sync/data/services/network/task_dio_service.dart';
import 'package:task_manager_with_api_sync/ui/core/theme/app_theme.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view_model/task_view_model.dart';
import 'package:task_manager_with_api_sync/utils/go_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<TaskDatabaseService>(
          create: (_) => TaskDatabaseService(),
        ),
        Provider<TaskDioService>(
          create: (_) => TaskDioService(),
        ),
        Provider<TaskRepository>(
          create: (BuildContext context) => TaskRepository(
            taskDatabaseService: context
                .read<TaskDatabaseService>(),
            taskDioService: context.read<TaskDioService>(),
          ),
        ),
        ChangeNotifierProvider<TaskViewModel>(
          create: (BuildContext context) => TaskViewModel(
            taskRepository: context.read<TaskRepository>(),
          ),
        ),
      ],
      child: mainApp(),
    ),
  );
}

Widget mainApp() {
  return MaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: 'Task Manager',
    routerConfig: goRouter,
    theme: AppTheme.lightTheme,
  );
}
