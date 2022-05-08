import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo(
      {this.location,
      this.temp,
      this.tempMin,
      this.tempMax,
      this.weather,
      this.humidity,
      this.windSpeed});

  //Appends the weather info from the json file from the weather API's responmse and
  //populates the required variables.
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        location: json['name'],
        temp: json['main']['temp'],
        tempMin: json['main']['temp_min'],
        tempMax: json['main']['temp_max'],
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed']);
  }
  //Network request to the weather API given the name of the city as a parameter.
  static Future<WeatherInfo> fetchWeather(city) async {
    // ignore: prefer_const_declarations
    final cityName = city;
    const apiKey = "01787ca7c37221e8632a2dab11901f4c";
    final requestUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey";

    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      return WeatherInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error loading request URL info");
    }
  }
}
