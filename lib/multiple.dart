//import 'dart:html';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'tools/weather.dart';
//import 'package:weather/weather.dart';

Future<WeatherInfo> fetchWeather() async {
  final city = ['Seattle', 'Madrid', 'Los Angeles', "Ellensburg"];
  final apiKey = "01787ca7c37221e8632a2dab11901f4c";
  final requestUrl =
      "https://api.openweathermap.org/data/2.5/weather?q=${city[0]}&appid=${apiKey}";
  final requestMA =
      "https://api.openweathermap.org/data/2.5/weather?q=${city[1]}&appid=${apiKey}";
  final requestLA =
      "https://api.openweathermap.org/data/2.5/weather?q=${city[2]}&appid=${apiKey}";
  final requestE =
      "https://api.openweathermap.org/data/2.5/weather?q=${city[3]}&appid=${apiKey}";
  final response = await http.get(Uri.parse(requestUrl));
  final response1 = await http.get(Uri.parse(requestMA));
  final response2 = await http.get(Uri.parse(requestLA));
  final response3 = await http.get(Uri.parse(requestE));
  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(
        jsonDecode(response.body),
        jsonDecode(response1.body),
        jsonDecode(response2.body),
        jsonDecode(response3.body));
  } else {
    throw Exception("Error loading request URL info");
  }
}

class WeatherInfo {
  final city = ['Seattle', 'Madrid', 'Los Angeles', "Ellensburg"];
  final longitudes = ['47.608013', '40.416775', '-118.243398','-120.5478474'];
  final latitudes = ['-122.335167','-3.703790','34.052235','6.9965144'];
  final temp4;
  final temp3;
  final temp2;
  final location;
  final temp;
  final weather;
  WeatherInfo(
      {this.location,
      required this.temp,
      required this.weather,
      required this.temp2,
      required this.temp3,
      required this.temp4});
  factory WeatherInfo.fromJson(
      Map<String, dynamic> json, jsonDecode, jsonDecode2, jsonDecode3) {
    return WeatherInfo(
      location: json['name'],
      temp: json['main']['temp'],
      temp2: jsonDecode['main']['temp'],
      temp3: jsonDecode2['main']['temp'],
      temp4: jsonDecode3['main']['temp'],
      weather: json['weather'][0]['description'],
    );
  }
}

class Multi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return multiple();
  }
}

class multiple extends State<Multi> {
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
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: FutureBuilder<WeatherInfo>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return weathers(
                    temp4: snapshot.data?.temp4,
                    temp3: snapshot.data?.temp3,
                    temp2: snapshot.data?.temp2,
                    location: snapshot.data?.location,
                    temp: snapshot.data?.temp,
                    weather: snapshot.data?.weather);
              } else {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Loading...",
                        style: TextStyle(fontSize: 32.0, color: Colors.purple),
                      ),
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),

                );
              }
            }));
  }
}
