import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake/models/tiles.dart';

enum Direction { 
  Up,
  Down,
  Left,
  Right
}

class SnakeCoordinates {
  SnakeCoordinates(this.row, this.column);

  int row;
  int column;
}

class SnakeGame {

  int score = 0;

  int initialRow;
  int initialColumn;
  int rows = 20;
  int columns = 10;

  double opacity = 0;
  bool alternateColor = true;
  int goldenAppleProbability = 10;
  int rainbowAppleProbability = 1;
  int rainbowAppleCooldown = 0;

  List<List<Tile>> tiles;
  List<SnakeCoordinates> snakeCoordinates;

  Timer timer1;
  int time1 = 0;

  Timer timer2;
  int time2 = 0;

  String bodyUnlockable;
  String headUnlockable;

  int firstStageMax = 10;
  int secondStageMax = 20;
  int thirdStageMax = 40;
  bool secondStageIncrement = true;
  bool thirdStageIncrement = true;
  bool fourthStageIncrement = true;


  SnakeGame(int rows, int columns, String bodyUnlockable, String headUnlockable) {
    
    this.bodyUnlockable = bodyUnlockable;
    this.headUnlockable = headUnlockable;
    this.rows = rows;
    this.columns = columns;
    initialColumn = (columns / 2).round();
    initialRow = (rows / 2).round();
    int tiles = rows * columns;

    int stage = (tiles / 4).round();
    firstStageMax = stage;
    secondStageMax = stage * 2;
    thirdStageMax = stage * 3;

    startCoordinates();
    startTiles();
    startTimer1(2000);
    startTimer1(700);
  }

  void startCoordinates() {
    snakeCoordinates = [];
    snakeCoordinates.add(SnakeCoordinates(initialRow, initialColumn));
    snakeCoordinates.add(SnakeCoordinates(initialRow + 1, initialColumn));
    snakeCoordinates.add(SnakeCoordinates(initialRow + 2, initialColumn));
    snakeCoordinates.add(SnakeCoordinates(initialRow + 3, initialColumn));
  }

