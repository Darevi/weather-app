// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, no_logic_in_create_state

import 'dart:convert';
//import 'dart:js';
//import 'dart:ffi';
import 'package:flutter/material.dart';
//import 'package:sampleproject/tools/DailyWeatherItem.dart';
//import 'package:sampleproject/tools/WeatherInfo.dart';
import 'package:http/http.dart' as http;
import 'package:mock_weather/HourlyForecastList.dart';
import 'package:weather/weather.dart';
//import 'package:geolocator/geolocator.dart';
//import '../tools/DailyForecastData.dart';
//import '../tools/DailyWeatherData.dart';
//import '../tools/MainWidget.dart';
import 'DailyForecastData.dart';
import 'DailyWeatherData.dart';
import 'DailyWeatherItem.dart';
import 'HourlyForecastItem.dart';
import 'MainWidget.dart';
import 'WeatherInfo.dart';
import 'tools/current_location.dart';
import 'HourlyForecastList.dart';

class HomeScreen extends StatefulWidget {
  
  String lon;
  String lat;
  bool curr;
  HomeScreen({Key? key, required this.lon, required this.lat, required this.curr }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState(lon, lat, curr);
  }
}

class HomeScreenState extends State<HomeScreen> {
 
  String lon;
  String lat;
  bool curr;
  HomeScreenState(this.lon, this.lat, this.curr);
  
  bool isLoading = false;
  late DailyWeatherData weatherData;
  DailyForecastData? forecast;
  HourlyForecastList? hourlyForecast;

  @override
  void initState() {
    super.initState();
    loadWeather(lon, lat, curr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.pushNamed(context, '/chi');
        },
        backgroundColor: Colors.blueAccent,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mult');
              },
              icon: Icon(Icons.list),
            )
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            FutureBuilder<WeatherInfo>(
                future: _search(lon, lat, curr),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MainWidget(
                        location: snapshot.data?.location,
                        temp: snapshot.data?.temp,
                        tempMin: snapshot.data?.tempMin,
                        tempMax: snapshot.data?.tempMax,
                        weather: snapshot.data?.weather,
                        humidity: snapshot.data?.humidity,
                        windSpeed: snapshot.data?.windSpeed);
                  } else {
                    return Center(
                      child: Text(
                        "LOADING...",
                        style: TextStyle(fontSize: 30.0, color: Colors.purple),
                      ),
                    );
                  }
                }),
            _hourlyForecast(),
            _dailyForecast(),
          ],
        ),
      )
    );
  }

  //List view for the hourly forecast.
  final times = ['12', '1', '2', '3', '4', '5', '6', '7', '8', '9', "10", '11'];
  _hourlyForecast() {
    /*
    return Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white),
            bottom: BorderSide(color: Colors.white),
          ),
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            itemBuilder: (context, index) {
              return Container(
                width: 50,
                child: Card(
                  child: Center(
                    child: Text('${times[index]}'),
                  ),
                ),
              );
            }));
         */

    return Container(
      height: 130,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white),
          bottom: BorderSide(color: Colors.white),
        ),
      ),
      child: hourlyForecast != null
          ? ListView.builder(
              itemCount: hourlyForecast?.list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => HourlyForecastItem(
                  weather: hourlyForecast?.list.elementAt(index)),
            )
          : Container(),
    );
  }

  //List view for the 7-day forecast.
  _dailyForecast() {
    return Expanded(
      child: SizedBox(
        height: 500.0,
        width: 300.0,
        // ignore: unnecessary_null_comparison
        child: forecast != null
            ? ListView.builder(
                itemCount: forecast?.list.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) =>
                    DailyWeatherItem(weather: forecast?.list.elementAt(index)),
              )
            : Container(),
      ),
    );
  }

  Future<WeatherInfo> _search(String lon, String lat, bool curr) {
    return WeatherInfo.fetchWeather(lon, lat, curr);
  }

//Method for the Daily Forecast
  loadWeather(String long, String lat, bool curr) async {
    setState(() {
      isLoading = true;
    });
    String latitude = '';
    String longitude = '';
    if(curr == true) {
      List<String> currPosition = await CurrentLocation.updatePosition() as List<String>; //Get the current location of the user
      latitude = currPosition[0];
      longitude = currPosition[1];
    }else {
      latitude = lon;
      longitude = lat;
    }
    final key = "ffa47a3d1aa0f5e91ff7fd8cb2356002";
    //final forecastURL =
    //"https://api.openweathermap.org/data/2.5/forecast?APPID=$key&lat=${lat.toString()}&lon=${lon.toString()}";
    final forecastURL =
        'https://api.openweathermap.org/data/2.5/onecall?lat=${latitude.toString()}&lon=${longitude.toString()}&exclude=minutely&appid=$key&units=imperial';
    final forecastResponse = await http.get(Uri.parse(forecastURL));

    if (forecastResponse.statusCode == 200) {
      return setState(() {
        forecast =
            DailyForecastData.fromJson(jsonDecode(forecastResponse.body));
        hourlyForecast =
            HourlyForecastList.fromJson(jsonDecode(forecastResponse.body));

        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  //setState(Null Function() param0) {}
}
