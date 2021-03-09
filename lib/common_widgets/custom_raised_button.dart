import 'package:flutter/material.dart';

const Text defaultButtonText = Text('myButton');

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child: defaultButtonText,
    this.color,
    this.height: 50.0,
    this.borderRadius: 4.0,
    this.onPressed,
  }) : assert(borderRadius != null);
  final Widget child;
  final Color color;
  final double height;
  final double borderRadius;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
