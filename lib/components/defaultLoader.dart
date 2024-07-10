import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultLoader extends StatelessWidget {
  const DefaultLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      content: Container(
        height: 100,
        width: size.width * 0.5,
        margin: const EdgeInsets.all(20),
        child: const Column(
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
      ),
    );
    ;
  }
}
