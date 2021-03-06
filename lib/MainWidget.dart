// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'tools/weather_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';

class MainWidget extends StatelessWidget {
  final location;
  var temp;
  var tempMin;
  var tempMax;
  var weather;
  var humidity;
  final windSpeed;
  WeatherType weather_bg = WeatherType.lightSnow;

  MainWidget({
    this.location,
    this.temp,
    this.tempMin,
    this.tempMax,
    this.weather,
    this.humidity,
    this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    //Decide the Icon to be displayed with the weather description
    IconData weatherIcon;
    if (weather.contains("clear") || weather.contains("few")) {
      weatherIcon = Icons.wb_sunny_outlined;
      weather_bg = WeatherType.sunny;
    } else if (weather.contains("thunderstorm")) {
      weatherIcon = FontAwesomeIcons.cloudBolt;
      weather_bg = WeatherType.thunder;
    } else if (weather.contains("rain") || weather.contains("drizzle")) {
      weatherIcon = FontAwesomeIcons.cloudRain;
      weather_bg = WeatherType.lightRainy;
    } else if (weather.contains("snow")) {
      weatherIcon = FontAwesomeIcons.snowflake;
      weather_bg = WeatherType.lightSnow;
    } else {
      weatherIcon = Icons.cloud_outlined;
      weather_bg = WeatherType.sunny;
      if(weather.contains("overcast")){
        weather_bg = WeatherType.overcast;
      }else if(weather.contains("clouds")){
        weather_bg = WeatherType.cloudy;
      }else if(weather.contains("fog")||weather.contains("mist")){
        weather_bg = WeatherType.foggy;
      }
    }

    //Convert temp from Kelvin to F
    temp = (temp - 273.15) * (9 / 5) + 32;
    tempMin = (tempMin - 273.15) * (9 / 5) + 32;
    tempMax = (tempMax - 273.15) * (9 / 5) + 32;

    return Column(
      children: [
        Container(
          //Top portion of the page
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey, //Background
          child: Stack(
              children: [
                WeatherBg(weatherType: weather_bg, width:MediaQuery.of(context).size.width , height: MediaQuery.of(context).size.height / 2),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: InkWell(
                    child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          //Name of town

                            "${location.toString()}",
                            style:
                            TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900,
                                shadows: [
                                Shadow(
                                offset: Offset(2.0, 2.0), //position of shadow
                                blurRadius: 6.0, //blur intensity of shadow
                                color: Colors.black.withOpacity(0.8), //color of shadow with opacity
                                ),]
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            //Temperature
                            "${temp.toInt().toString()}\u00B0",
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                        Text(
                          "${weather.toString()}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0), //position of shadow
                                blurRadius: 6.0, //blur intensity of shadow
                                color: Colors.black.withOpacity(0.8), //color of shadow with opacity
                              ),]
                          ),
                        ),
                        Text(
                          //High and low temps
                          "High of ${tempMax.toInt().toString()}\u00B0      Low of ${tempMin.toInt().toString()}\u00B0",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                  Shadow(
                                  offset: Offset(2.0, 2.0), //position of shadow
                                  blurRadius: 6.0, //blur intensity of shadow
                                  color: Colors.black.withOpacity(0.8), //color of shadow with opacity
                                  ),]
                          ),
                        ),
                      ],
                    ),
    ),
                  )
              ),
    ],
    )

        ),
        Column(children: [
          //WeatherTile(icon: weatherIcon, title: "Weather", subTitle: "${weather.toString()}"),
          WeatherTile(
              icon: Icons.water_drop,
              title: "Humidity",
              subTitle: "${humidity.toString()}%"),
          WeatherTile(
              icon: Icons.air_outlined,
              title: "Wind Speed",
              subTitle: "${windSpeed.toInt().toString()} MPH"),
        ])
      ],
    );
  }
}
