import 'package:flutter/material.dart';
import 'LocationScreen.dart';
import 'Homescreen.dart';
import 'multiple.dart';

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
        '/': (_)=> HomeScreen(),
        '/chi': (_)=> LocationScreen(),
        '/mult': (_) => Multi(),
      },
    );
  }
}

