import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MultiplesForecastData.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';

class MultiplesForecastItem extends StatelessWidget {
  final MultiplesForecastData weather;

  const MultiplesForecastItem({Key? key, required this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherType weather_bg = WeatherType.lightSnow;

    if(weather.weatherCondition.contains("clear")){
      weather_bg = WeatherType.sunny;
    }else if(weather.weatherCondition.contains("snow")){
      weather_bg = WeatherType.middleSnow;
    }else if(weather.weatherCondition.contains("mist")){
      weather_bg = WeatherType.foggy;
    }else if(weather.weatherCondition.contains("clouds")){
      weather_bg = WeatherType.cloudy;
    }else if(weather.weatherCondition.contains("")){
      weather_bg = WeatherType.foggy;
    }else{
      weather_bg = WeatherType.sunny;
    }
    return Card(
      child: Stack(
        children: [
          WeatherBg(weatherType: weather_bg, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height/4),
          Padding(
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
        ],
      ),
    );
  }
}
