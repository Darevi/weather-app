// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, override_on_non_overriding_member, annotate_overrides, prefer_typing_uninitialized_variables, unused_local_variable, prefer_const_declarations, unnecessary_brace_in_string_interps

//This file is not currently connected to anything, this is just the code for my, David, original home screen
import 'dart:core';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'MainWidget.dart';
import 'tools/current_location.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

Future<WeatherInfo> fetchWeather() async {
  List<String> curr = await CurrentLocation.updatePosition() as List<String>; //Get the current location of the user
  String latitude = curr[0];
  String longitude = curr[1];
  log(curr[2]); //FOR DEBUGGING Print out the address information gathered by the app to the DegubConsole FOR DEBUGGING
  final cityName = "Yakima"; //Hardcoded city name to search the API with
  final apiKey = "01787ca7c37221e8632a2dab11901f4c";
  //final requestUrl = "https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${apiKey}"; //API CALL BY CITY NAME
  final requestUrl = "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}"; //API CALL BY LAT & LON

  final response = await http.get(Uri.parse(requestUrl));

  if(response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  }else {
    throw Exception("Error loading request URL info");
  }
}

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo({required this.location, required this.temp, required this.tempMin, required this.tempMax, required this.weather, required this.humidity, required this.windSpeed});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(location: json['name'], 
    temp: json['main']['temp'], 
    tempMin: json['main']['temp_min'], 
    tempMax: json['main']['temp_max'], 
    weather: json['weather'][0]['description'], 
    humidity: json['main']['humidity'], 
    windSpeed: json['wind']['speed']
    );
  }
}

void main() => runApp(MaterialApp(title: "WeatherApp", home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {

  late Future<WeatherInfo> futureWeather;
  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  var weatherIcon;
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherInfo>(
        future: futureWeather,
        builder:(context, snapshot) {
          if(snapshot.hasData) {
            return MainWidget(
              location: snapshot.data?.location,
              temp: snapshot.data?.temp,
              tempMin: snapshot.data?.tempMin,
              tempMax: snapshot.data?.tempMax,
              weather: snapshot.data?.weather,
              humidity: snapshot.data?.humidity,
              windSpeed: snapshot.data?.windSpeed
            );
          }else {
            return Center(
              child: Text("LOADING...",
              style: TextStyle(fontSize: 30.0, color: Colors.purple),
              ),
            );
          }
        }
      )
    );
  }
}
