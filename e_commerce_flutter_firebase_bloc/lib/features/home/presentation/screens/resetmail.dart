import 'package:flutter/material.dart';
import 'package:untitled/features/home/presentation/screens/signinscreen.dart';

class Resetmail extends StatelessWidget {
  const Resetmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 200),
          child: Column(
            children: [
              Image.asset(
                'lib/core/assets/images/sendmail.png',
                width: 200,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Icon(Icons.error, size: 50, color: Colors.red);
                },
              ),
              SizedBox(height: 20),
              Text(
                'We have sent you an Email to reset your password.',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  child: Text('Return to login'),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signinscreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
