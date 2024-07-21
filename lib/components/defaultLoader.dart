import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultLoader extends StatelessWidget {
  const DefaultLoader({
    super.key,
    this.widthSize = 0.5,
    this.height = 100,
    this.content = const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircularProgressIndicator(
          color: Constants.primaryNormal,
        ),
        SizedBox(height: 20),
        DefaultText(
          text: 'Loading......',
          size: 20,
        ),
      ],
    ),
  });
  final Widget content;
  final double? widthSize;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      content: Container(
        height: height,
        width: size.width * widthSize!,
        margin: const EdgeInsets.all(10),
        child: content,
      ),
    );
    ;
  }
}
