import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/pages/home.dart';
import 'package:snake/pages/tutorial/tutorial.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool firstTime = await Preferences.getFirstTime();
  //If the firstTime value is null we will set it to true so that
  //when the SnakeApp loads it launches the tutorial
  if (firstTime == null) {
    firstTime = true;
    await Preferences.setDefaultPreferences();
  }
  firstTime = true;
  runApp(SnakeApp(firstTime));
}

class SnakeApp extends StatelessWidget {
  SnakeApp(this.firstTime);
  final bool firstTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[200],
        accentColor: Colors.greenAccent
      ),
      title: "SnakeGame",
      home: firstTime ? Tutorial() : Home(),
    );
  }
}
