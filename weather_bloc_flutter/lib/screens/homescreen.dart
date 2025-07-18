import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/weather_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, kToolbarHeight * 1.2, 40, 20),

        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherFailure) {
              return const Center(
                child: Text(
                  'Failed to load weather data',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            } else if (state is WeatherSucess) {
              final weather = state.weather;
              // You can use the weather data here
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -1.4),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 150, sigmaY: 120),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍 ${weather.areaName}, ${weather.country}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: 10),
                          Text(
                            'Good Morning',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Image.asset('lib/assets/2.png'),
                          Center(
                            child: Text(
                              '${weather.temperature!.celsius!.toStringAsFixed(1)}° C',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 55,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              weather.weatherMain!.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat(
                                'EEEE dd .',
                              ).add_jm().format(weather.date!),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),

                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('lib/assets/6.png', scale: 8),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        'Sunrise',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        DateFormat().add_jm().format(
                                          weather.sunrise!,
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset('lib/assets/12.png', scale: 8),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        'Sunset',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        DateFormat().add_jm().format(
                                          weather.sunset!,
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Divider(color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('lib/assets/13.png', scale: 8),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        'Temp max',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        '${weather.tempMax!.celsius!.round()} ° C',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset('lib/assets/14.png', scale: 8),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        'Temp min',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        '${weather.tempMin!.celsius!.round()} ° C',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text(
                'Unknown state',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          },
        ),
      ),
    );
  }
}
