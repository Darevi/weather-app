import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

// tiny class for keeping track of locations
class Location {
  String city;
  String state;
  String country;
  double lat;
  double lon;

  Location(this.city, this.state, this.country, this.lat, this.lon);
}