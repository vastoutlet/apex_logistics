import 'package:another_stepper/another_stepper.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRideDetailController extends GetxController {
  var data;

  var stepperItem = <StepperData>[].obs;

  addStep(StepperData item) {
    stepperItem.add(item);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    data = Get.arguments;

    if (data['deliveryMessage'] == "Cancelled") {
      addStep(customStepperDataItem(
          title: "Pick Up",
          subtitle: DefaultText(
            text: data["address"],
            size: 14.0,
          )));

      addStep(
        customStepperDataItem(
            title: "Destination",
            subtitle: const Column(
              children: [
                DefaultText(
                  text: "Wada Street, Bauchi North",
                  size: 14,
                ),
                SizedBox(
                  height: 10,
                ),
                MapFrame(),
              ],
            ),
            color: Constants.errorDark),
      );

      // addTimelineItem(TimelineItem(
      //     title: "Pick Up", subtitle: DefaultText(text: data["address"])));
      // addTimelineItem(
      //   TimelineItem(
      //     title: "Destination",
      //     subtitle: const Column(
      //       children: [
      //         DefaultText(
      //           text: "Wada Street, Bauchi North",
      //           size: 14,
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         MapFrame()
      //       ],
      //     ),
      //     parcelIndicator: Constants.errorDark,
      //   ),
      // );
    } else if (data['deliveryMessage'] == "Delivered") {
      addStep(
        customStepperDataItem(
          title: "Pick Up",
          subtitle: DefaultText(
            text: data["address"],
            size: 14.0,
          ),
        ),
      );

      addStep(
        customStepperDataItem(
          title: "Current Location",
          subtitle: const Column(
            children: [
              DefaultText(
                text: "Wada Street, Bauchi North",
                size: 14,
              ),
              SizedBox(height: 10.0),
              MapFrame()
            ],
          ),
        ),
      );

      addStep(
        customStepperDataItem(
          title: "Destination",
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                text: "Wada Street, Bauchi North",
              ),
              DefaultText(
                text: "Delivered",
                fontColor: Constants.primaryNormal,
              ),
            ],
          ),
        ),
      );
    } else if (data['deliveryMessage'] == "Ongoing") {
      // 2 different scenarios for ongoing ride
      // 1st scenario - current location tile before any destination
      // 2nd scenario - current location in between the destinations based on where the rider is
      // check for multiple destination, add number of destination in my_ride model
      // calculate the difference between rider's location and distance

      // gats be later - lol
    }
  }

  StepperData customStepperDataItem(
      {required String title,
      required Widget subtitle,
      Color color = Constants.primaryNormal}) {
    return StepperData(
      title: DefaultText(
        text: title,
        size: 18.0,
        weight: FontWeight.bold,
      ),
      subtitle: subtitle,
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.circle,
          color: Constants.whiteNormal,
          size: 15,
        ),
      ),
    );
  }
}

class MapFrame extends StatelessWidget {
  const MapFrame({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 70,
        decoration: BoxDecoration(
            border: Border.all(color: Constants.primaryNormal, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(30.0))),
        child: const DefaultText(
          text: "Map Frame",
          align: TextAlign.center,
        ));
  }
}
