import 'package:flutter/material.dart';
import 'package:snake/widgets.dart';

class UnlockableBodies extends StatefulWidget {
  @override
  _UnlockableBodiesState createState() => _UnlockableBodiesState();
}

class _UnlockableBodiesState extends State<UnlockableBodies> {
  void reload() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                UnlockableButton(
                  title: "Default",
                  unlockable: "none",
                  unlockingScore: 0,
                  head: false,
                  child: Icon(Icons.brightness_high, color: Colors.greenAccent, size: 100),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Red",
                  unlockable: "red",
                  unlockingScore: 0,
                  head: false,
                  child: Icon(Icons.brightness_high, color: Colors.redAccent, size: 100),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Blue",
                  unlockable: "blue",
                  unlockingScore: 0,
                  head: false,
                  child: Icon(Icons.brightness_high, color: Colors.blueAccent, size: 100),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Yellow",
                  unlockable: "yellow",
                  unlockingScore: 0,
                  head: false,
                  child: Icon(Icons.brightness_high, color: Colors.yellowAccent, size: 100),
                  onPressed: reload
                ),
              ],
            ),
            Column(
              children: [
                UnlockableButton(
                  title: "Teal",
                  unlockable: "teal",
                  unlockingScore: 0,
                  head: false,
                  child: Icon(Icons.brightness_high, color: Colors.tealAccent, size: 100),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "White",
                  unlockable: "white",
                  unlockingScore: 0,
                  head: false,
                  child: Icon(Icons.brightness_high, color: Colors.white, size: 100),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Black",
                  unlockable: "black",
                  unlockingScore: 0,
                  head: false,
                  child: Icon(Icons.brightness_high, color: Colors.black, size: 100),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Ghost",
                  unlockable: "ghost",
                  unlockingScore: 500,
                  head: false,
                  child: Icon(Icons.brightness_high, color: Colors.cyan[200], size: 100),
                  onPressed: reload
                ),
              ],
            ),
          ],
        ),
      ]
    );
  }
}