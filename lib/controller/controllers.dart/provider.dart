import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project__weather/controller/service/weather_service.dart';
import 'package:project__weather/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;

  WeatherModel? get weather => _weather;

  Future<void> fetchWeather() async {
    print('Provider 00');
    try {
      print('Provider 11');
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        LocationPermission ask = await Geolocator.requestPermission();
      } else {
        Position currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        final latitude = currentPosition.latitude;

        final longitude = currentPosition.longitude;
        print(latitude);
        print(longitude);
        _weather = await WeatherService().getWeather(latitude, longitude);
        // print(_weather);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
