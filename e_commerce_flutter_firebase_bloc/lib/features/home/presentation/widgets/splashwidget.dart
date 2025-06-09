import 'package:flutter/material.dart';

class splashwidget extends StatelessWidget {
  const splashwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBB86FC),
      body: Center(
        child: Text(
          'Digital',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Digitalfont',
          ),
        ),
      ),
    );
  }
}
