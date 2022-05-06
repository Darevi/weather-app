import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';

// hello there

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
  child:
        Icon(Icons.search),
          onPressed:(){

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
          ]
          /*childrens: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mult');
              },
              icon: Icon(Icons.list),
            )
          ],*/


        ),
      ),
      body: Column(
        children: [
          _hourlyForecast(),
          _dailyForecast(),
        ],

      ),
    );
  }

  final times = ['12', '1', '2', '3', '4', '5', '6', '7', '8', '9', "10", '11'];
  _hourlyForecast() {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images\clear.png'),
            fit: BoxFit.cover,


            ),
          ),

        margin: const EdgeInsets.only(top: 200.0),
        height: 100,



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
  }

  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  _dailyForecast() {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: days.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                child: Card(
                  child: Center(
                    child: Text('${days[index]}'),
                  ),
                ),
              );
            }));
  }

  late Position currentPosition;
  var geoLocator = Geolocator();

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    return currentPosition;
  }

  Future<double?> getWeatherForLocation() async {
    Position curPos = getCurrentLocation();
    double latitude = curPos.latitude;
    double longitude = curPos.longitude;
    const apiKey = 'ffa47a3d1aa0f5e91ff7fd8cb2356002';
    WeatherFactory wf = WeatherFactory(apiKey);
    Weather w = await wf.currentWeatherByLocation(latitude, longitude);
    int temp = w.temperature?.fahrenheit as int;
  }
}
