import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/data/services/expense_service.dart';
import 'package:expense_tracker/ui/expense/expense_screen.dart';
import 'package:expense_tracker/ui/expense/view_models/expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Root widget of the Expense Tracker application.
///
/// Sets up dependency injection for services, repositories, and view models
/// using the Provider package and defines the main [MaterialApp] with its
/// initial screen.
class App extends StatelessWidget {
  /// The SharedPreferences instance used for persistent storage.
  final SharedPreferences sharedPref;

  /// Requires a [sharedPref] instance that is passed down to services.
  const App({super.key, required this.sharedPref});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ExpenseService>(
          create: (_) => ExpenseService(sharedPref),
        ),
        ProxyProvider<ExpenseService, ExpenseRepository>(
          update: (_, service, __) =>
              ExpenseRepository(service),
        ),

        ChangeNotifierProxyProvider<
          ExpenseRepository,
          ExpenseViewModel
        >(
          create: (ctx) => ExpenseViewModel(
            repository: ctx.read<ExpenseRepository>(),
          ),
          update: (_, repository, previous) =>
              previous ??
              ExpenseViewModel(repository: repository),
        ),
      ],
      child: const MaterialApp(
        title: 'Expense Tracker App',
        home: ExpenseScreen(),
      ),
    );
  }
}
