import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/models/snake_game.dart';
import 'package:flutter/material.dart';
import 'package:snake/models/tiles.dart';
import 'package:snake/widgets.dart';
import 'package:sensors/sensors.dart';

//This takes a swipe bool which determines the contros used in the game
class SnakePage extends StatefulWidget {
  SnakePage(this.swipe);
  bool swipe;

  @override
  _SnakePageState createState() => _SnakePageState();
}

class _SnakePageState extends State<SnakePage> {
  bool loaded = false;
  bool canChangeDirection = true;
  Timer _timer;
  int _time;
  SnakeGame _snake;
  bool _continueGame;
  Direction _direction;
  int highestScore;
  String bodyUnlockable;
  String headUnlockable;

  double sensitivity;
  StreamSubscription gyroscopeSubscription;

  AudioPlayer audio = AudioPlayer();

  //This function starts a game
  Future<bool> startGame() async {
    if (loaded) {
      return false;
    }
    else {
      loaded = true;
      _continueGame = true;
      _direction = Direction.Up;
      _time = 0;
      audio.setAsset("sound/bite.mp3");
      List<dynamic> preferences = await Preferences.getAllPreferences();
      int rows = preferences[0];
      int columns = preferences[1];
      int speed = preferences[2];
      highestScore = preferences[3];
      bodyUnlockable = preferences[4];
      headUnlockable = preferences[5];

      _snake = SnakeGame(rows, columns, bodyUnlockable, headUnlockable);
      _startTimer(speed);
      return true;
    }
  }

  //This function starts the timer and determines if the player has won lost or can continue to play
  void _startTimer(int milliseconds) {
    Duration moment =  Duration(milliseconds: milliseconds);
    _timer = Timer.periodic(moment, (Timer timer) async {
      if (_time == 999999999) timer.cancel();
      bool won = _snake.won(_direction);

      if (won) {
        await audio.setAsset("sound/win.mp3");
        audio.play().then((value) => audio.stop());
        _snake.score += 15;
        if (_snake.score > highestScore) Preferences.setHighScore(_snake.score);
        gameWon(_snake.score > highestScore);
        _timer.cancel();
      } else {
        _continueGame = _snake.canMoveForward(_direction);
        if (_continueGame) {
          int nextRow = _snake.getNextTileCoordinates(_direction).row;
          int nextColumn = _snake.getNextTileCoordinates(_direction).column;
          if (_snake.tiles[nextRow][nextColumn] == Tile.Apple
          || _snake.tiles[nextRow][nextColumn] == Tile.GoldenApple
          || _snake.tiles[nextRow][nextColumn] == Tile.RainbowApple)
          {
            audio.play().then((value) => audio.stop());
          }
          _time++;
          _snake.moveForward(_direction);
          canChangeDirection = true;
        } else {
          //Game over
          if (_snake.timer1 != null) _snake.timer1.cancel();
          if (_snake.timer2 != null) _snake.timer2.cancel();
          if (_timer != null) _timer.cancel();
          if (_snake.score > highestScore) Preferences.setHighScore(_snake.score);
          await audio.setAsset("sound/gg.mp3");
          audio.play().then((value) => audio.stop());
          gameOver(_snake.score > highestScore);
        }
      }
      setState(() {});
      },
    );
  }

