import 'package:apex_logistics/components/defaultText.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DefaultPageStatus extends StatelessWidget {
  const DefaultPageStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // EMPTY LIST
        Lottie.asset(
          "assets/images/empty.json",
          width: 400,
          height: 300,
        ),
        const DefaultText(
          text: "No Ride History",
          size: 20.0,
        ),
      ],
    );
  }
}
