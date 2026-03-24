import 'package:flutter/material.dart';

/// A centralized class that holds all color constants
/// used throughout the application for both light and dark themes.
///
/// This helps maintain consistency and makes it easier
/// to update colors in one place.
class AppColor {
  // Dark Theme Colors
  /// Primary color used in dark theme (main accents, highlights)
  static const Color darkThemePrimaryColor = Color.fromARGB(
    255,
    178,
    156,
    45,
  );

  /// Secondary color used in dark theme (inactive elements, tiles, etc.)
  static const Color darkThemeSecondaryColor =
      Color.fromARGB(255, 89, 89, 89);

  /// Background color for dark theme screens
  static const Color darkThemeBackgroundColor =
      Colors.black;

  // Light Theme Colors
  /// Primary color used in light theme (main text, icons)
  static const Color lightThemePrimaryColor = Colors.black;

  /// Secondary color used in light theme (subtle UI elements)
  static const Color lightThemeSecondaryColor =
      Color.fromARGB(255, 191, 186, 186);

  /// Background color for light theme screens
  static const Color lightThemeBackgroundColor =
      Colors.white;
}

/// Light Theme Configuration
///
/// This defines the visual styling for the app when
/// running in light mode.
final ThemeData lightTheme = ThemeData.light().copyWith(
  /// Primary color used across the app
  primaryColor: AppColor.lightThemePrimaryColor,

  /// Custom color scheme adjustments
  colorScheme: ThemeData.light().colorScheme.copyWith(
    /// Secondary color used for accents and highlights
    secondary: AppColor.lightThemeSecondaryColor,
  ),

  /// Floating Action Button styling
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(
        backgroundColor: AppColor.lightThemeSecondaryColor,
      ),

  /// Global text styling for the app
  textTheme: const TextTheme(
    /// Medium display text (e.g., section titles)
    displayMedium: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),

    /// Smaller display text
    displaySmall: TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),

    /// Small body text
    bodySmall: TextStyle(
      fontSize: 14,
      color: AppColor.lightThemePrimaryColor,
    ),

    /// Default body text
    bodyMedium: TextStyle(
      fontSize: 18,
      color: AppColor.lightThemePrimaryColor,
    ),
  ),

  /// Bottom navigation bar styling
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(
        /// Color for selected item
        selectedItemColor: AppColor.lightThemePrimaryColor,

        /// Color for unselected items
        unselectedItemColor:
            AppColor.lightThemeSecondaryColor,

        /// Fixes shifting behavior
        type: BottomNavigationBarType.fixed,
      ),

  /// ListTile styling (used in lists, menus, etc.)
  listTileTheme: ListTileThemeData(
    /// Background color of each tile
    tileColor: AppColor.lightThemeSecondaryColor,

    /// Text color inside tiles
    textColor: AppColor.lightThemePrimaryColor,

    /// Icon color inside tiles
    iconColor: AppColor.lightThemePrimaryColor,

    /// Rounded corners for tiles
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

/// Dark Theme Configuration
///
/// This defines the visual styling for the app when
/// running in dark mode.
final ThemeData darkTheme = ThemeData.dark().copyWith(
  /// Primary color used across the app
  primaryColor: AppColor.darkThemePrimaryColor,

  /// Custom color scheme adjustments
  colorScheme: ThemeData.dark().colorScheme.copyWith(
    /// Secondary color for accents
    secondary: AppColor.darkThemeSecondaryColor,
    surface: AppColor.darkThemeBackgroundColor,
  ),

  /// Floating Action Button styling
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(
        backgroundColor: AppColor.darkThemePrimaryColor,
      ),

  /// Global text styling
  textTheme: const TextTheme(
    /// Medium display text
    displayMedium: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),

    /// Small display text
    displaySmall: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),

    /// Small body text
    bodySmall: TextStyle(
      fontSize: 14,
      color: AppColor.darkThemePrimaryColor,
    ),

    /// Default body text
    bodyMedium: TextStyle(
      fontSize: 18,
      color: AppColor.darkThemePrimaryColor,
    ),

    /// Large body text
    bodyLarge: TextStyle(
      fontSize: 20,
      color: AppColor.darkThemePrimaryColor,
    ),
  ),

  /// Bottom navigation bar styling
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(
        /// Background color of the bar
        backgroundColor: AppColor.darkThemeBackgroundColor,

        /// Selected item color
        selectedItemColor: AppColor.darkThemePrimaryColor,

        /// Unselected item color
        unselectedItemColor:
            AppColor.darkThemeSecondaryColor,

        /// Prevents shifting animation
        type: BottomNavigationBarType.fixed,
      ),

  /// ListTile styling
  listTileTheme: ListTileThemeData(
    /// Tile background color
    tileColor: AppColor.darkThemeSecondaryColor,

    /// Text color inside tile
    textColor: AppColor.darkThemePrimaryColor,

    /// Icon color inside tile
    iconColor: AppColor.darkThemePrimaryColor,

    /// Rounded tile corners
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),

  /// Card styling (used for elevated surfaces)
  cardTheme: CardThemeData(
    /// Shadow color for cards
    shadowColor: AppColor.darkThemePrimaryColor.withValues(
      alpha: 0.8,
    ),
  ),

  /// Input field styling (TextField, TextFormField)
  inputDecorationTheme: const InputDecorationThemeData(
    /// Color of prefix icons
    prefixIconColor: AppColor.darkThemePrimaryColor,

    /// Background fill color of input fields
    fillColor: Colors.white70,
  ),

  /// Default icon styling across the app
  iconTheme: const IconThemeData(
    color: AppColor.darkThemePrimaryColor,
    size: 20,
  ),
);
