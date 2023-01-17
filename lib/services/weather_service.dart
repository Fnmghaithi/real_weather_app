import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:real_weather_app/models/weather.dart';

class WeatherService {
  Future<Weather?> getWeather() async {
    try {
      Uri url = Uri.parse(
          'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$cityName&days=1&aqi=no&alerts=no');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
  }
}

const String apiKey = '585c7cc769444576a65131514230401';
const String cityName = 'Los Angeles';
