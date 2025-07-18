import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_flutter/bloc/weather_bloc.dart';
import 'package:weather_bloc_flutter/screens/homescreen.dart';
import 'package:weather_bloc_flutter/service/locationrepo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: determinePosition(),
        builder: (context, snap) {
          if (snap.hasData) {
            return BlocProvider(
              create: (context) => WeatherBloc()..add(WeatherFetch(snap.data!)),
              child: HomeScreen(),
            );
          } else if (snap.hasError) {
            return Scaffold(
              appBar: AppBar(title: const Text("Error")),
              body: Center(
                child: Text(
                  snap.error.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            return Scaffold(
              appBar: AppBar(title: const Text("Unknown Error")),
              body: Center(
                child: const Text(
                  "An unknown error occurred.",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
