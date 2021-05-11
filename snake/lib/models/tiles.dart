import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

enum Tile {
  Empty,
  Apple,
  GoldenApple,
  RainbowApple,
  Head,
  Body,
  Tail
}

class SnakeStyle {
  static LinearGradient getHeadGradient(String unlockable) {
    if (unlockable == "none") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Colors.greenAccent[100], Colors.tealAccent],
      );
    }
    else if (unlockable == "red") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Colors.redAccent, Colors.red[900]],
      );
    }
    else if (unlockable == "blue") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Colors.blueAccent, Colors.blue[900]],
      );
    }
    else if (unlockable == "ghost") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.transparent],
      );
    }
  }

  static LinearGradient getBodyGradient(String unlockable) {
    if (unlockable == "none") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Colors.greenAccent, Colors.tealAccent],
      );
    }
    else if (unlockable == "red") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Colors.redAccent, Colors.red[900]],
      );
    }
    else if (unlockable == "blue") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Colors.blueAccent, Colors.blue[900]],
      );
    }
    else if (unlockable == "ghost") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.transparent],
      );
    }
  }

  static LinearGradient getTailGradient(String unlockable) {
    if (unlockable == "none") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Colors.greenAccent, Colors.greenAccent[100]],
      );
    }
    else if (unlockable == "red") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Colors.redAccent, Colors.orange],
      );
    }
    else if (unlockable == "blue") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [Colors.lightBlueAccent[100], Colors.lightBlueAccent],
      );
    }
    else if (unlockable == "ghost") {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.transparent],
      );
    }
  }

}

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
      decoration: BoxDecoration(border: Border.all(color: color),),
      child: RainbowApple(),
    );
  }
}

class RainbowApple extends StatefulWidget {
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
    Colors.teal,
    Colors.blue,
    Colors.blue[700],
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
    startTimer(50);
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(colors[colorIndex], BlendMode.modulate),
      child: Image.asset("images/rainbow_apple.png", scale: 5,)
    );
  }
}

class HeadTile extends StatelessWidget {
  HeadTile({Color borderColor, String bodyUnlockable, String headUnlockable})
  : color = borderColor, this.bodyUnlockable = bodyUnlockable, this.headUnlockable = headUnlockable;
  Color color;
  String bodyUnlockable;
  String headUnlockable;

  String path;

  @override
  Widget build(BuildContext context) {

    if (headUnlockable == "solidSnake") {
      path = "images/solid_snake.png";
    } else if (headUnlockable == "rengoku") {
      path = "images/rengoku.png";
    }

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
            image: DecorationImage(image: AssetImage(path))
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