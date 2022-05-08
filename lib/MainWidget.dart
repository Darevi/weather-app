// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
//import 'weather_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainWidget extends StatelessWidget {
  final location;
  var temp;
  var tempMin;
  var tempMax;
  var weather;
  var humidity;
  final windSpeed;

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
    } else if (weather.contains("thunderstorm")) {
      weatherIcon = FontAwesomeIcons.cloudBolt;
    } else if (weather.contains("rain") || weather.contains("drizzle")) {
      weatherIcon = FontAwesomeIcons.cloudRain;
    } else if (weather.contains("snow")) {
      weatherIcon = FontAwesomeIcons.snowflake;
    } else {
      weatherIcon = Icons.cloud_outlined;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  //Name of town
                  "${location.toString()}",
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  //Temperature
                  "${temp.toInt().toString()}\u00B0",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                "${weather.toString()}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                //High and low temps
                "High of ${tempMax.toInt().toString()}\u00B0      Low of ${tempMin.toInt().toString()}\u00B0",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
