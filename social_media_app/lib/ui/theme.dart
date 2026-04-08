import 'package:flutter/material.dart';

class AppTheme {
  static const errorColor = Colors.red;
  static const lightThemePrimaryColor = Colors.black;
  static const lightThemeBackgroundColor = Color.fromARGB(255, 169, 189, 217);
  static const lightThemeSecondaryColor = Color.fromARGB(255, 6, 102, 237);

  static const darkThemePrimaryColor = Colors.white;

  static const darkThemeBackgroundColor = Colors.black;

  static const darkThemeSecondaryColor = Color.fromARGB(255, 6, 102, 237);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: lightThemePrimaryColor,
          primary: lightThemePrimaryColor,
          secondary: lightThemeSecondaryColor,
          error: errorColor,
          onSurface: lightThemeSecondaryColor,
          surface: lightThemeBackgroundColor,
        ),

        // Light Text Theme
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: lightThemePrimaryColor,
            fontSize: 20,
          ),
          bodyMedium: TextStyle(
            color: lightThemePrimaryColor,
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            color: lightThemePrimaryColor,
            fontSize: 14,
          ),
          titleLarge: TextStyle(
            color: lightThemeSecondaryColor,
            fontSize: 22,
          ),
        ),

        scaffoldBackgroundColor: lightThemeSecondaryColor,
        appBarTheme: const AppBarTheme(),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: darkThemePrimaryColor,
            primary: darkThemePrimaryColor,
            secondary: darkThemeSecondaryColor,
            error: errorColor,
            onSurface: darkThemeSecondaryColor,
            surface: darkThemeBackgroundColor),

        // Dark Text Theme
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: darkThemePrimaryColor,
            fontSize: 20,
          ),
          bodyMedium: TextStyle(
            color: darkThemePrimaryColor,
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            color: darkThemePrimaryColor,
            fontSize: 14,
          ),
          titleLarge: TextStyle(
            color: darkThemePrimaryColor,
            fontSize: 22,
          ),
        ),

        scaffoldBackgroundColor: lightThemeSecondaryColor,
        appBarTheme: const AppBarTheme(),
      );
}
