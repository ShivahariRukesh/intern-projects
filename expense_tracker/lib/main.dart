import 'package:expense_tracker/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Entry point of the Expense Tracker application.
///
/// Initializes Flutter bindings, loads persistent storage using
/// `SharedPreferences`, and launches the [App] widget.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();

  runApp(App(sharedPref: sharedPref));
}
