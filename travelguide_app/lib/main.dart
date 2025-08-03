import 'package:flutter/material.dart';
import 'package:travelguide_app/screens/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: '',
        elevatedButtonTheme: ElevatedButtonThemeData(),
      ),
      debugShowCheckedModeBanner: false,
      home: signin(),
    );
  }
}
