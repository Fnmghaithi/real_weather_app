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
  int currentHour = 0;
  var hour;
  var conditionIcon;
  var conditionText;
  var temp;

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  getWeatherData() async {
    weather = await weatherService.getWeather();
    currentHour = int.parse(weather!.date.split(' ')[1].split(':')[0]);
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
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  weather!.city,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 7 * 4,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${weather!.temp}°',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 7 * 9,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  weather!.conditionText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 7 * 4,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: weather!.forecast.length - 6 - 1,
                          itemBuilder: (context, index) {
                            hour = weather!.forecast[currentHour + index]
                                    ['time']
                                .split(' ')[1];
                            conditionIcon = weather!
                                .forecast[currentHour + index]['condition']
                                    ['icon']
                                .toString()
                                .replaceAll('//', 'http://');
                            conditionText =
                                weather!.forecast[currentHour + index]
                                    ['condition']['text'];
                            temp = weather!.forecast[currentHour + index]
                                ['temp_c'];
                            print(hour);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 7),
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(18, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      hour,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.network(
                                        conditionIcon,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      temp.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      conditionText,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(139, 255, 255, 255),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
