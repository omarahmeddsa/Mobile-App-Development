import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherFetch>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherFactory wf = WeatherFactory(
          "e366aac4ea9f270a77ad47841993e44a",
          language: Language.ENGLISH,
        );
        Position position = await Geolocator.getCurrentPosition();
        Weather weather = await wf.currentWeatherByLocation(
          position.latitude,
          position.longitude,
        );
        emit(WeatherSucess(weather));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
  }
}
