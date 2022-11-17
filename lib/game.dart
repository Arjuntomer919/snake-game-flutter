import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/control_panel.dart';
import 'package:snake_game/piece.dart';
import 'package:snake_game/direction.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late int upperBoundX, upperBoundY, lowerBoundX, lowerBoundY;
  late double screenWidth, screenHight;
  int step = 30;
  int length = 5;
  Offset? foodPosition;
  // Piece? food;
  int score = 0;
  double speed = 1.0;

  List<Offset> positions = [];
  Direction direction = Direction.right;
  Timer? timer;

  void changeSpeed() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {});
    });
  }

  Widget getControls() {
    return ControlPanel(
      onTapped: (Direction newDirection) {
        direction = newDirection;
      },
    );
  }

  void restart() {
    changeSpeed();
  }

  @override
  void initState() {
    super.initState();
    restart();
  }

  int getNearestTens(int num) {
    int output;
    output = (num ~/ step) * step;
    if (output == 0) {
      output += step;
    }
    return output;
  }

  Offset getRandomPosition() {
    Offset position;
    int posX = Random().nextInt(upperBoundX) + lowerBoundX;
    int posY = Random().nextInt(upperBoundY) + lowerBoundY;

    position = Offset(
        getNearestTens(posX).toDouble(), getNearestTens(posY).toDouble());
    return position;
  }

  void draw() {
    if (positions.length == 0) {
      positions.add(getRandomPosition());
    }

    while (length > positions.length) {
      positions.add(positions[positions.length - 1]);
    }

    for (var i = positions.length - 1; i > 0; i--) {
      positions[i] = positions[i - 1];
      //  4<--3
      //   3<--2
      //  2<--1
      //  1<--0
    }
    // 400, 400, 400, 400, 420, 440
    positions[0] = getNextPosition(positions[0])!;
  }

  Offset? getNextPosition(Offset position) {
    Offset? nextPosition;

    if (direction == Direction.right) {
      nextPosition = Offset(position.dx + step, position.dy);
    } else if (direction == Direction.left) {
      nextPosition = Offset(position.dx - step, position.dy);
    } else if (direction == Direction.up) {
      nextPosition = Offset(position.dx, position.dy - step);
    } else if (direction == Direction.down) {
      nextPosition = Offset(position.dx, position.dy + step);
    }

    return nextPosition;
  }

  void drawFood() {
    if (foodPosition == null) {
      foodPosition = getRandomPosition();
    }

    if (foodPosition == positions[0]) {
      length++;
      score = score + 5;
      speed = speed++;
      foodPosition = getRandomPosition();
    }

    // food = Piece(
    //   posX: foodPosition!.dx.toInt(),
    //   posY: foodPosition!.dy.toInt(),
    //   color: Colors.red,
    //   size: step,
    // );
  }

  List<Piece> getPieces() {
    final pieces = <Piece>[];
    draw();
    drawFood();
    for (var i = 0; i < length; ++i) {
      pieces.add(Piece(
        posX: positions[i].dx.toInt(),
        posY: positions[i].dy.toInt(),
        size: step,
        color: Colors.red,
      ));
    }

    return pieces;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHight = MediaQuery.of(context).size.height;

    lowerBoundX = step;
    lowerBoundY = step;

    upperBoundX = getNearestTens(screenHight.toInt() - step);
    upperBoundY = getNearestTens(screenWidth.toInt() - step);

    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Stack(
          children: [
            Stack(
              children: getPieces(),
            ),
            getControls(),
      Piece(
        posX: foodPosition!.dx.toInt(),
        posY: foodPosition!.dy.toInt(),
        color: Colors.red,
        size: step,
      ),
          ],
        ),
      ),
    );
  }
}
