import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:project__weather/controller/service/weather_service.dart';
import 'package:project__weather/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;

  WeatherModel? get weather => _weather;
  bool isloading = false;
  String error = '';
  double? lat;
  double? lon;
  Future<void> fetchWeather(
      // double latitude, double longitude
      ) async {
    print('Provider 00');
    try {
      isloading = true;
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
        // print(latitude);
        // print(longitude);
        lat = latitude;
        lon = longitude;
        _weather = await WeatherService().getWeather(latitude, longitude);
        // print(_weather);
        isloading = false;
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      print(e);
    }
  }
}
