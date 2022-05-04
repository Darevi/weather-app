// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  IconData icon;
  String title;
  String subTitle;

  WeatherTile({required this.icon, required this.title, required this.subTitle}); //Constructor, what must be passed to the class
  @override

  Widget build(BuildContext context) {
    return
      ListTile( //Return a list tile with the attributes for a column
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.purple) //Icon for the column ex(cloud symbol)
          ],
        ),
        title: Text( //Main part of the column ex("Weather")
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        subtitle: Text( //Sub part of the column ex("Clear Sky")
          subTitle,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xff9e9e9e)),
        ),
      );
  }
}