import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/logic/auth_cubit.dart';
import '../../../auth/logic/auth_state.dart';
import '../screens/signinscreen.dart';

class Signupwidget extends StatefulWidget {
  Signupwidget({super.key});

  @override
  State<Signupwidget> createState() => _SignupwidgetState();
}

class _SignupwidgetState extends State<Signupwidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _LastNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String email = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
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
                  padding: EdgeInsets.only(top: 120, left: 15, right: 15),
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your First Name';
                          } else {
                            return null; // Add more validation logic if needed
                          }
                        },
                        decoration: InputDecoration(labelText: 'First Name'),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _LastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Last Name';
                          } else {
                            return null; // Add more validation logic if needed
                          }
                        },
                        decoration: InputDecoration(labelText: 'Last Name'),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          } else {
                            return null; // Add more validation logic if needed
                          }
                        },
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        onChanged: (value) {
                          password = value;
                        },
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
                            if (formKey.currentState!.validate()) {
                              // Handle sign-in logic here
                              print({_emailController.text});
                              context.read<AuthCubit>().signUp(email, password);
                            }
                          },
                          child: Text('Sign Up'),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        child: Text('Already have an account?'),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signinscreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
