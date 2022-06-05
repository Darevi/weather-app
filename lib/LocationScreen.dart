// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state, dead_code, use_key_in_widget_constructors, must_be_immutable, prefer_const_declarations
//mport 'dart:io';
//import 'dart:js';

import 'package:mock_weather/Homescreen.dart';

//import 'jsonReader.dart';
import 'locations.dart';
import 'main.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:flutter/material.dart';
import 'package:mock_weather/MultiplesForecastItem.dart';
import 'MultiplesForecastData.dart';
//import 'multiple.dart';
import 'tools/current_location.dart';

// hello there
//theoretically I think this is public and
//can be accessed from anywhere in the app
String locToSearch = " ";

class LocationScreenState extends State<LocationScreen> {
  getCityName(String latitude, String longitude) async {
    final apiKey = "01787ca7c37221e8632a2dab11901f4c";
    final requestUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}";
    final VoidCallback onDelete;
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['name'];
    } else {
      throw Exception("Error loading request URL info");
    }
  }

  currWeather() async {
    List<String> currData =
        await CurrentLocation.updatePosition() as List<String>;
    String cityName = await getCityName(currData[0], currData[1]);
    locs.add(Location(cityName, "", "", double.parse(currData[0]),
        double.parse(currData[1])));
  }

//Method to add a forecast to the user's favorites list. The list's length tops out at 11 locations. If the user reaches
// the allotted amount of locations and wishes to add another, then they will have to delete one of the existing locations.
  static _addForecast(Location location) {
    if (!locs.contains(location)) {
      locs.add(location);
    }
    //Need to add a dialog box here for when the maximum length is reached
    //Also need a way to conveniently delete a selected location.
  }

  static List<Location> locs = [
    Location("New York", "", "", 40.7128, -74.0060),
    Location("London", "", "", 51.5072, -0.1276),
    Location("Tokyo", "", "", 35.6762, 139.6503)
  ];

  static Future<List<MultiplesForecastData>> _getForecasts(
      List<Location> locations) async {
    List<MultiplesForecastData> forecasts = [];
    for (int i = 0; i < locations.length; i++) {
      Location l = locations[i];
      const apiKey = "01787ca7c37221e8632a2dab11901f4c";
      final requestUrl =
          "https://api.openweathermap.org/data/2.5/weather?lat=${l.lat}&lon=${l.lon}&units=imperial&appid=$apiKey";
      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        MultiplesForecastData newForecast =
            MultiplesForecastData.fromJson(jsonDecode(response.body));
        forecasts.add(newForecast);
      } else {
        throw Exception("Error loading request URL info");
      }
    }
    return forecasts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        //using sliver app bar for looking nice, usually used for custom scroll view
        //https://api.flutter.dev/flutter/material/SliverAppBar-class.html
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,

            //top title
            title: Text('Search for a location:'),
            actions: [
              IconButton(
                icon: Icon(Icons.my_location),
                tooltip: 'search for your current location',
                //to get current location
                onPressed: () {
                  //When the my_location icon is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                            lon: '',
                            lat: '',
                            curr:
                                true)), //Because curr is set to true it will get current location
                  );
                },
              ),
            ],

            bottom: AppBar(
              //back button gone
              automaticallyImplyLeading: false,

              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  //this is the search bar displayed code
                  child: AutocompleteLocation(),
                ),
              ),
            ),
          ),

          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                //This container contains the list of different cities
                height: MediaQuery.of(context).size.height / 1.25,
                //color: Colors.dark,
                child: FutureBuilder(
                  future: _getForecasts(locs),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                           /* IconButton
                              (icon: Icon(Icons.delete),
                              onPressed: this.onDelete,
                            );*/
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(lon: locs[index].lat.toString(), lat: locs[index].lon.toString(), curr: false)));
                              },
                              child:  MultiplesForecastItem(
                            weather: snapshot.data.elementAt(index)),
                            );

                          });
                    } else {
                      return Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Loading...",
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.purple),
                          ),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ));
                    }
                  },
                  //child: AutocompleteLocation(),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LocationScreenState();
    throw UnimplementedError();
  }
}

class AutocompleteLocation extends StatelessWidget {
  late TextEditingController fieldTextEditingController;

  void clearText() {
    fieldTextEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
            child: TextField(
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
              decoration: InputDecoration(
                  hintText: 'Insert city or zip code',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: clearText,
                  ) //(Icons.clear)
                  ),
            ));
      },
      onSelected: (String selection) {
        Location selectedLoc = searchLoc(reader.locationList, selection);
        debugPrint('You just selected $selection');
        debugPrint('Lat and Long are ' +
            selectedLoc.lat.toString() +
            ', ' +
            selectedLoc.lon.toString());

        //Pop up dialog box to prompt user to save their search to the locations list
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Add this location?'),
                  content: Text(
                      'Would you like to add this location to your saved list of locations?'),
                  actions: [
                    TextButton(
                        child: Text('NO'),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    lon: selectedLoc.lat.toString(),
                                    lat: selectedLoc.lon.toString(),
                                    curr: false)))),
                    TextButton(
                      child: Text('YES'),
                      //Clicking 'YES' will route to a view of the selected location's forecast and add that location's
                      //..forecast to the user's favorites list as long as the length of the list is <= 11 locations.
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    lon: selectedLoc.lat.toString(),
                                    lat: selectedLoc.lon.toString(),
                                    curr: false)));
                        if (LocationScreenState.locs.length == 11) {
                          LocationScreenState._addForecast(selectedLoc);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Location Limit Reached!"),
                                    content: Text(
                                        "Please delete a location if you want to add another"),
                                    actions: [
                                      TextButton(
                                          child: Text("OK"),
                                          onPressed: () => Navigator.pushNamed(
                                              context, '/chi'))
                                    ],
                                  ));
                        }
                      },
                    ),
                  ],
                ));
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        String input = textEditingValue.text;
        if (input == '') {
          return const Iterable<String>.empty();
        }
        List<String> strList = <String>[];
        if (input.contains(' ')) {
          strList.add(input.substring(0, input.indexOf(' ')));
          strList.add(input.substring(input.indexOf(' ') + 1));
        }

        return reader.locationStringList.where((String option) {
          if (option.toLowerCase().contains(input.toLowerCase())) {
            return true;
          }
          if (strList.isNotEmpty) {
            if (option.toLowerCase().contains(strList[0].toLowerCase()) && option.toLowerCase().contains(strList[1].toLowerCase())) {
              return true;
            }
          }
          return false;
        });
      },
    );
  }

  Location searchLoc(List<Location> locationList, String loc) {
    // turns loc string into substrings with city, state, country
    int start = 0;
    int end = loc.indexOf(',', start);

    String city = loc.substring(start, end);

    start = end + 2;
    end = loc.indexOf(',', start);

    String state = loc.substring(start, end);

    start = end + 2;

    String country = loc.substring(start);

    // compares city, state, country substrings with counter parts in locationList
    for (int i = 0; i < locationList.length; i++) {
      if (locationList[i].city == city &&
          locationList[i].state == state &&
          locationList[i].country == country) {
        // returns specific location if successful
        return locationList[i];
      }
    }

    // this should hopefully never happen
    debugPrint("no location found, this shouldn't happen.");
    return locationList[0];
  }
}























































