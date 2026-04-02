import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:task_manager_with_api_sync/ui/core/theme/app_theme.dart';
import 'package:task_manager_with_api_sync/ui/features/task/view_model/task_view_model.dart';
import 'package:task_manager_with_api_sync/utils/go_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<TaskViewModel>(
          create: (BuildContext context) => TaskViewModel(),
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
