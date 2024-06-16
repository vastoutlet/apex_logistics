import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function onPressed;
  final double? textSize;
  final FontWeight? textWeight;
  final Size? size;
  Color? buttonColor;
  Color? borderColor;
  Color? textColor;
  Widget? child;

  DefaultButton({
    super.key,
    required this.onPressed,
    this.textSize,
    this.textWeight,
    this.size,
    this.buttonColor = Constants.primaryNormal,
    this.borderColor,
    this.textColor = Constants.whiteLight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(buttonColor),
        foregroundColor: WidgetStateProperty.all(textColor),
        minimumSize: WidgetStateProperty.all(
          const Size(
            double.infinity,
            50,
          ),
        ),
        side: WidgetStateProperty.resolveWith<BorderSide?>(
          (Set<WidgetState> states) {
            if (borderColor != null) {
              return const BorderSide(
                color: Constants.primaryNormal,
                width: 1,
              ); // Default border color and width
            }
            return null;
          },
        ),
      ),
      child: child,
    );
  }
}
