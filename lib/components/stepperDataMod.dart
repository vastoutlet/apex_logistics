import 'package:another_stepper/another_stepper.dart';
import 'package:another_stepper/widgets/stepper_text.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

StepperData stepperDataMod(int index, var controller,
        {IconData icon = Icons.circle}) =>
    StepperData(
      title: StepperText(
        controller.stepperDataTitle.elementAt(index),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: "RobotoRegular",
        ),
      ),
      subtitle: StepperText(
        controller.stepperDataSubtitle.elementAt(index),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: "RobotoRegular",
        ),
      ),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Constants.primaryNormal,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Icon(
          icon,
          color: Constants.whiteNormal,
          size: 15,
        ),
      ),
    );
