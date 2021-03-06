import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/models/snake_game.dart';

//This widget allows the control of the snake depending on how the player swiped
class SnakeControl extends StatelessWidget {
  SnakeControl({Direction direction, bool canChangeDirection, bool swipe, Widget child, Function callback})
  : this.direction = direction, this.canChangeDirection = canChangeDirection, this.swipe = swipe,
  this.child = child, this.callback = callback;

  Direction direction;
  bool canChangeDirection;
  bool swipe;
  Widget child;
  Function callback;

  @override
  Widget build(BuildContext context) {
    return swipe ? GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity > 0 && canChangeDirection && direction != Direction.Left && direction != Direction.Right) {
          callback(Direction.Right);
        } else if (details.primaryVelocity < 0 && canChangeDirection && direction != Direction.Right && direction != Direction.Left) {
          callback(Direction.Left);
        }
      },
      onVerticalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity > 0 && canChangeDirection && direction != Direction.Up && direction != Direction.Down) {
          callback(Direction.Down);
        } else if(details.primaryVelocity < 0 && canChangeDirection && direction != Direction.Down && direction != Direction.Up){
          callback(Direction.Up);
        }
      },
      child: child,
    )
    : Container(child: child);
  }
}

//A custom text widget
class SnakeText extends StatelessWidget {
  SnakeText({String text, String font, Color color, double size, bool offset})
  : this.text = text, this.font = font, this.color = color, this.size = size, this.offset = offset;

  final String text;
  final String font;
  final Color color;
  final double size;
  final bool offset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        !offset ? Container()
        : Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Omegle",
            fontSize: size,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = Colors.black,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Omegle",
            fontSize: size,
            color: color,
          ),
        ),
      ],
    );
  }
}

//A custom button widget with translucid background
class SnakeButton extends StatelessWidget {
  SnakeButton({String text, Color color, Function onPressed})
  : this.text = text, this.color = color, this.onPressed = onPressed;

  final String text;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
        child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50, vertical: 25)),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: color, width: 5)
            )
          )
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 230, maxWidth: 230),
            child: SnakeText(text: text, color: Colors.green[300], size: 30, offset: true),
            //Text(text, textAlign: TextAlign.center, style: TextStyle(color: color, fontSize: 30))
          ),
        ),
      ),
    );
  }
}

//This button allows to select an unlockable
class UnlockableButton extends StatelessWidget {
  UnlockableButton({String title, String unlockable, int unlockingScore, bool head, Widget child, Function onPressed})
  : this.title = title, this.unlockable = unlockable, this.unlockingScore = unlockingScore, this.head = head, this.child = child, this.onPressed = onPressed;

  String title;
  String unlockable;
  int unlockingScore;
  bool head;
  Widget child;
  Function onPressed;

  int highestScore;
  String currentUnlockable;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Preferences.getUnlockables(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          highestScore = snapshot.data[0];
          currentUnlockable = head ? snapshot.data[2] : snapshot.data[1];

          return Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 75, maxHeight: 100),
                child: SnakeText(
                  text: highestScore >= unlockingScore ? title : "Get $unlockingScore\npoints",
                  color: Colors.green[300], size: 30, offset: true
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                style: ButtonStyle(shape: MaterialStateProperty.all(CircleBorder())),
                onPressed: () async {
                  if (highestScore >= unlockingScore) {
                    if (head) await Preferences.setCurrentHeadUnlockable(unlockable);
                    else await Preferences.setCurrentBodyUnlockable(unlockable);
                    onPressed();
                  }
                },
                child: CircleAvatar(
                  backgroundColor: currentUnlockable == unlockable ? Colors.green[300] : Colors.grey[800],
                  radius: 60,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey[800],
                    child: highestScore < unlockingScore
                    ? Icon(Icons.lock, size: 75)
                    : child,
                  ),
                ),
              ),
            ],
          );
        }
      }
    );
  }
}

