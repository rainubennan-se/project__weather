import 'dart:convert';

import 'package:project__weather/model/weathermodel.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String baseurl = "https://api.openweathermap.org/data/2.5";
  static const String APIKEY = "3f2f59e05eadf86e2a929d6641824f52";
  static const String search =
      'https://api.openweathermap.org/data/2.5/weather';
  Future<WeatherModel> getWeather(double latitude, double longitude) async {
    try {
      final url =
          '$baseurl/weather?lat=$latitude&lon=$longitude&appid=$APIKEY&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // print(response.statusCode);
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<WeatherModel> searchWeather(String location) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$APIKEY&units=metric'));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to fetch climate data. Status code: ${response.statusCode}');
    }
  }
}
