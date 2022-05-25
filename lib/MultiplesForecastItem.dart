import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MultiplesForecastData.dart';

class MultiplesForecastItem extends StatelessWidget {
  final MultiplesForecastData weather;

  const MultiplesForecastItem({Key? key, required this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Text(weather.location,
              style: const TextStyle(color: Colors.black, fontSize: 15.0)),
          Text(weather.weatherCondition,
              style: const TextStyle(color: Colors.black, fontSize: 15.0)),
          Text('${weather.temp.toString()}°F',
              style: const TextStyle(color: Colors.black)),
          Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
        ]),
      ),
    );
  }
}
