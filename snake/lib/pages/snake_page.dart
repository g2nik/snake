import 'dart:async';
import 'package:snake/models/preferences.dart';
import 'package:snake/models/snake_game.dart';
import 'package:flutter/material.dart';
import 'package:snake/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:sensors/sensors.dart';

class SnakePage extends StatefulWidget {
  SnakePage(this._controller, this.swipe);

  VideoPlayerController _controller;
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

  StreamSubscription gyroscopeSubscription;
  List<double> previousGyroscopeValues;

  Future<bool> startGame() async {
    if (loaded) {
      return false;
    }
    else {
      loaded = true;
      _continueGame = true;
      _direction = Direction.Up;
      _time = 0;
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

  void _startTimer(int milliseconds) {
    Duration moment =  Duration(milliseconds: milliseconds);
    _timer = Timer.periodic(moment, (Timer timer) {
        setState(() {
          if (_time == 999999999) timer.cancel();

          bool won = _snake.won(_direction);

          if (won) {

            _snake.score += 15;
            if (_snake.score > highestScore) Preferences.setHighScore(_snake.score);
            gameWon(_snake.score > highestScore);
            _timer.cancel();

          } else {

            _continueGame = _snake.canMoveForward(_direction);
            //print("continue game? (can move forward) $_continueGame");

            if (_continueGame) {
              _time++;
              _snake.moveForward(_direction);
              canChangeDirection = true;
            } else {
              //Game over
              _snake.timer1.cancel();
              _timer.cancel();
              if (_snake.score > highestScore) Preferences.setHighScore(_snake.score);
              gameOver(_snake.score > highestScore);
            }
          }
        });
      },
    );
  }

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

  void controlCallback(Direction direction, bool canChangeDirection) {
    _direction = direction;
    this.canChangeDirection = canChangeDirection;
  }

  void startGyroscopeControl() {
    bool firstTime = true;
    previousGyroscopeValues = [];
    gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        List<double> gyroscopeValues = [event.x, event.y, event.z];
        //Not first time
        if (!firstTime) {
          double delta = gyroscopeValues[2] - previousGyroscopeValues[2];
          double delta2 = previousGyroscopeValues[2] - gyroscopeValues[2];
          // print("d1 $delta");
          // print("d2 $delta2");
          
          if (gyroscopeValues[0] > 1 && _direction != Direction.Down && _direction != Direction.Up) _direction = Direction.Down;
          else if (gyroscopeValues[0] < -1 && _direction != Direction.Up && _direction != Direction.Down) _direction = Direction.Up;

          if (gyroscopeValues[1] > 1 && _direction != Direction.Right && _direction != Direction.Left) _direction = Direction.Right;
          else if (gyroscopeValues[1] < -1 && _direction != Direction.Left && _direction != Direction.Right) _direction = Direction.Left;

          // else if (gyroscopeValues[2] < 0 && previousGyroscopeValues[2] > .5) direction = Direction.Left;
          // else if (gyroscopeValues[2] > 0 && previousGyroscopeValues[2] < -.5) direction = Direction.Right;

          // if (gyroscopeValues[2] > 1 && previousGyroscopeValues[2] > .5) text = "left";
          // if (gyroscopeValues[2] < -1 && previousGyroscopeValues[2] > -.5 ) text = "right";
          // if (delta > 3 && gyroscopeValues[2] > 1) text = "Left";
          // else if (delta2 > 3 && gyroscopeValues[2] < -1) text = "Right";
        }
        previousGyroscopeValues = gyroscopeValues;
        firstTime = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (!widget.swipe) startGyroscopeControl();
  }

  @override
  void dispose() {
    if (_snake.score > highestScore) Preferences.setHighScore(_snake.score);
    _snake.timer1.cancel();
    _snake.timer2.cancel();
    _timer.cancel();
    gyroscopeSubscription.cancel();
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
                      opacity: _snake.opacity,
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: widget._controller.value.size?.width ?? 0,
                            height: widget._controller.value.size?.height ?? 0,
                            child: VideoPlayer(widget._controller),
                          ),
                        )
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.cyan)
                        ),
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: _snake.columns,
                          children: _snake.getTiles()
                        ),
                      )
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