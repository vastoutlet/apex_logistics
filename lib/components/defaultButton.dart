import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function onPressed;
  final double? textSize;
  final FontWeight? textWeight;
  final Size? size;
  Color? color;
  Color? textColor;
  Widget? child;

  DefaultButton({
    super.key,
    required this.onPressed,
    this.textSize,
    this.textWeight,
    this.size,
    this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Constants.primaryNormal),
            foregroundColor: WidgetStateProperty.all(Colors.white)),
        child: child);
  }
}
