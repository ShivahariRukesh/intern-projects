import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData currentTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green.shade400,

        surface: Colors.black,
        onSurface: Colors.green.shade400,
        primary: Colors.green.shade400,
        // brightness: Brightness.dark,
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),

        // bodyMedium: TextStyle(
        //   fontSize: 32,
        //   fontWeight: FontWeight.normal,
        // ),
      ),

      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Color.fromARGB(255, 206, 52, 52),
          ),
          iconColor: WidgetStatePropertyAll(Colors.blue),
        ),
      ),
    );
  }
}
