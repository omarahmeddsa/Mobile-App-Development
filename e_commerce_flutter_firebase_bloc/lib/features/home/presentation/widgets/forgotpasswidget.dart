import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Forgotpasswidget extends StatelessWidget {
  Forgotpasswidget({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, size: 40),
        ),
      ),
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.only(top: 100, left: 15, right: 15),
              child: Column(
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else {
                        return null; // Add more validation logic if needed
                      }
                    },
                    decoration: InputDecoration(labelText: 'Enter your Email'),
                  ),
                  SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          // Handle sign-in logic here
                          if (kDebugMode) {
                            print('Sign In Successful');
                          }
                        } else {
                          if (kDebugMode) {
                            print('Validation Failed');
                          }
                        }
                      },
                      child: Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
