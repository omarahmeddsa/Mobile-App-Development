import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_bloc_flutter_app/screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(future: determinePosition(), builder: ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(future: determinePosition(), builder: builder),
    );
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled
    return Future.error('Location services are disabled.');
  }

  // Check permission status
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are permanently denied
    return Future.error('Location permissions are permanently denied.');
  }

  // If all is good, get the position
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
