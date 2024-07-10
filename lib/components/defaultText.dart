import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  //instant variables
  final String? text;
  final Color? fontColor;
  final double? size;
  final TextAlign? align;
  final FontWeight? weight;
  final FontStyle? style;
  final TextDecoration? decoration;
  const DefaultText({
    super.key,
    this.text,
    this.fontColor = Constants.blackDark,
    this.size,
    this.align,
    this.weight,
    this.style,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      softWrap: true,
      style: TextStyle(
        color: fontColor,
        fontFamily: 'RobotoRegular',
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        overflow: TextOverflow.clip,
        decoration: decoration,
      ),
    );
  }
}
