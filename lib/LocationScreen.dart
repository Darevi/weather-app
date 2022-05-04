// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
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
