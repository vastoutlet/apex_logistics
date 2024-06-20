import 'package:another_stepper/another_stepper.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultStepper.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/routes/routes.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:apex_logistics/views/home/users/package_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/showTripModals.dart';

class ConfirmAddress extends StatelessWidget {
  ConfirmAddress({super.key});

  List<StepperData> stepperData = [
    StepperData(
      title: StepperText(
        "Pick up",
        textStyle: const TextStyle(
          fontSize: 18,
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
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Constants.primaryNormal,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.circle,
          color: Constants.whiteNormal,
          size: 15,
        ),
      ),
    ),
    StepperData(
      title: StepperText(
        "Delivery Location 1",
        textStyle: const TextStyle(
          fontSize: 18,
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
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Constants.primaryNormal,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.circle,
          color: Constants.whiteNormal,
          size: 15,
        ),
      ),
    ),
    StepperData(
      title: StepperText(
        "Delivery Location 2",
        textStyle: const TextStyle(
          fontSize: 18,
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
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Constants.primaryNormal,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.circle,
          color: Constants.whiteNormal,
          size: 15,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: IntrinsicHeight(
          child: SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Confirm address and Stepper
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stepper Title
                      DefaultText(
                        text: "Confirm address",
                        fontColor: Constants.whiteNormal,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      // Stepper Row
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: DefaultStepper(step: 1),
                      ),
                    ],
                  ),
                ),

                // Current Trip
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Constants.whiteNormal,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Constants.whiteDark,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Header : Trip and Change
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultText(
                                text: "Trip",
                                size: 25,
                                weight: FontWeight.bold,
                              ),
                              DefaultText(
                                text: "CHANGE",
                                size: 20,
                                weight: FontWeight.normal,
                              ),
                            ],
                          ),

                          // Pickup and Delivery Locations
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

                          // Divider
                          const Divider(thickness: 2),

                          // Ride History
                          const SizedBox(height: 10),
                          const DefaultText(
                            text: "Recent ride history",
                            size: 15,
                          ),

                          // History List
                          for (int index = 0; index < 3; index++) ...[
                            const ListTile(
                              leading: Icon(Icons.location_on),
                              title: DefaultText(
                                text: "Bauchi Mall",
                                size: 18,
                              ),
                              subtitle: DefaultText(
                                text: "6 Tudun Wada Street, Bauchi",
                                size: 15,
                              ),
                              trailing: DefaultText(
                                text: "2.9km",
                                size: 15,
                              ),
                            )
                          ],

                          // Add Item Button
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 20),
                            child: DefaultButton(
                              onPressed: () {
                                navigator!.pop(Get.context!);

                                showTripModals(context, PackageContent());
                              },
                              child: const DefaultText(
                                text: "Add item",
                                fontColor: Constants.whiteNormal,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
