import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_with_api_sync/ui/features/auth/view/login_screen.dart';
import 'package:task_manager_with_api_sync/ui/features/home/view/home_screen.dart';

void main() {
  runApp(mainApp());
}

Widget mainApp() {
  return MaterialApp.router(routerConfig: _router);
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder:
          (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder:
          (BuildContext context, GoRouterState state) =>
              const LoginScreen(),
    ),
  ],
);
