// ignore_for_file: prefer_const_constructors
import 'package:mock_weather/Homescreen.dart';

import 'jsonReader.dart';
import 'locations.dart';

import 'package:flutter/material.dart';

// hello there
//theoretically I think this is public and
//can be accessed from anywhere in the app
String locToSearch = " ";

class LocationScreenState extends State<LocationScreen>{
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void clearText(){
      _controller.clear();
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
                  child: TextField(
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'Insert city or zip code',

                        prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: clearText,
                      )//(Icons.clear),//can work in functionality to clear text field
                    ),
                    controller: _controller,
                    //this is just here for now to see pop up messaging and
                    //show access to the search bar
                    //we could maybe use pop up messaging for a location error
                    onSubmitted: (String value) async{
                      locToSearch = value;
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: const Text('Thanks!'),
                            content: Text(
                                'You are searching for this location: "$value"'
                            ),
                            //this is the button on pop up message
                            actions: <Widget>[
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );

                    },
                  ),
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
                  child: AutocompleteLocation(),
                ),
              ),
              Container(
                height: 1000,
                color: Colors.blueGrey,
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

  @override
  Widget build(BuildContext context) {

    reader.readJson();

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return reader.locationStringList.where((String option) {
          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        Location selectedLoc = searchLoc(reader.locationList, selection);
        debugPrint('You just selected $selection');
        debugPrint('Lat and Long are ' + selectedLoc.lat.toString() + ', ' + selectedLoc.lon.toString());
        Navigator.push(context, MaterialPageRoute( // Go to the homescreen and search current location
          builder: (context) => HomeScreen(lon: selectedLoc.lat.toString(), lat: selectedLoc.lon.toString(), curr: false)),
        );
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
