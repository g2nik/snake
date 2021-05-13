import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/models/snake_game.dart';

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
          callback(Direction.Right, false);
        } else if (details.primaryVelocity < 0 && canChangeDirection && direction != Direction.Right && direction != Direction.Left) {
          callback(Direction.Left, false);
        }
      },
      onVerticalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity > 0 && canChangeDirection && direction != Direction.Up && direction != Direction.Down) {
          callback(Direction.Down, false);
        } else if(details.primaryVelocity < 0 && canChangeDirection && direction != Direction.Down && direction != Direction.Up){
          callback(Direction.Up, false);
        }
      },
      child: child,
    )
    : Container(child: child);
  }
}

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
    return FutureBuilder(
      future: Preferences.getFont(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        return !snapshot.hasData ? Center(child: CircularProgressIndicator())
        : Stack(
          alignment: Alignment.center,
          children: [
            !offset ? Container()
            : Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: font ?? snapshot.data,
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
                fontFamily: font ?? snapshot.data,
                fontSize: size,
                color: color,
              ),
            ),
          ],
        );
      },
    );
  }
}

class SnakeButton extends StatelessWidget {
  SnakeButton({String text, Function onPressed})
  : this.text = text, this.onPressed = onPressed;

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
        child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 75, vertical: 25)),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Colors.amber, width: 5)
            )
          )
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
            child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Colors.amber, fontSize: 30))
          ),
        ),
      ),
    );
  }
}

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
                  color: Colors.amber, size: 30, offset: true
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
                  backgroundColor: currentUnlockable == unlockable ? Colors.amber : Colors.grey[800],
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

