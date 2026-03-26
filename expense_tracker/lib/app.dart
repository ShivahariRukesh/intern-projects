import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/data/services/expense_service.dart';
import 'package:expense_tracker/ui/expense/expense_screen.dart';
import 'package:expense_tracker/ui/expense/view_models/expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  final SharedPreferences prefs;
  const App({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Data layer
        Provider<ExpenseService>(
          create: (_) => ExpenseService(prefs),
        ),
        ProxyProvider<ExpenseService, ExpenseRepository>(
          update: (_, service, __) =>
              ExpenseRepository(service),
        ),

        // ViewModel
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
