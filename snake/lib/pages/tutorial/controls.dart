import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/widgets.dart';

class TutorialControls extends StatelessWidget {
  TutorialControls({bool swipe, Function function1, Function function2})
  : this.swipe = swipe, f1 = function1, f2 = function2;
  bool swipe;
  Function f1;
  Function f2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        SnakeText(text: "Welcome!", color: Colors.green[300], size: 70, offset: true),
        SizedBox(height: 50),
        SnakeText(text: "Choose a\nplaystyle", color: Colors.green[300], size: 40, offset: true),
        SizedBox(height: 75),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  iconSize: 100,
                  icon: Icon(Icons.swipe, color: swipe ? Colors.green[300] : Colors.grey),
                  onPressed: () async {
                    await Preferences.setSwipe(true);
                    f1();
                  }
                ),
                SizedBox(height: 30),
                SnakeText(
                  text: "Swipe",
                  color: Colors.green[300],
                  size: 30, 
                  offset: true
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  iconSize: 100,
                  icon: Icon(Icons.sync, color: !swipe ? Colors.green[300] : Colors.grey),
                  onPressed: () async {
                    await Preferences.setSwipe(false);
                    f1();
                  }
                ),
                SizedBox(height: 30),
                SnakeText(
                  text: "Rotate",
                  color: Colors.green[300],
                  size: 30, 
                  offset: true
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 125),
        TextButton(
          onPressed: f2,
          child: SnakeText(text: ">", color: Colors.green[300], size: 75, offset: true),
        )
      ],
    );
  }
}