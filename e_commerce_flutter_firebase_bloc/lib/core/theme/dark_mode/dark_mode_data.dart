import 'package:flutter/material.dart';

import 'dark_mode_color.dart';

ThemeData darkModeData() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: DarkModeColor().primaryColor,
    hintColor: DarkModeColor().hintColor,
    scaffoldBackgroundColor: DarkModeColor().scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: DarkModeColor().appBarBackgroundColor,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 17),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 40),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey[800],
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: DarkModeColor().bodyTextColor,
        backgroundColor: DarkModeColor().buttonColor,
        textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DarkModeColor().TextFieldColor,
      labelStyle: TextStyle(color: Colors.white),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,

      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      errorStyle: TextStyle(fontSize: 16),
    ),
  );
}
