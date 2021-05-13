import 'package:flutter/material.dart';
import 'package:snake/widgets.dart';

class TutorialCustomization extends StatelessWidget {
  TutorialCustomization({Function function1, Function function2})
  : f1 = function1, f2 = function2;
  Function f1;
  Function f2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        SnakeText(text: "Customize your snake", color: Colors.green[300], size: 25, offset: true),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(backgroundColor: Colors.redAccent),
            CircleAvatar(backgroundColor: Colors.yellowAccent),
            CircleAvatar(backgroundColor: Colors.greenAccent),
            CircleAvatar(backgroundColor: Colors.tealAccent),
            CircleAvatar(backgroundColor: Colors.blueAccent),
          ],
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(backgroundColor: Colors.deepOrange),
            CircleAvatar(backgroundColor: Colors.amberAccent),
            CircleAvatar(backgroundColor: Colors.green),
            CircleAvatar(backgroundColor: Colors.cyanAccent),
            CircleAvatar(backgroundColor: Colors.indigoAccent),
          ],
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(backgroundColor: Colors.pink),
            CircleAvatar(backgroundColor: Colors.limeAccent),
            CircleAvatar(backgroundColor: Colors.green[800]),
            CircleAvatar(backgroundColor: Colors.cyan),
            CircleAvatar(backgroundColor: Colors.deepPurpleAccent),
          ],
        ),
        SizedBox(height: 50),
        SnakeText(text: "Equip epic\ncharacters heads", color: Colors.green[300], size: 25, offset: true),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("images/solid_snake.png", scale: 3),
            Image.asset("images/bart.png", scale: 10),
            Image.asset("images/napoleon_avatar.png", scale: 7),
            Image.asset("images/michael_jackson_avatar.png", scale: 5),
          ],
        ),
        SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: f1,
              child: SnakeText(text: "<", color: Colors.green[300], size: 75, offset: true),
            ),
            TextButton(
              onPressed: f2,
              child: SnakeText(text: ">", color: Colors.green[300], size: 150, offset: true),
            ),
          ],
        ),
      ],
    );
  }
}