  //Popup that shows when the player has won
  void gameWon(bool newHighScore) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.grey[900],
            content: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 400, minWidth: 350),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    newHighScore ? "NEW RECORD!!!" : "YOU WON",
                    style: TextStyle(color: Colors.cyanAccent, fontSize: 30)),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      newHighScore ? "Your record is now ${_snake.score}!!!" : "Your score is ${_snake.score}, your highest is $highestScore.\nUnless...",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.cyanAccent, fontSize: 20)),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.cyanAccent),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.cyanAccent, width: 2)
                        )
                      )
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
                      child: Text("PLAY AGAIN", textAlign: TextAlign.center, style: TextStyle(color: Colors.cyanAccent, fontSize: 20))
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      loaded = false;
                      startGame();
                      setState(() {});
                    }
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.cyanAccent, width: 2)
                        )
                      )
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
                      child: Text("HOME", textAlign: TextAlign.center, style: TextStyle(color: Colors.cyanAccent, fontSize: 20))
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                    }
                  ),
                ],
              ),
            )
          ),
        );
      }
    );
  }

  //Popup that shows when the player has lost
  void gameOver(bool newHighScore) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.grey[900],
            content: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: newHighScore ? 350 : 400, minWidth: 350),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    newHighScore ? "NEW RECORD" : "GG",
                    style: TextStyle(color: Colors.cyanAccent, fontSize: 30)),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      newHighScore ? "Your record is now ${_snake.score}!!!" : "Your score is ${_snake.score}, your highest is $highestScore.\nUnless...",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.cyanAccent, fontSize: 20)),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.cyanAccent),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.cyanAccent, width: 2)
                        )
                      )
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
                      child: Text("PLAY AGAIN", textAlign: TextAlign.center, style: TextStyle(color: Colors.cyanAccent, fontSize: 20))
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      loaded = false;
                      startGame();
                      setState(() {});
                    }
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.cyanAccent, width: 2)
                        )
                      )
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
                      child: Text("HOME", textAlign: TextAlign.center, style: TextStyle(color: Colors.cyanAccent, fontSize: 20))
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                    }
                  ),
                ],
              ),
            )
          ),
        );
      }
    );
  }

  //Changes the direction and prevents the player from moving the snake this turn or movement
  void controlCallback(Direction direction) {
    _direction = direction;
    this.canChangeDirection = false;
  }

  //This function changes the direction of the snake dpending on the phone rotation
  void startGyroscopeControl() {
    double verticalSensitivity = 1.25;
    double downSensitivity = .75;
    double horizontalSensitivity = 1;


    gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      List<double> gyroscopeValues = [event.x, event.y, event.z];

      //Move Up
      if (gyroscopeValues[0] > verticalSensitivity
      && canChangeDirection
      && _direction != Direction.Down
      && _direction != Direction.Up)
      {
        canChangeDirection = false;
        _direction = Direction.Down;
      } 
      //Move Down
      else if (gyroscopeValues[0] < -downSensitivity
      && canChangeDirection
      && _direction != Direction.Up
      && _direction != Direction.Down)
      {
        canChangeDirection = false;
        _direction = Direction.Up;
      }
      //Move Rigth
      if (gyroscopeValues[1] > horizontalSensitivity
      && canChangeDirection
      && _direction != Direction.Right
      && _direction != Direction.Left)
      {
        canChangeDirection = false;
        _direction = Direction.Right;
      }
      //Move Left
      else if (gyroscopeValues[1] < -horizontalSensitivity
      && canChangeDirection
      && _direction != Direction.Left
      && _direction != Direction.Right)
      {
        canChangeDirection = false;
        _direction = Direction.Left;
      }
    });
  }

  //Sets the audio player to play the bite sound
  void loadAudio() async {
    await audio.setAsset("sound/bite.mp3");
  }

  @override
  void initState() {
    super.initState();
    loadAudio();
    //If the swipe bool is false start the gyroscope controls
    if (!widget.swipe) startGyroscopeControl();
  }

  @override
  void dispose() async {
    //Disposes of all the timers and the gyroscope subscription
    if (_snake.score > highestScore) await Preferences.setHighScore(_snake.score);
    if (_snake.timer1 != null) _snake.timer1.cancel();
    if (_snake.timer2 != null) _snake.timer2.cancel();
    if (_timer != null) _timer.cancel();
    if (gyroscopeSubscription != null) gyroscopeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: startGame(),
      builder: (context, snapshot) {
        return !snapshot.hasData
        ? Center(child: CircularProgressIndicator())
        : WillPopScope(
          onWillPop: () {},
          child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text("SCORE: ${_snake.score}"),
                brightness: Brightness.dark
              ),
              body: SnakeControl(

                direction: _direction,
                canChangeDirection: canChangeDirection,
                callback: controlCallback,
                swipe: widget.swipe,
                
                child: Stack(
                  children: [
                    Opacity(
                      //Depending on the stage this will be more transparent to show the background
                      opacity: _snake.opacity,
                      child: SizedBox.expand(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/blue.jpg"),
                              fit: BoxFit.cover
                            )
                          )
                        ),
                      ),
                    ),
                    //This widget displays the grid
                    Center(
                      child: GridView.count(
                        addRepaintBoundaries: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: _snake.columns,
                        children: _snake.getTiles()
                      ),
                    ),
                  ]
                ),
              ),
            ),
        );
      },
    );
  }
}
