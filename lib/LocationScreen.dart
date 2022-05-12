// ignore_for_file: prefer_const_constructors

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            //top title
            title: Text('Weather App'),
            actions: [
              IconButton(
                icon: Icon(Icons.cloudy_snowing),
                onPressed: () {},
              ),
            ],
            bottom: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search a Location',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.add_location)),
                    controller: _controller,
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
                  child: Text(
                    'This is where the weather will be',
                  ),
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
