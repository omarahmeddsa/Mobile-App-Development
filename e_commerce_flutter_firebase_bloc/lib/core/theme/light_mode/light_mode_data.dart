import 'package:flutter/material.dart';

ThemeData darkModeData() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    hintColor: Colors.black54,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
