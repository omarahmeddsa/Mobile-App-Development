import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/data/authbase.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../screens/signupscreen.dart';
import 'forgotpasswidget.dart';

class signinwidget extends StatelessWidget {
  signinwidget({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    authbase UserInstance = authbase(email: email, password: password);

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
                    onChanged: (value) => email = value,

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
                    onChanged: (value) => password = value,
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
                      onPressed: () async {
                        // await UserInstance.signIn(UserInstance.email, UserInstance.password);
                        if (formKey.currentState!.validate()) {
                          // Handle sign-in logic here
                          context.read<AuthCubit>().signIn(email, password);
                          print({UserInstance.status});
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
