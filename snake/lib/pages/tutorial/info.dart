import 'package:flutter/material.dart';
import 'package:snake/models/tiles.dart';
import 'package:snake/widgets.dart';

class TutorialInfo extends StatelessWidget {
  TutorialInfo({Function function1, Function function2})
  : f1 = function1, f2 = function2;
  Function f1;
  Function f2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        SnakeText(text: "Red apples give you\n1 point", color: Colors.green[300], size: 25, offset: true),
        SizedBox(height: 25),
        Image.asset("images/apple.png", scale: 7.5),
        SizedBox(height: 50),
        SnakeText(text: "Golden apples give you\n5 points", color: Colors.green[300], size: 25, offset: true),
        SizedBox(height: 25),
        Image.asset("images/golden_apple.png", scale: 7.5),
        SizedBox(height: 50),
        SnakeText(text: "Rainbow apples\ngenerate more apples\nfor 5 seconds", color: Colors.green[300], size: 25, offset: true),
        SizedBox(height: 25),
        RainbowApple(),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: f1,
              child: SnakeText(text: "<", color: Colors.green[300], size: 75, offset: true),
            ),
            TextButton(
              onPressed: f2,
              child: SnakeText(text: ">", color: Colors.green[300], size: 75, offset: true),
            ),
          ],
        ),
      ],
    );
  }
}