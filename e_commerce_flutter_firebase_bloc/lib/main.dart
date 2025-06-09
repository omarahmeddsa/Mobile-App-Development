import 'package:flutter/material.dart';

import 'core/theme/dark_mode/dark_mode_data.dart';
import 'features/home/presentation/screens/signinscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkModeData(),

      debugShowCheckedModeBanner: false,
      home: Signinscreen(),
    );
  }
}
