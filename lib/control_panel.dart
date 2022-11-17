import 'package:flutter/material.dart';
import 'package:snake_game/direction.dart';

import 'controlbutton.dart';
import 'direction.dart';

class ControlPanel extends StatelessWidget {
  final void Function(Direction direction) onTapped;

  const ControlPanel({required this.onTapped}) : super();

  Widget build(BuildContext context) {
    return Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 50.0,
        child: Row(
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(child: Container()),
                ControlButton(
                  onPressed: () {
                    onTapped(Direction.left);
                  },
                  icon: Icon(Icons.arrow_left),
                )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                ControlButton(
                    icon: Icon(Icons.arrow_drop_up),
                    onPressed: () {
                      onTapped(Direction.up);
                    }),
                SizedBox(
                  height: 40.0,
                ),
                ControlButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      onTapped(Direction.down);
                    }),
              ],
            )),
            Expanded(
              child: Row(
                children: [
                  ControlButton(
                    onPressed: () {
                      onTapped(Direction.right);
                    },
                    icon: Icon(Icons.arrow_right),
                  ),
                  // Expanded(child: Container()),
                ],
              ),
            ),
          ],
        ));
  }
}
