import 'package:flutter/material.dart';
import 'package:project__weather/controller/service/weather_service.dart';
import 'package:project__weather/model/weather_model.dart';

class SearchProvider with ChangeNotifier {
  WeatherModel? _weatherModel;
  WeatherModel? get weatherModel => _weatherModel;
  Future<void> searchweather(String location) async {
    try {
      print('111');
      _weatherModel = await WeatherService().searchWeather(location);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
