part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherFetch extends WeatherEvent {
  Position position;
  WeatherFetch(this.position);

  List<Object?> get props => [position];
}
