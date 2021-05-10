import 'package:flutter/material.dart';

class Swipe extends StatefulWidget {
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {

  String direction = "UP";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(

        onVerticalDragUpdate: (details) {
          setState(() {
            int sensitivity = 8;
            if (details.delta.dy > sensitivity) direction = "DOWN";
            else if(details.delta.dy < -sensitivity) direction = "UP";
          });
        },

        onHorizontalDragUpdate: (details) {  
          setState(() {
            int sensitivity = 8;
            if (details.delta.dx > sensitivity) direction = "RIGHT";
            else if(details.delta.dx < -sensitivity) direction = "LEFT";
          });
        },
        
        child: Container(
          color: Colors.cyan[900],
          child: Center(
            child: Text(direction, style: TextStyle(color: Colors.amber, fontSize: 30)),
          ),
        ),
      ),
    );
  }
}