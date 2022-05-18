import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'HourlyForecastData.dart';

class HourlyForecastItem extends StatelessWidget {
  final HourlyForecastData weather;

  const HourlyForecastItem({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Text(DateFormat.j().format(weather.time),
              style: const TextStyle(color: Colors.white, fontSize: 10.0)),
          Text(weather.condition,
              style: const TextStyle(color: Colors.black, fontSize: 15.0)),
          Text('${weather.temp.toString()}°F',
              style: const TextStyle(color: Colors.black)),
          Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
        ]),
      ),
    );
  }
}
