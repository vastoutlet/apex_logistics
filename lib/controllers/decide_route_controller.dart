import 'package:another_stepper/another_stepper.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class DecideRouteController extends GetxController {
  RxBool isDriver =
      true.obs; //based on the authenticated user type or use sharedPreference
  RxBool onlineCard = false.obs;
  Rx<double> leftPosition = 0.0.obs;

  incomingRequest(context, {double? size}) async {
    return await Future.delayed(
        const Duration(seconds: 2),
        () => showTopModalSheet(
            context,
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: requestCard(),
              ),
            )));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // listener to display incoming request - to be changed appropriately
    ever(onlineCard, (value) {
      if (value) {
        incomingRequest(Get.context);
      }
    });
  }
}

Column requestCard() {
  final List<StepperData> stepperData = [
    StepperData(
      title: StepperText(
        "Pick up",
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "RobotoRegular",
        ),
      ),
      subtitle: StepperText(
        "6 Tudun Wada Street, Bauchi",
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: "RobotoRegular",
        ),
      ),
      iconWidget: Container(
        decoration: const BoxDecoration(
          color: Constants.primaryNormal,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.circle,
          color: Constants.whiteNormal,
          size: 18,
        ),
      ),
    ),
    StepperData(
      title: StepperText(
        "Drop Location",
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "RobotoRegular",
        ),
      ),
      subtitle: StepperText(
        "Wada Street, Bauchi North",
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: "RobotoRegular",
        ),
      ),
      iconWidget: Container(
        decoration: const BoxDecoration(
          color: Constants.primaryNormal,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.location_on_outlined,
          color: Constants.whiteNormal,
          size: 18,
        ),
      ),
    ),
    StepperData(
      title: StepperText(
        "Drop Location 2",
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "RobotoRegular",
        ),
      ),
      subtitle: StepperText(
        "Wada Street, Bauchi North",
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: "RobotoRegular",
        ),
      ),
      iconWidget: Container(
        decoration: const BoxDecoration(
          color: Constants.primaryNormal,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.location_on_outlined,
          color: Constants.whiteNormal,
          size: 18,
        ),
      ),
    ),
  ];

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const DefaultText(
            text: "Apex Logistics",
            weight: FontWeight.bold,
            size: 16,
          ),
          const SizedBox(width: 10.0),
          ClipOval(
            // to be changed to user image (memory)
            child: Image.asset(
              "assets/images/rider.jpg",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnotherStepper(
            stepperList: stepperData,
            stepperDirection: Axis.vertical,
            iconWidth: 30,
            iconHeight: 30,
            activeBarColor: Constants.primaryNormal,
            inActiveBarColor: Colors.grey,
            inverted: false,
            verticalGap: 20,
            activeIndex: 1,
            barThickness: 1,
          ),
        ],
      ),
      const SizedBox(height: 20.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: DefaultButton(
              onPressed: () {},
              buttonColor: Constants.whiteNormal,
              borderColor: Constants.primaryNormal,
              buttonHeight: 40,
              child: const DefaultText(
                  text: "Reject", fontColor: Constants.primaryNormal),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: DefaultButton(
              onPressed: () {
                Get.close(1);
              },
              buttonHeight: 40,
              child: const DefaultText(text: "Accept", fontColor: Colors.white),
            ),
          )
        ],
      )

      // stepper
    ],
  );
}
