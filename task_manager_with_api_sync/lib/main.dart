import 'package:flutter/material.dart';
import 'package:task_manager_with_api_sync/ui/core/theme/app_theme.dart';
import 'package:task_manager_with_api_sync/utils/go_router.dart';

void main() {
  runApp(mainApp());
}

Widget mainApp() {
  return MaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: 'Task Manager',
    routerConfig: goRouter,
    theme: AppTheme.lightTheme,
  );
}
