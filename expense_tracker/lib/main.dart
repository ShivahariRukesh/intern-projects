import 'package:expense_tracker/providers/counter_provider.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounterProvider(0),
        ),
      ],
      child: mainExpenseTracker(),
    ),
  );
}

MaterialApp mainExpenseTracker() {
  return const MaterialApp(
    home: Scaffold(body: HomeScreen()),
  );
}
