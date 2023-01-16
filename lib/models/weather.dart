class Weather {
  final double temp;
  final String city;
  final String state;
  final String date;
  final String conditionText;
  final String conditionIcon;
  final String humidity;
  final String uv;
  final String wind;
  final List forecast;

  Weather({
    required this.temp,
    required this.city,
    required this.state,
    required this.date,
    required this.conditionText,
    required this.conditionIcon,
    required this.humidity,
    required this.uv,
    required this.wind,
    required this.forecast,
  });

  factory Weather.fromJson(json) {
    return Weather(
      temp: json['current']['temp_c'],
      city: json['location']['name'],
      state: json['location']['region'],
      date: json['location']['localtime'],
      conditionText: json['current']['condition']['text'],
      conditionIcon: json['current']['condition']['icon'],
      humidity: json['current']['humidity'],
      uv: json['current']['uv'],
      wind: json['current']['wind_kph'],
      forecast: json['forecast']['forecastday'][0]['hour'],
    );
  }
}
