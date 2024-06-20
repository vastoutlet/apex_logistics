import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DefaultStepper extends StatelessWidget {
  final int step;
  const DefaultStepper({required this.step, super.key});

  @override
  Widget build(BuildContext context) {
    print("STEPPER: $step");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Using a for loop with the spread operator to generate containers and lines dynamically
        for (int index = 0; index < 4; index++) ...[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: (step >= index + 1)
                  ? Constants.whiteNormal
                  : Constants.blackNormal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DefaultText(
              text: "${index + 1}",
              size: 20,
              fontColor: (step >= index + 1)
                  ? Constants.blackDark
                  : Constants.whiteNormal,
              weight: FontWeight.bold,
            ),
          ),
          if (index != 3)
            const Expanded(
              // Only wrapping the dotted lines with Expanded to fill the space between containers
              child: DottedLine(
                dashColor: Constants.whiteNormal,
              ),
            ),
        ],
      ],
    );
  }
}
