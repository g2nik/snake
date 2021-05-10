import 'package:flutter/material.dart';
import 'package:snake/pages/home.dart';

void main() => runApp(SnakeApp());

class SnakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan,
        accentColor: Colors.cyanAccent
      ),
      title: "SnakeGame",
      home: Home(),
    );
  }
}