  void startTiles() {
    tiles = List.generate(rows, (i) => List(columns), growable: false);
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        tiles[i][j] = Tile.Empty;
      }
    }

    tiles[initialRow][initialColumn] = Tile.Head;
    tiles[initialRow + 1][initialColumn] = Tile.Body;
    tiles[initialRow + 2][initialColumn] = Tile.Body;
    tiles[initialRow + 3][initialColumn] = Tile.Tail;
    tiles[(initialRow / 2).round()][initialColumn] = Tile.Apple;

    tiles[1][1] = Tile.RainbowApple;
  }

  void startTimer1(int milliseconds) {
    Duration moment =  Duration(milliseconds: milliseconds);
    timer1 = Timer.periodic(moment, (Timer timer) {
        if (time1 == 999999999) timer.cancel();
        else {
          time1++;
          alternateColor = !alternateColor;
        }
      },
    );
  }

  void startTimer2(int milliseconds) {
    Duration moment =  Duration(milliseconds: milliseconds);
    timer2 = Timer.periodic(moment, (Timer timer) {
        if (time2 == 999999999) timer.cancel();
        else {
          time2++;
          alternateColor = !alternateColor;
        }
      },
    );
  }

  List<Widget> getTiles() {
    bool showBorder = true;
    Color borderColor = Colors.cyan;

    //First stage
    if (score >= 1 && score < firstStageMax) {
      //generateApple();
    }

    //Second stage
    else if (score >= firstStageMax && score < secondStageMax) {
      if (secondStageIncrement) {
        goldenAppleProbability += 5;
        rainbowAppleProbability++;
        secondStageIncrement = false;
      }
      borderColor = alternateColor ? Colors.blue : Colors.pink;
    }

    //Third stage
    else if (score >= secondStageMax && score < thirdStageMax) {
      if (thirdStageIncrement) {
        goldenAppleProbability += 10;
        rainbowAppleProbability++;
        thirdStageIncrement = false;
      }
      borderColor = alternateColor ? Colors.pink : Colors.yellow;
      opacity = .5;
    }

    //Fourth stage
    else if (score >= thirdStageMax) {
      if (fourthStageIncrement) {
        goldenAppleProbability += 15;
        rainbowAppleProbability++;
        fourthStageIncrement = false;
      }
      borderColor = Colors.transparent;
      opacity = 1;
    }
    
    List<Widget> list = [];
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        if (tiles[i][j] == Tile.Empty) list.add(EmptyTile(borderColor: borderColor));
        else if (tiles[i][j] == Tile.Apple) list.add(AppleTile(borderColor: borderColor));
        else if (tiles[i][j] == Tile.GoldenApple) list.add(GoldenAppleTile(borderColor: borderColor));
        else if (tiles[i][j] == Tile.RainbowApple) list.add(RainbowAppleTile(borderColor: borderColor));
        else if (tiles[i][j] == Tile.Head) list.add(HeadTile(bodyUnlockable: bodyUnlockable, headUnlockable: headUnlockable, borderColor: borderColor));
        else if (tiles[i][j] == Tile.Body) list.add(BodyTile(bodyUnlockable: bodyUnlockable, borderColor: borderColor));
        else list.add(TailTile(bodyUnlockable: bodyUnlockable, borderColor: borderColor));
      }
    }
    return list;
  }

  SnakeCoordinates getNextTileCoordinates(Direction direction) {
    if (direction == Direction.Up) return SnakeCoordinates(snakeCoordinates[0].row - 1, snakeCoordinates[0].column);
    else if (direction == Direction.Down) return SnakeCoordinates(snakeCoordinates[0].row + 1, snakeCoordinates[0].column);
    else if (direction == Direction.Right) return SnakeCoordinates(snakeCoordinates[0].row, snakeCoordinates[0].column + 1);
    else return SnakeCoordinates(snakeCoordinates[0].row, snakeCoordinates[0].column - 1);
  }

  void generateApple() {
    List<SnakeCoordinates> emptyTiles = [];
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        if (tiles[i][j] == Tile.Empty) emptyTiles.add(SnakeCoordinates(i, j));
      }
    }
    
    if (emptyTiles.length >= 1) {
      Random rng = Random();
      int r = rng.nextInt(emptyTiles.length == 1 ? 1 : emptyTiles.length - 1);
      int generationRow = emptyTiles[r].row;
      int generationColumn = emptyTiles[r].column;
      int next = rng.nextInt(100);
      if (next <= rainbowAppleProbability) tiles[generationRow][generationColumn] = Tile.RainbowApple;
      else if (next > rainbowAppleProbability && next <= goldenAppleProbability) tiles[generationRow][generationColumn] = Tile.GoldenApple;
      else tiles[generationRow][generationColumn] = Tile.Apple;
    }
  }

  bool won(Direction direction) => snakeCoordinates.length == rows * columns;

  bool canMoveForward(Direction direction) {
    SnakeCoordinates nextTile = getNextTileCoordinates(direction);
    return (nextTile.row >= 0 && nextTile.column >= 0
    && nextTile.row < tiles.length && nextTile.column < tiles[0].length)
    && (tiles[nextTile.row][nextTile.column] != Tile.Body);
  }

  void moveForward(Direction direction) {
    SnakeCoordinates nextTile = getNextTileCoordinates(direction);

    bool nextIsApple = tiles[nextTile.row][nextTile.column] == Tile.Apple;
    bool nextIsGoldenApple = tiles[nextTile.row][nextTile.column] == Tile.GoldenApple;
    bool nextIsRainbowApple = tiles[nextTile.row][nextTile.column] == Tile.RainbowApple;

    int last = snakeCoordinates.length - 1;
    tiles[snakeCoordinates[last].row][snakeCoordinates[last].column] = Tile.Empty;

    if (rainbowAppleCooldown > 0) {
      rainbowAppleCooldown--;
      generateApple();
    }

    if (nextIsApple || nextIsGoldenApple || nextIsRainbowApple) {
      if (nextIsRainbowApple) {score += 25; rainbowAppleCooldown = 4;}
      else if (nextIsGoldenApple) score += 5;
      else score ++;
      snakeCoordinates.add(SnakeCoordinates(snakeCoordinates[last].row, snakeCoordinates[last].column));
      tiles[snakeCoordinates[last].row][snakeCoordinates[last].column] = Tile.Tail;
      last++;
      generateApple();
    }

    //Reasign snake coordinates
    for (int i = snakeCoordinates.length - 1; i >= 0; i--) {
      if (i == 0) snakeCoordinates[0] = SnakeCoordinates(nextTile.row, nextTile.column);
      else snakeCoordinates[i] = snakeCoordinates[i - 1];
    }

    //Paint snake coordinates
    for (int i = 0; i <= snakeCoordinates.length - 1; i++) {
      if (i == 0) tiles[nextTile.row][nextTile.column] = Tile.Head;
      else if (i == last) tiles[snakeCoordinates[last].row][snakeCoordinates[last].column] = Tile.Tail;
      else tiles[snakeCoordinates[i].row][snakeCoordinates[i].column] = Tile.Body;
    }
  }
}