import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../screens/signupscreen.dart';
import 'forgotpasswidget.dart';

class Signinwidget extends StatelessWidget {
  Signinwidget({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.only(top: 100, left: 15, right: 15),
              child: Column(
                children: [
                  Text(
                    'Sign In',
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
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Please enter your password'
                                : null, // Add more validation logic if needed
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 35),
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
                      child: Text('Sign In'),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    child: Text('Don\'t have an account?'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signupscreen()),
                      );
                    },
                  ),
                  TextButton(
                    child: Text('Forgot Password?'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Forgotpasswidget(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 35),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(52, 47, 63, 1),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.mail, size: 45),
                          SizedBox(width: 35),
                          Text(
                            'Continue with Google',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(52, 47, 63, 1),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.facebook_sharp, size: 40),
                          SizedBox(width: 35),
                          Text(
                            'Continue with FaceBook',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
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
