import 'dart:async';

import 'package:another_stepper/another_stepper.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultStepper.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/components/showTripModals.dart';
import 'package:apex_logistics/components/stepperDataMod.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:apex_logistics/views/home/users/confirm_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiderArriving extends StatefulWidget {
  const RiderArriving({super.key});

  @override
  State<RiderArriving> createState() => _RiderArrivingState();
}

class _RiderArrivingState extends State<RiderArriving> {
  String headerText = "Driver Found";
  Widget subhead = const DefaultText(
    text: "Waiting for driver to confirm ride",
    fontColor: Constants.whiteNormal,
    size: 18,
  );
  // String subHead = "Waiting for driver to confirm ride";
  late Timer timer;
  double progressValue = 1.0;
  bool requestCancel = false;
  bool rideAccept = false;

  void loadingDriverResponse() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if (progressValue > 0) {
          progressValue -= 0.1;
        } else {
          rideAccept = true;
          headerText = "Rider";
          this.subhead = const SizedBox.shrink();
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingDriverResponse();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final confirmAddressController = Get.find<ConfirmAddressController>();
    final List<StepperData> stepperData = List.generate(
        confirmAddressController.stepperDataTitle.length,
        (index) => stepperDataMod(index, confirmAddressController,
            icon: Icons.location_on));
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: IntrinsicHeight(
          child: SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rider Arriving and Stepper
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stepper Title
                        DefaultText(
                          text: headerText,
                          fontColor: Constants.whiteNormal,
                          size: 20,
                          weight: FontWeight.bold,
                        ),

                        subhead,

                        // DefaultText(
                        //   text: subHead,
                        //   fontColor: Constants.whiteNormal,
                        //   size: 18,
                        // ),
                        const SizedBox(height: 10.0),

                        // Stepper Row
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: DefaultStepper(step: 4),
                        ),
                      ],
                    ),
                  ),

                  // Request
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Constants.whiteLight,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: !rideAccept
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    //request loader
                                    height: 10.0,
                                    child: LinearProgressIndicator(
                                      color: Constants.primaryNormal,
                                      value: progressValue,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: GestureDetector(
                                        onTap: () => showTripModals(
                                            context, const CancelRide(),
                                            bgColor: Constants.whiteLight),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Constants.blackLight,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: const ClipOval(
                                                child: Icon(
                                                  Icons.pedal_bike_rounded,
                                                  size: 50.0,
                                                  color: Constants.whiteDark,
                                                ),
                                              ),
                                            ),
                                            const DefaultText(
                                              text: "Cancel Ride",
                                              size: 16.0,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Available Rides
                                  // Card(
                                  //   borderOnForeground: false,
                                  //   margin: const EdgeInsets.only(bottom: 15),
                                  //   color: Constants.whiteNormal,
                                  //   shadowColor: Constants.whiteNormal,
                                  //   shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(12),
                                  //   ),
                                  //   child: ListTile(
                                  //     leading: CircleAvatar(
                                  //       child: ClipOval(
                                  //         child: Image.asset(
                                  //           "assets/images/rider.jpg",
                                  //           width: 60,
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     title: const DefaultText(
                                  //       text: "TWD 1234 BAUCHI",
                                  //       size: 18,
                                  //       weight: FontWeight.bold,
                                  //     ),
                                  //     subtitle: const DefaultText(
                                  //       text: "Arriving in 2min",
                                  //       size: 15,
                                  //     ),
                                  //     trailing: const Row(
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Icon(
                                  //           Icons.star_border_rounded,
                                  //           color: Constants.primaryNormal,
                                  //         ),
                                  //         SizedBox(width: 10),
                                  //         DefaultText(
                                  //           text: "4.8",
                                  //           size: 15,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),

                                  // Confirm Ride Button
                                  // Padding(
                                  //   padding: const EdgeInsets.only(bottom: 10, top: 30),
                                  //   child: DefaultButton(
                                  //     onPressed: () {},
                                  //     child: const DefaultText(
                                  //       text: "Cancel request",
                                  //       fontColor: Constants.whiteNormal,
                                  //       size: 18,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    ClipOval(
                                      child: Image.asset(
                                        "assets/images/rider.jpg",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width - 150,
                                            child: Row(
                                              children: [
                                                const DefaultText(
                                                    text: "PLATE NUMBER",
                                                    weight: FontWeight.bold),
                                                const Spacer(),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Constants.blackLight,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: const Icon(
                                                    Icons.call,
                                                    color:
                                                        Constants.primaryNormal,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          const DefaultText(
                                            text: "Apex Rider",
                                          ),
                                          const SizedBox(height: 5.0),
                                          const DefaultText(
                                            text: "Arriving in 5min.",
                                          ),
                                          const SizedBox(height: 5.0),
                                          SizedBox(
                                            width: size.width - 150,
                                            child: Row(children: [
                                              const Expanded(
                                                child: Text.rich(
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "RobotoRegular"),
                                                    TextSpan(children: [
                                                      TextSpan(
                                                          text: "Accepted ",
                                                          style: TextStyle(
                                                              color: Constants
                                                                  .primaryNormal)),
                                                      TextSpan(
                                                          text: " Waiting",
                                                          style: TextStyle(
                                                              color: Constants
                                                                  .errorNormal)),
                                                    ])),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Constants.blackLight,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: const ClipOval(
                                                  child: Icon(
                                                    Icons.my_location,
                                                    color:
                                                        Constants.primaryNormal,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ]),
                                  ]),
                                  const Divider(
                                    thickness: 5.0,
                                    color: Constants.whiteDark,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: DefaultText(
                                      text: "My Route",
                                      weight: FontWeight.bold,
                                      size: 18.0,
                                    ),
                                  ),
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
                                  const Divider(
                                    thickness: 5.0,
                                    color: Constants.whiteDark,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Row(children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Constants.blackLight,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: const ClipOval(
                                          child: Icon(
                                            Icons.pedal_bike_rounded,
                                            size: 30.0,
                                            color: Constants.blackNormal,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      const Expanded(
                                          child: DefaultText(
                                              text: "Cancel Ride", size: 16.0)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons
                                              .arrow_forward_ios_outlined)),
                                    ]),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }
}

class CancelRide extends StatelessWidget {
  const CancelRide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: IntrinsicHeight(
          child: SizedBox(
            width: size.width,
            // height: size.height / 3,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
              child: Column(
                children: [
                  // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  //   IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.cancel_outlined,
                  //       color: Constants.whiteDark,
                  //     ),
                  //   )
                  // ]),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Constants.blackLight,
                        borderRadius: BorderRadius.circular(100)),
                    child: const ClipOval(
                      child: Icon(
                        Icons.pedal_bike_rounded,
                        size: 50.0,
                        color: Constants.whiteDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const DefaultText(
                    text: "Are you sure?",
                    size: 18.0,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10.0),
                  const Expanded(
                    child: DefaultText(
                      text:
                          "Cancelling your ride might not save you time.\nRe-booking may not be faster",
                      size: 16.0,
                      align: TextAlign.center,
                      fontColor: Constants.whiteDark,
                    ),
                  ),
                  Expanded(
                    child: DefaultButton(
                      onPressed: () {
                        //delete all saved data
                        var confirmAddressData =
                            Get.find<ConfirmAddressController>();

                        confirmAddressData.stepperDataTitle.removeRange(
                            1, confirmAddressData.stepperDataTitle.length);
                        // confirmAddressData.stepperDataTitle.removeRange(
                        //     1, confirmAddressData.stepperDataTitle.length);

                        Get.close(2);
                      },
                      buttonColor: Constants.errorNormal,
                      child: const DefaultText(
                        text: "Cancel Ride",
                        size: 16.0,
                        fontColor: Constants.whiteDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: DefaultButton(
                      onPressed: () {
                        Get.close(1);
                      },
                      buttonColor: Constants.whiteLight,
                      borderColor: Constants.primaryNormal,
                      child: const DefaultText(
                        text: "Wait for Rider",
                        size: 16.0,
                        fontColor: Constants.primaryNormal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
