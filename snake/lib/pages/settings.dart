import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/widgets.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int rows = 0;
  int columns = 0;
  int speed = 0;
  int sliderSpeed = 1;
  bool swipe;

  List<int> speeds = [1000, 900, 800, 700, 600, 500, 400, 300, 200, 100];
  List<int> inverted = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //We get all the preferences because we will work with them
      //Preferences are variables accesible ffom any part of the app
      future: Preferences.getAllPreferences(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          rows = snapshot.data[0];
          columns = snapshot.data[1];
          speed = snapshot.data[2];
          swipe = snapshot.data[6];
          speed = speed ~/ 100;

          //We do this if beacuse the lower the number is the higher the milliseconds
          if (speed == 10) sliderSpeed = 1;
          else if (speed == 9) sliderSpeed = 2;
          else if (speed == 8) sliderSpeed = 3;
          else if (speed == 7) sliderSpeed = 4;
          else if (speed == 6) sliderSpeed = 5;
          else if (speed == 5) sliderSpeed = 6;
          else if (speed == 4) sliderSpeed = 7;
          else if (speed == 3) sliderSpeed = 8;
          else if (speed == 2) sliderSpeed = 9;
          else if (speed == 1) sliderSpeed = 10;

          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/blue.jpg"),
                      fit: BoxFit.cover
                    )
                  )
                ),
                Center(
                  child: ListView(
                    children: [
                      SizedBox(height: 50),
                      //The following buttons switch the play style
                      //You can select swipe and rotation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            iconSize: 100,
                            icon: Icon(Icons.swipe, color: swipe ? Colors.green[300] : Colors.grey),
                            onPressed: () async {
                              await Preferences.setSwipe(true);
                              setState(() {});
                            },
                          ),
                          IconButton(
                            iconSize: 100,
                            icon: Icon(Icons.sync, color: !swipe ? Colors.green[300] : Colors.grey),
                            onPressed: () async {
                              await Preferences.setSwipe(false);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      //In this slider we can set how many rows will the grid have
                      SnakeText(text: "ROWS: $rows", color: Colors.green[300], size: 25, offset: true),
                      Slider(
                        min: 9,
                        max: 40,
                        activeColor: Colors.green[300],
                        inactiveColor: Colors.green[800],
                        value: rows.toDouble(), onChanged: (value) {
                          setState(() {
                            rows = value.toInt();
                            Preferences.setRows(rows);
                          });
                        }
                      ),
                      SizedBox(height: 50),
                      //And here we set how many columns will the grid have
                      SnakeText(text: "COLUMNS: $columns", color: Colors.green[300], size: 25, offset: true),
                      Slider(
                        min: 5,
                        max: 40,
                        activeColor: Colors.green[300],
                        inactiveColor: Colors.green[800],
                        value: columns.toDouble(), onChanged: (value) {
                          setState(() {
                            columns = value.toInt();
                            Preferences.setColumns(columns);
                          });
                        }
                      ),
                      SizedBox(height: 50),
                      //Here we set the speed
                      SnakeText(text: "SPEED: $sliderSpeed", color: Colors.green[300], size: 25, offset: true),
                      Slider(
                        min: 1,
                        max: 10,
                        divisions: 9,
                        activeColor: Colors.green[300],
                        inactiveColor: Colors.green[800],
                        value: sliderSpeed.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            sliderSpeed = value.toInt();
                            speed = speeds[sliderSpeed - 1];
                            Preferences.setSpeed(speed);
                          });
                        }
                      ),
                      SizedBox(height: 50),                      
                    ],
                  ),
                ),
              ]
            ),
          );
        }
      }
    );
  }
}