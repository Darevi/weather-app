import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


class Location {
  String city;
  String state;
  String country;
  double lat;
  double lon;

  Location(this.city, this.state, this.country, this.lat, this.lon);

  String createString() {
    return "";
  }

  Location.fromJson(dynamic json)
      : city = json['name'] as String,
        state = json['state_name'] as String,
        country = json['county_name'] as String,
        lat = json['latitude'] as double,
        lon = json['longitude'] as double;
}