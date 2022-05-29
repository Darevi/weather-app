import 'dart:convert';
import 'package:http/http.dart' as http;

class MultiplesForecastData {
  final int temp;
  final String weatherCondition;
  final String icon;
  final String location;

  MultiplesForecastData(
      {required this.temp,
      required this.weatherCondition,
      required this.icon,
      required this.location});

  factory MultiplesForecastData.fromJson(Map<String, dynamic> json) {
    return MultiplesForecastData(
      location: json['name'],
      temp: json['main']['temp'].toInt(),
      weatherCondition: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }

  static Future<MultiplesForecastData> fetchWeather(
      String long, String lat, bool curr) async {
    String latitude = lat;
    String longitude = long;
    final apiKey = "01787ca7c37221e8632a2dab11901f4c";
    final requestUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}";
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      return MultiplesForecastData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error loading request URL info");
    }
  }
}
