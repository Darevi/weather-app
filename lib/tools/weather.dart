import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Homescreen.dart';

class weathers extends StatelessWidget {
  final city = ['Seattle', 'Madrid', 'Los Angeles', "Ellensburg"];
  final location;
  final longitudes = ['47.608013', '40.416775', '34.052235', '6.9965144'];
  final latitudes = ['-122.335167', '-3.703790', '-118.243398', '-120.5478474'];
  var temp;
  var temp2;
  var temp3;
  var temp4;
  var weather;

  weathers({
    required this.temp4,
    required this.temp3,
    required this.temp2,
    required this.location,
    required this.temp,
    required this.weather,
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
    temp2 = (temp2 - 273.15) * (9 / 5) + 32;
    temp3 = (temp3 - 273.15) * (9 / 5) + 32;
    temp4 = (temp4 - 273.15) * (9 / 5) + 32;
    final degrees = [
      temp.toInt().toString(),
      temp2.toInt().toString(),
      temp3.toInt().toString(),
      temp4.toInt().toString()
    ];
    return Container(

        // children: [

        // Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: city.length,
            itemBuilder: (context, index) {
              return Container(
                  height: 170,
                  child: Card(
                      child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: "${city[index]} ${"  "}",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen(
                                                lon: '46.9965',
                                                lat: '-120.5478',
                                                curr: false)), //Set to false
                                      ),
                                    },
                            ),
                            TextSpan(
                              text:
                                  " ${degrees[index]} ${'??F                                                           '}",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen(
                                                lon: '46.9965',
                                                lat: '-120.5478',
                                                curr: false)), //Set to false
                                      ),
                                    },
                            ),
                            const WidgetSpan(
                              child: Icon(Icons.cloud, size: 60),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )

                      /* child: Text(

                    '${city[index] } ${ "  "}'
                      ' ${ degrees[index]} ${'??F'} '
                    '${Icons.cloud}',
                      style: TextStyle(fontSize: 30),

                      textAlign: TextAlign.center),*/
                      ));
            }));

    // );
  }
}
