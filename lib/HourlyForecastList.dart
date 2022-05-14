import 'dart:convert';

import 'HourlyForecastData.dart';
import 'package:http/http.dart' as http;

class HourlyForecastList {
  List list;

  HourlyForecastList({required this.list});

  factory HourlyForecastList.fromJson(Map<String, dynamic> json) {
    List list = [];
    for (dynamic e in json['hourly']) {
      if (list.length <= 24) {
        HourlyForecastData forecast = HourlyForecastData(
            time: DateTime.fromMillisecondsSinceEpoch(e['dt'] * 1000,
                isUtc: false),
            temp: e['temp'].toInt(),
            condition: e['weather'][0]['main'],
            icon: e['weather'][0]['icon']);
        list.add(forecast);
      }
    }
    return HourlyForecastList(list: list);
  }
}
