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
      backgroundColor: const Color.fromARGB(255, 122, 152, 220),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          color: Color.fromARGB(139, 255, 255, 255),
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          hintText: 'Search for a city',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(139, 255, 255, 255),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(18, 255, 255, 255),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${weather!.temp}°',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 7 * 9,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              Text(
                                weather!.city,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 7 * 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                weather!.state,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 7 * 3,
                                  fontWeight: FontWeight.w200,
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: <Widget>[
                              Container(
                                // color: Colors.red,
                                width: 140,
                                height: 110,
                                child: Image.network(
                                  'http://cdn.weatherapi.com/weather/64x64/day/113.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                weather!.conditionText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 7 * 3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
