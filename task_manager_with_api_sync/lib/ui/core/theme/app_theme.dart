import 'package:flutter/material.dart';

class AppTheme {
  static final Color darkThemePrimaryColor = Colors.white;
  static final Color darkThemeSecondaryColor =
      Colors.grey.shade700;

  static final Color darkThemeBackgroundColor =
      Colors.black;

  static final Color lightThemePrimaryColor = Colors.black;
  static final Color lightThemeSecondaryColor =
      Colors.blueGrey;
  static final Color lightThemeBackgroundColor =
      Colors.white;

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightThemePrimaryColor,
      primary: lightThemePrimaryColor,
      secondary: lightThemeSecondaryColor,
      // error: Colors.red
      onSurface: lightThemeSecondaryColor,
      surface: lightThemeBackgroundColor,
    ),

    // Dark Text Theme
    textTheme: TextTheme(
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
        color: lightThemePrimaryColor,
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
      // error :
      onSurface: darkThemeSecondaryColor,
      surface: darkThemeBackgroundColor,
    ),

    textTheme: TextTheme(
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
  );
}
