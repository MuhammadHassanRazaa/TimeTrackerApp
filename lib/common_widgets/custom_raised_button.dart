import 'package:flutter/material.dart';

const Text defaultButtonText = Text('myButton');

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child: defaultButtonText,
    this.color,
    this.height: 50.0,
    this.borderRadius: 4.0,
    this.onPressed,
    this.backgroundColor,
  }) : assert(borderRadius != null);
  final Widget child;
  final Color color;
  final double height;
  final double borderRadius;
  final VoidCallback onPressed;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return backgroundColor != null ? color : Colors.grey;
              }
              return color;
            },
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
