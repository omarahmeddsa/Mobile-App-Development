import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app/Homepage.dart';
import 'package:todoapp/app/SignIn.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/provider/Auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Auth_Provider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return mainWidget(context);
  }
}

Widget mainWidget(BuildContext context) {
  final authProvider = Provider.of<Auth_Provider>(context);
  Widget widget = Scaffold();
  if (authProvider.authState == AuthState.loggedIn) {
    print('${authProvider.authState}');
    widget = MaterialApp(debugShowCheckedModeBanner: false, home: Homepage());
  } else {
    print('${authProvider.authState}');
    widget = MaterialApp(debugShowCheckedModeBanner: false, home: Signin());
  }
  return widget;
}
