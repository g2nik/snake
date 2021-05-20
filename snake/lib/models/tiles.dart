import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';

//We create a tile enum to simplify the tile classification
enum Tile {
  Empty,
  Apple,
  GoldenApple,
  RainbowApple,
  Head,
  Body,
  Tail
}

//This class returns gradients depending on the current unlockable
class SnakeStyle {

  //This method returns a gradient for the head
  static LinearGradient getHeadGradient(String unlockable) {
    List<Color> colors = [];

    if (unlockable == "none") colors = [Colors.greenAccent[100], Colors.tealAccent];
    else if (unlockable == "red") colors = [Colors.redAccent, Colors.red[900]];
    else if (unlockable == "blue") colors = [Colors.blueAccent, Colors.blue[900]];
    else if (unlockable == "yellow") colors = [Colors.yellow, Colors.amber];
    else if (unlockable == "teal") colors = [Colors.teal[50], Colors.tealAccent];
    else if (unlockable == "white") colors = [Colors.white, Colors.white];
    else if (unlockable == "black") colors = [Colors.black, Colors.black];
    else if (unlockable == "ghost") colors = [Colors.transparent, Colors.transparent];

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 1.0],
      colors: colors,
    );
  }

  //This method returns a gradient for the body
  static LinearGradient getBodyGradient(String unlockable) {
    List<Color> colors = [];
    
    if (unlockable == "none") colors = [Colors.greenAccent, Colors.tealAccent];
    else if (unlockable == "red") colors = [Colors.redAccent, Colors.red[900]];
    else if (unlockable == "blue") colors = [Colors.blueAccent, Colors.blue[900]];
    else if (unlockable == "yellow") colors = [Colors.amber, Colors.amberAccent];
    else if (unlockable == "teal") colors = [Colors.tealAccent, Colors.teal];
    else if (unlockable == "white") colors = [Colors.white, Colors.white];
    else if (unlockable == "black") colors = [Colors.black, Colors.black];
    else if (unlockable == "ghost") colors = [Colors.transparent, Colors.transparent];

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 1.0],
      colors: colors,
    );
  }

  //This method returns a gradient for the tail
  static LinearGradient getTailGradient(String unlockable) {
    List<Color> colors = [];
    
    if (unlockable == "none") colors = [Colors.greenAccent, Colors.greenAccent[100]];
    else if (unlockable == "red") colors = [Colors.redAccent, Colors.orange];
    else if (unlockable == "blue") colors = [Colors.lightBlueAccent[100], Colors.lightBlueAccent];
    else if (unlockable == "yellow") colors = [Colors.yellowAccent, Colors.white];
    else if (unlockable == "teal") colors = [Colors.teal[50], Colors.tealAccent[100]];
    else if (unlockable == "white") colors = [Colors.white, Colors.white];
    else if (unlockable == "black") colors = [Colors.black, Colors.black];
    else if (unlockable == "ghost") colors = [Colors.transparent, Colors.transparent];

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 1.0],
      colors: colors,
    );
  }
}

//Here are the widgets returned to the snake page grid
class EmptyTile extends StatelessWidget {
  EmptyTile({Color borderColor})
  : color = borderColor;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0),
        border: Border.all(color: color),
      ),
    );
  }
}

class AppleTile extends StatelessWidget {
  AppleTile({Color borderColor})
  : color = borderColor;
  Color color;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color),
        image: DecorationImage(image: AssetImage("images/apple.png"))
      ),
    );
  }
}

class GoldenAppleTile extends StatelessWidget {
  GoldenAppleTile({Color borderColor})
  : color = borderColor;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color),
        image: DecorationImage(image: AssetImage("images/golden_apple.png"))
      ),
    );
  }
}

class RainbowAppleTile extends StatelessWidget {
  RainbowAppleTile({Color borderColor})
  : color = borderColor;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: color)),
      child: RainbowApple(),
    );
  }
}

//This is an image of an apple that changes its color with a rainbow effect
class RainbowApple extends StatefulWidget {
  RainbowApple([double scale]) {
    this.scale = scale == null ? 7.5 : scale;
  }

  double scale = 7.5;
  @override
  _RainbowAppleState createState() => _RainbowAppleState();
}

class _RainbowAppleState extends State<RainbowApple> {
  Timer _timer;
  int time;
  int colorIndex = 0;

  List<Color> colors = [
    Colors.red,
    Colors.deepOrange,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.limeAccent,
    Colors.lightGreen,
    Colors.green,
    Colors.greenAccent,
    Colors.tealAccent,
    Colors.blue,
    Colors.indigo,
    Colors.deepPurple,
    Colors.purple,
    Colors.purpleAccent,
    Colors.pinkAccent,
    Colors.pink,
  ];

  void startTimer(int milliseconds) {
    Duration moment =  Duration(milliseconds: milliseconds);
    _timer = Timer.periodic(moment, (Timer timer) {
        if (time == 999999999) timer.cancel();
        else {
          setState(() {
            if (colorIndex < colors.length - 1) colorIndex++;
            else colorIndex = 0;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer(75);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(colors[colorIndex], BlendMode.modulate),
      child: Image.asset("images/rainbow_apple.png", scale: widget.scale)
    );
  }
}

class HeadTile extends StatelessWidget {
  HeadTile({Color borderColor, String bodyUnlockable, String headUnlockable})
  : color = borderColor, this.bodyUnlockable = bodyUnlockable, this.headUnlockable = headUnlockable;
  Color color;
  String bodyUnlockable;
  String headUnlockable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: color),
            gradient: SnakeStyle.getHeadGradient(bodyUnlockable)
          ),
        ),
        
        headUnlockable != "none" ? Container(
          decoration: BoxDecoration(
            border: Border.all(color: color),
            image: DecorationImage(image: AssetImage("images/$headUnlockable.png"))
          ),
        ) : Container()
      ],
    );
  }
}

class BodyTile extends StatelessWidget {
  BodyTile({String bodyUnlockable, Color borderColor})
  : this.bodyUnlockable = bodyUnlockable, color = borderColor;
  String bodyUnlockable;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color),
        gradient: SnakeStyle.getBodyGradient(bodyUnlockable)
      ),
    );
  }
}

class TailTile extends StatelessWidget {
  TailTile({String bodyUnlockable, Color borderColor})
  : this.bodyUnlockable = bodyUnlockable, color = borderColor;
  String bodyUnlockable;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent[100],
        gradient: SnakeStyle.getTailGradient(bodyUnlockable),
        border: Border.all(color: color),
      ),
    );
  }
}