// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:sampleproject/tools/DailyWeatherData.dart';
import 'package:intl/intl.dart';
import 'DailyWeatherData.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';

class DailyWeatherItem extends StatelessWidget {
  final DailyWeatherData weather;
  WeatherType weather_bg = WeatherType.dusty;
  // ignore: prefer_const_constructors_in_immutables
  DailyWeatherItem({required this.weather});

  @override
  Widget build(BuildContext context) {
    //weatherBG if statements
    if(weather.main == "Clouds"){
      weather_bg = WeatherType.cloudy;
    }else if(weather.main == "Rain"){
      weather_bg = WeatherType.middleRainy;
    }else if(weather.main == "Clear"){
      weather_bg = WeatherType.sunny;
    }
    return Card(
      child: Stack(
        children: [
          WeatherBg(weatherType: weather_bg, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height/5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(DateFormat.E().format(weather.date),
                      style: new TextStyle(color: Colors.white, fontSize: 18.0)),
                  Text(weather.main,
                      style: new TextStyle(color: Colors.black, fontSize: 24.0)),
                  Text('${weather.temp.toString()}°F',
                      style: new TextStyle(color: Colors.black)),
                  Image.network(
                      'https://openweathermap.org/img/w/${weather.icon}.png'),
        ],
            ),
            ),
          ),
        ],
      ),
    );
  }
}
