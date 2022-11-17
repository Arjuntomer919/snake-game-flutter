import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;

  const ControlButton({required this.icon, required this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1,
      child: Container(
        width: 80,
        height: 80,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            elevation: 0.0,
            child: icon,
            onPressed:onPressed,
          ),
        ),
      ),
    );
  }
}
