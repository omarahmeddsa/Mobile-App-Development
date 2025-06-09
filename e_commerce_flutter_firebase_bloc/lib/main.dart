import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/logic/auth_cubit.dart';

import 'core/theme/dark_mode/dark_mode_data.dart';
import 'features/home/presentation/screens/signinscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        theme: darkModeData(),

        debugShowCheckedModeBanner: false,
        home: Signinscreen(),
      ),
    );
  }
}
