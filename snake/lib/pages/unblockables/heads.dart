import 'package:flutter/material.dart';
import 'package:snake/widgets.dart';

class UnlockableHeads extends StatefulWidget {
  @override
  _UnlockableHeadsState createState() => _UnlockableHeadsState();
}

//In this page we have the unlockables for the masks of the snake
class _UnlockableHeadsState extends State<UnlockableHeads> {
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
                  head: true,
                  child: Icon(Icons.brightness_high, size: 100),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Solid\nSnake",
                  unlockable: "solid_snake",
                  head: true,
                  unlockingScore: 10,
                  child: Image.asset("images/solid_snake.png"),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Kyojuro\nRengoku",
                  unlockable: "rengoku",
                  head: true,
                  unlockingScore: 15,
                  child: Image.asset("images/rengoku_avatar.png"),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Master\nChief",
                  unlockable: "master_chief",
                  head: true,
                  unlockingScore: 20,
                  child: Image.asset("images/master_chief.png"),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Bart",
                  unlockable: "bart",
                  head: true,
                  unlockingScore: 25,
                  child: Image.asset("images/bart.png"),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Darth\nVader",
                  unlockable: "vader",
                  head: true,
                  unlockingScore: 30,
                  child: Image.asset("images/vader.png"),
                  onPressed: reload
                ),
              ],
            ),
            Column(
              children: [
                UnlockableButton(
                  title: "Bruce\nLee",
                  unlockable: "bruce_lee",
                  head: true,
                  unlockingScore: 0,
                  child: Image.asset("images/bruce_lee_avatar.png"),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Messi",
                  unlockable: "messi",
                  head: true,
                  unlockingScore: 10,
                  child: Image.asset("images/messi_avatar.png"),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Michael\nJackson",
                  unlockable: "michael_jackson",
                  head: true,
                  unlockingScore: 15,
                  child: Image.asset("images/michael_jackson_avatar.png"),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Napoleon\nBonaparte",
                  unlockable: "napoleon",
                  head: true,
                  unlockingScore: 20,
                  child: Image.asset("images/napoleon_avatar.png"),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Nikolai II",
                  unlockable: "zar",
                  head: true,
                  unlockingScore: 25,
                  child: Image.asset("images/zar_avatar.png"),
                  onPressed: reload
                ),
                SizedBox(height: 50),
                UnlockableButton(
                  title: "Nikola\nTesla",
                  unlockable: "tesla",
                  head: true,
                  unlockingScore: 30,
                  child: Image.asset("images/tesla_avatar.png"),
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