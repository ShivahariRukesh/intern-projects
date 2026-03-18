import 'package:flutter/material.dart';

class AppColor {
  static const darkThemePrimaryColor = Color.fromARGB(
    255,
    178,
    156,
    45,
  );
  static const darkThemeSecondaryColor = Color.fromARGB(
    255,
    89,
    89,
    89,
  );

  static const darkThemeBackgroundColor = Colors.black;

  static const lightThemePrimaryColor = Colors.black;
  static const lightThemeSecondaryColor = Color.fromARGB(
    255,
    191,
    186,
    186,
  );
  static const lightThemeBackgroundColor = Colors.white;
}

final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: AppColor.lightThemePrimaryColor,

  colorScheme: ThemeData.light().colorScheme.copyWith(
    secondary: AppColor.lightThemeSecondaryColor,
  ),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(
        selectedItemColor: AppColor.lightThemePrimaryColor,
        unselectedItemColor:
            AppColor.lightThemeSecondaryColor,
        type: BottomNavigationBarType.fixed,
      ),

  listTileTheme: ListTileThemeData(
    tileColor: AppColor.lightThemeSecondaryColor,
    textColor: AppColor.lightThemePrimaryColor,
    iconColor: AppColor.lightThemePrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: AppColor.darkThemePrimaryColor,

  colorScheme: ThemeData.dark().colorScheme.copyWith(
    secondary: AppColor.darkThemeSecondaryColor,
  ),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(
        backgroundColor: AppColor.darkThemeBackgroundColor,
        selectedItemColor: AppColor.darkThemePrimaryColor,
        unselectedItemColor:
            AppColor.darkThemeSecondaryColor,
        type: BottomNavigationBarType.fixed,
      ),

  listTileTheme: ListTileThemeData(
    tileColor: AppColor.darkThemeSecondaryColor,
    textColor: AppColor.darkThemePrimaryColor,
    iconColor: AppColor.darkThemePrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
