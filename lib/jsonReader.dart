import 'locations.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class JsonReader {
  List<Location> locationList = <Location>[];
  List<String> locationStringList = <String>[];

  Future<void> readJson() async {
    final String cityString = await rootBundle.loadString('assets/cities.json');
    final List list = json.decode(cityString) as List<dynamic>;


    for (int i = 0; i < list.length; i++) {
      final tempItem = list[i];

      Location temp = Location(tempItem['name'], tempItem['state_name'], tempItem['country_name'], double.parse(tempItem['latitude']), double.parse(tempItem['longitude']));
      locationList.add(temp);
      locationStringList.add(tempItem['name'] + ", " + tempItem['state_name'] + ", " + tempItem['country_name']);
    }
  }
}


