// ignore_for_file: unnecessary_new
import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'package:sampleproject/tools/DailyForecastData.dart';

//import 'package:sampleproject/tools/DailyWeatherData.dart';
//import 'package:sampleproject/tools/WeatherInfo.dart';

import 'DailyWeatherData.dart';

class DailyForecastData {
  final List list;

  DailyForecastData({required this.list});

  factory DailyForecastData.fromJson(Map<String, dynamic> json) {
    List list = [];

    for (dynamic e in json['daily']) {
      DailyWeatherData w = new DailyWeatherData(
          date: new DateTime.fromMillisecondsSinceEpoch(e['dt'] * 1000,
              isUtc: false),
          temp: e['temp']['max'].toInt(),
          main: e['weather'][0]['main'],
          icon: e['weather'][0]['icon']);
      list.add(w);
    }

    return DailyForecastData(
      list: list,
    );
  }

  static Future<DailyForecastData> fetchDailyWeather(
      latitude, longitude) async {
    final lat = latitude;
    final long = longitude;

    const key = "ffa47a3d1aa0f5e91ff7fd8cb2356002";

    final response =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&appid=$key";

    final forecastResponse = await http.get(Uri.parse(response));

    if (forecastResponse.statusCode == 200) {
      return new DailyForecastData.fromJson(jsonDecode(forecastResponse.body));
    } else {
      throw Exception("Error loading request URL info");
    }
  }
}
