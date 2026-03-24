import 'package:expense_tracker/ui/expense/view_models/expense_view_model.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpenseViewModel(),
        ),
      ],
      child: mainExpenseTracker(),
    ),
  );
}

MaterialApp mainExpenseTracker() {
  return const MaterialApp(
    home: Scaffold(
      body: ExpenseScreen(),
      backgroundColor: Color.fromARGB(66, 237, 237, 237),
    ),
  );
}
