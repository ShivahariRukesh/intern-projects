import 'package:flutter/material.dart';

class AppTheme {
  static const errorColor = Colors.red;

  static const lightThemePrimaryColor = Colors.black;
  static const lightThemeBackgroundColor =
      Color.fromARGB(255, 169, 189, 217);
  static const lightThemeSecondaryColor =
      Color.fromARGB(246, 255, 255, 255);
  static const lightThemeTernaryColor =
      Color.fromARGB(255, 6, 102, 237);

  static const darkThemePrimaryColor = Colors.white;
  static const darkThemeBackgroundColor = Colors.black;
  static const darkThemeSecondaryColor =
      Color.fromARGB(79, 215, 212, 212);
  static const darkThemeTernaryColor =
      Color.fromARGB(255, 6, 102, 237);

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
          color: lightThemeTernaryColor,
          fontSize: 22,
        ),
      ),
      listTileTheme: const ListTileThemeData(
          textColor: lightThemePrimaryColor),
      drawerTheme: const DrawerThemeData(
        backgroundColor: lightThemeBackgroundColor,
      ),
      scaffoldBackgroundColor: lightThemeBackgroundColor,
      appBarTheme: const AppBarThemeData(
          backgroundColor: lightThemeBackgroundColor));

  static ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: darkThemeTernaryColor,
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
          color: darkThemeTernaryColor,
          fontSize: 22,
        ),
      ),
      listTileTheme: const ListTileThemeData(
          textColor: darkThemePrimaryColor),
      iconTheme:
          const IconThemeData(color: darkThemePrimaryColor),
      cardTheme: const CardThemeData(
        color: darkThemeSecondaryColor,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: darkThemeBackgroundColor,
      ),
      scaffoldBackgroundColor: darkThemeBackgroundColor,
      appBarTheme: const AppBarThemeData(
          backgroundColor: darkThemeBackgroundColor));
}
