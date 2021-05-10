import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/widgets.dart';
import 'package:video_player/video_player.dart';

class Settings extends StatefulWidget {
  Settings(this._controller);
  VideoPlayerController _controller;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int rows = 0;
  int columns = 0;
  int speed = 0;
  int sliderSpeed = 1;

  List<int> speeds = [1000, 900, 800, 700, 600, 500, 400, 300, 200, 100];
  List<int> inverted = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Preferences.getAllPreferences(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          rows = snapshot.data[0];
          columns = snapshot.data[1];
          speed = snapshot.data[2];
          speed = speed ~/ 100;

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
          // sliderSpeed = inverted[(speeds.indexOf(speed) + 1) ~/ 100];
          // print(sliderSpeed);

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 50),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Stack(
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: widget._controller.value.size?.width ?? 0,
                      height: widget._controller.value.size?.height ?? 0,
                      child: VideoPlayer(widget._controller),
                    ),
                  )
                ),
                Center(
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      SnakeText(text: "GAMEPLAY", color: Colors.amber, size: 35, offset: true),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.swipe, color: Colors.amber, size: 100),
                            onPressed: () async {
                              print("XD");
                              await Preferences.setSwipe(true);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.sync, color: Colors.amber, size: 100),
                            onPressed: () async {
                              await Preferences.setSwipe(false);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 75),
                      SnakeText(text: "-", color: Colors.amber, size: 35, offset: true),
                      SizedBox(height: 20),
                      SnakeText(text: "ROWS: $rows", color: Colors.amber, size: 25, offset: true),
                      Slider(
                        min: 5,
                        max: 40,
                        activeColor: Colors.amber,
                        inactiveColor: Colors.amber[800],
                        value: rows.toDouble(), onChanged: (value) {
                          setState(() {
                            rows = value.toInt();
                            Preferences.setRows(rows);
                          });
                        }
                      ),
                      SizedBox(height: 50),

                      SnakeText(text: "COLUMNS: $columns", color: Colors.amber, size: 25, offset: true),
                      Slider(
                        min: 5,
                        max: 40,
                        activeColor: Colors.amber,
                        inactiveColor: Colors.amber[800],
                        value: columns.toDouble(), onChanged: (value) {
                          setState(() {
                            columns = value.toInt();
                            Preferences.setColumns(columns);
                          });
                        }
                      ),
                      SizedBox(height: 50),

                      SnakeText(text: "SPEED: $sliderSpeed", color: Colors.amber, size: 25, offset: true),
                      Slider(
                        min: 1,
                        max: 10,
                        divisions: 9,
                        activeColor: Colors.amber,
                        inactiveColor: Colors.amber[800],
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
                      SnakeText(text: "STYLE", color: Colors.amber, size: 55, offset: true),
                      SnakeText(text: "-", color: Colors.amber, size: 35, offset: true),
                      SizedBox(height: 20),
                      TextButton(
                        child: SnakeText(text: "CELTIC", font: "Celtic", color: Colors.amber, size: 40, offset: true),
                        onPressed: () async {
                          await Preferences.setFont("Celtic");
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        child: SnakeText(text: "GRIND", font: "Grind", color: Colors.amber, size: 40, offset: true),
                        onPressed: () async {
                          await Preferences.setFont("Grind");
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        child: SnakeText(text: "OMEGLE", font: "Omegle", color: Colors.amber, size: 40, offset: true),
                        onPressed: () async {
                          await Preferences.setFont("Omegle");
                          setState(() {});
                        },
                      ),
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