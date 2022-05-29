// ignore_for_file: prefer_const_constructors
import 'package:mock_weather/Homescreen.dart';

import 'jsonReader.dart';
import 'locations.dart';

import 'main.dart';

import 'package:flutter/material.dart';

// hello there
//theoretically I think this is public and
//can be accessed from anywhere in the app
String locToSearch = " ";

class LocationScreenState extends State<LocationScreen>{
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
                onPressed: () { //When the my_location icon is tapped
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomeScreen(lon: '', lat: '', curr: true)), //Because curr is set to true it will get current location
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
                height: 400,
                child: Center(
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

  JsonReader reader = JsonReader();

  late TextEditingController fieldTextEditingController;

  void clearText(){
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

          ){

        return Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
        child: TextField(

          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          style:  const TextStyle(fontSize: 16.0, color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Insert city or zip code',
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: clearText,
              )//(Icons.clear)
          ),
        )
        );
      },

      onSelected: (String selection) {
        Location selectedLoc = searchLoc(reader.locationList, selection);
        debugPrint('You just selected $selection');
        debugPrint('Lat and Long are ' + selectedLoc.lat.toString() + ', ' + selectedLoc.lon.toString());
        Navigator.push(context, MaterialPageRoute( // Go to the homescreen and search current location
            builder: (context) => HomeScreen(lon: selectedLoc.lat.toString(), lat: selectedLoc.lon.toString(), curr: false)),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return reader.locationStringList.where((String option) {
          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },

    );
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
}
