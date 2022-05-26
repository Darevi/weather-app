
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'locations.dart';
import 'jsonReader.dart';

class Screens extends StatelessWidget {
  final locations= [];
  final lat = [];
  final long=[];
  JsonReader reader = JsonReader();
  @override
  Widget build(BuildContext context) {


   return Scaffold(
     appBar: AppBar(
       title: new Center (child: new Text ('LOCATIONS')),
     automaticallyImplyLeading: true,
   ),
    body: Card(
    child: ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: locations.length,
    itemBuilder: (context, index) {
      _lonAndLat();
      return Card(

        child: Text('${locations[index]}  ')
      );

    }
    )
    )
   );

  }
  _lonAndLat() {
    for (int i = 0; i<= locations.length; i++) {
      Location selectedLoc = searchLoc(reader.locationList, locations[i]);
      lat[i].add(selectedLoc.lat) ;
      long[i].add(selectedLoc.lon) ;
    }
  }
  Location searchLoc(List<Location> locationList, String loc) {
    // turns loc string into substrings with city, state, country
    int start = 0;
    int end = loc.indexOf(',', start);

    String city = loc.substring(start,end);

    start = end + 2;
    end = loc.indexOf(',', start);

    String state = loc.substring(start, end);

    start = end + 2;

    String country = loc.substring(start);

    // compares city, state, country substrings with counter parts in locationList
    for (int i = 0; i < locationList.length; i++) {
      if (locationList[i].city == city && locationList[i].state == state && locationList[i].country == country) {
        // returns specific location if successful
        return locationList[i];
      }
    }
    // this should hopefully never happen
    debugPrint("no location found, this shouldn't happen.");
    return locationList[0];
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('lat', lat));
  }
  }






