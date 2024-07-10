import 'package:another_stepper/another_stepper.dart';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/my_ride_details_controller.dart';
import 'package:apex_logistics/utils/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyRideDetail extends StatelessWidget {
  MyRideDetail({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final data = Get.arguments;

  final controller = Get.put(MyRideDetailController());

  final List<StepperData> stepperData = [
    StepperData(
      title: const DefaultText(
        text: "Pick Up",
        size: 18.0,
        weight: FontWeight.bold,
      ),
      subtitle: const DefaultText(
        text: "6, Tudun Wada, Street, Bauchi",
        size: 14.0,
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
      title: const DefaultText(
        text: "Current Location",
        size: 18.0,
        weight: FontWeight.bold,
      ),
      subtitle: const Column(
        children: [
          DefaultText(
            text: "WadaStreet, Bauchi North",
            size: 14.0,
          ),
          MapFrame()
        ],
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
      title: const DefaultText(
        text: "Destination",
        size: 18.0,
        weight: FontWeight.bold,
      ),
      subtitle: const DefaultText(
        text: "Wada Street, Bauchi North",
        size: 14.0,
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
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.whiteLight,
      appBar: DefaultAppBar(
        title: "My Ride",
        icon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.filter_alt,
            color: Constants.whiteNormal,
          ),
        ),
      ),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          text: data['deliveryMessage'],
                          weight: FontWeight.bold,
                          size: 18.0,
                        ),
                        const SizedBox(height: 5.0),
                        DefaultText(
                          text: "ID: ${data['id']}",
                          weight: FontWeight.bold,
                          size: 15.0,
                        ),
                        const SizedBox(height: 5.0),
                        DefaultText(
                          text: data['timePrice'],
                          size: 15.0,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Stack(clipBehavior: Clip.none, children: [
                      Positioned(
                        // left: 0.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/rider.jpg",
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20.0,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/rider.jpg",
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(height: 20.0),
                controller.stepperItem.isEmpty
                    ? const Center(
                        child: DefaultText(
                        text: "Route Loading...",
                        size: 18.0,
                      ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnotherStepper(
                            stepperList: controller.stepperItem,
                            stepperDirection: Axis.vertical,
                            iconWidth: 30,
                            iconHeight: 30,
                            activeBarColor: Constants.primaryNormal,
                            inActiveBarColor: Colors.grey,
                            inverted: false,
                            verticalGap: 60, //20
                            activeIndex: 1,
                            barThickness: 1,
                          ),
                        ],
                      ),
                const SizedBox(height: 20.0),
                const DefaultText(
                  text: "Payment",
                  weight: FontWeight.bold,
                  size: 18.0,
                ),
                const SizedBox(height: 10.0),
                const Row(
                  children: [
                    DefaultText(
                      text: "Package Fee",
                    ),
                    Spacer(),
                    DefaultText(
                      text: "#4,000.00",
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Row(
                  children: [
                    DefaultText(
                      text: "Cancellation Fee",
                    ),
                    Spacer(),
                    DefaultText(
                      text: "#0.00",
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1.5,
                  color: Constants.blackNormal,
                ),
                const Row(
                  children: [
                    DefaultText(
                      text: "Total",
                      weight: FontWeight.bold,
                    ),
                    Spacer(),
                    DefaultText(
                      text: "#4,000.00",
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                const Center(
                  child: DefaultText(
                    text:
                        "Additional ride details can be found in your email receipt",
                    fontColor: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
