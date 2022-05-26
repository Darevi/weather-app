import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:geolocator/geolocator.dart';
//import '../tools/DailyForecastData.dart';
import '../Homescreen.dart';

class weathers extends StatelessWidget {
  final city = ['Seattle', 'Madrid', 'Los Angeles', "Ellensburg"];
  final location;

  final longitudes = ['47.608013', '40.416775', '34.052235','46.9965'];
  final latitudes = ['-122.335167','-3.703790','-118.243398','-120.5478'];

 // final longitudes = ['47.608013', '40.416775', '34.052235', '6.9965144'];
  //final latitudes = ['-122.335167', '-3.703790', '-118.243398', '-120.5478474'];

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



 /* Future<Position> getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }


  void calculateDistance() async {

    getLocation().then((position) {
      userLocation = position;
    });

    final double myPositionLat =  userLocation.latitude;
    final double myPositionLong = userLocation.longitude;

    final double TPLat = 51.5148731;
    final double TPLong = -0.1923663;
    final distanceInMetres = await Geolocator().distanceBetween(myPositionLat, myPositionLong, TPLat, TPLong)/1000;

    print(distanceInMetres);

  }*/

  @override
  Widget build(BuildContext context) {
    //Decide the Icon to be displayed with the weather description
    //for (dynamic e in json['hourly']) {
     // icon: e['weather'][0]['icon']);
  //  }
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
                            fontSize: 50,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: "${city[index]} ${"  "}",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () =>{
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
                                  " ${degrees[index]} ${'°F                                                           '}",

                              /*recognizer: new TapGestureRecognizer()
                                ..onTap = ()  {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                        lon: '${longitudes[index]}',
                                        lat: '${latitudes[index]}',
                                        curr: false)), //Set to false
                                );
                              },*/

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
                      ' ${ degrees[index]} ${'°F'} '
                    '${Icons.cloud}',
                      style: TextStyle(fontSize: 30),

                      textAlign: TextAlign.center),*/
                      ));
            }));

    // );
  }
}
