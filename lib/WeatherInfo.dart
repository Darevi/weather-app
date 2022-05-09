// ignore_for_file: prefer_const_declarations, unused_local_variable

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'tools/current_location.dart';
import 'dart:core';
import 'dart:developer';

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo(
      {this.location,
      this.temp,
      this.tempMin,
      this.tempMax,
      this.weather,
      this.humidity,
      this.windSpeed});

  //Appends the weather info from the json file from the weather API's responmse and
  //populates the required variables.
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        location: json['name'],
        temp: json['main']['temp'],
        tempMin: json['main']['temp_min'],
        tempMax: json['main']['temp_max'],
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed']);
  }
  //Network request to the weather API given the name of the city as a parameter.
  static Future<WeatherInfo> fetchWeather(city) async {
    
    List<String> curr = await CurrentLocation.updatePosition() as List<String>; //Get the current location of the user
    String latitude = curr[0];
    String longitude = curr[1];
    log(curr[2]); //FOR DEBUGGING Print out the address information gathered by the app to the DegubConsole FOR DEBUGGING
    
    final cityName = city; //Hardcoded city name to search the API with
    final apiKey = "01787ca7c37221e8632a2dab11901f4c";
    //final requestUrl = "https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${apiKey}"; //API CALL BY CITY NAME

    
    //                 !!!API CALL URL BY CURRENT LOCATION!!!
    final requestUrl = "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}"; //API CALL BY LAT & LON

    final response = await http.get(Uri.parse(requestUrl));

    if(response.statusCode == 200) {
      return WeatherInfo.fromJson(jsonDecode(response.body));
    }else {
      throw Exception("Error loading request URL info");
    }
  }
}
