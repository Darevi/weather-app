// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:sampleproject/tools/DailyWeatherData.dart';

import 'DailyWeatherData.dart';

class DailyWeatherItem extends StatelessWidget {
  final DailyWeatherData weather;

  // ignore: prefer_const_constructors_in_immutables
  DailyWeatherItem({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Text(weather.name,
              //style: new TextStyle(color: Colors.black, fontSize: 24.0)),
              Text(weather.main,
                  style: new TextStyle(color: Colors.black, fontSize: 24.0)),
              Text('${weather.temp.toString()}°F',
                  style: new TextStyle(color: Colors.black)),
              Image.network(
                  'https://openweathermap.org/img/w/${weather.icon}.png'),
            ]),
      ),
    );
  }
}
