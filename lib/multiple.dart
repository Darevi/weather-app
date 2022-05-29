
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mock_weather/MultiplesForecastItem.dart';
import 'MultiplesForecastData.dart';
import 'locations.dart';

class Multiple extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MultipleState();
}

class _MultipleState extends State<Multiple> {
  //List of location(s).
  List<Location> locs = [
    Location(
        "Seattle", "", "", double.parse("47.608013"), double.parse("-122.335167"))
  ];

  //Method to iterate through the location list, which makes an API call for each location
  //..and adds each new MultiplesForecastData object to the list.
  static Future<List<MultiplesForecastData>> _getForecasts(
      List<Location> locations) async {
    List<MultiplesForecastData> forecasts = [];
    for (Location l in locations) {
      const apiKey = "01787ca7c37221e8632a2dab11901f4c";
      final requestUrl =
          "https://api.openweathermap.org/data/2.5/weather?lat=${l.lat}&lon=${l.lon}&units=imperial&appid=$apiKey";
      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        MultiplesForecastData newForecast =
        MultiplesForecastData.fromJson(jsonDecode(response.body));
        forecasts.add(newForecast);
      } else {
        throw Exception("Error loading request URL info");
      }
    }
    return forecasts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
        ),
        body: Container(
          child: FutureBuilder(
            future: _getForecasts(locs),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MultiplesForecastItem(
                          weather: snapshot.data.elementAt(index));
                    });
              }else {
                return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Loading...",
                          style: TextStyle(fontSize: 30.0, color: Colors.purple),
                        ),
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ));
              }
            },
          ),
        ));
  }
}

//Dummy class for the locations.
/*
  final String latitude;
  final String longitude;
  final String cityName;
  Location(
      {required this.latitude,
      required this.longitude,
      required this.cityName});
}*/

