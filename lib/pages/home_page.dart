import 'package:flutter/material.dart';
import 'package:real_weather_app/models/weather.dart';
import 'package:real_weather_app/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  Weather? weather;
  WeatherService weatherService = WeatherService();

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  getWeatherData() async {
    weather = await weatherService.getWeather();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(),
    );
  }
}
