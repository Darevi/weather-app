import 'package:flutter/material.dart';
import 'LocationScreen.dart';
import 'Homescreen.dart';
import 'multiple.dart';
import 'tools/current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark
      ),
      initialRoute: '/',
      routes: {
        '/': (_)=> HomeScreen(lon: '46.9965', lat: '-120.5478', curr: true),
        '/chi': (_)=> LocationScreen(),
        '/mult': (_) => Multi(),
      },
    );
  }
}

