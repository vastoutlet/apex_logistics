import 'package:another_stepper/another_stepper.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_action/slide_action.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class DecideRouteController extends GetxController {
  RxBool isDriver =
      true.obs; //based on the authenticated user type or use sharedPreference
  RxBool onlineCard = false.obs;
  RxBool isOnline = false.obs; //driver online status
  RxBool startRideModal = false.obs;
  Rx<double> leftPosition = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // listener to display incoming request
    //- to be changed appropriately (only show when user make a request)
    ever(isOnline, (value) {
      if (value) {
        incomingRequest(Get.context);
      }
    });
  }

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
              child: requestCard(context),
            )));
  }

  Column requestCard(context) {
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
        title: const DefaultText(
          text: "Drop Location",
          size: 16.0,
          weight: FontWeight.bold,
        ),

        // StepperText(
        //   "Drop Location",
        //   textStyle: const TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: "RobotoRegular",
        //   ),
        // ),
        subtitle: const Row(children: [
          DefaultText(text: "Wada Street, Bauchi North", size: 14.0),
          SizedBox(width: 20.0),
          DefaultText(text: "Text", size: 14.0),
        ]),

        // StepperText(
        //   "",
        //   textStyle: const TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.normal,
        //     fontFamily: "RobotoRegular",
        //   ),
        // ),
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
        const SizedBox(height: 20.0),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
        ]),
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
                  onlineCard.value = false;
                  startRideModal.value = true;
                  // buildStartRideModal(context);
                },
                buttonHeight: 40,
                child:
                    const DefaultText(text: "Accept", fontColor: Colors.white),
              ),
            )
          ],
        )

        // stepper
      ],
    );
  }

  buildStartRide(context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              children: [
                ClipOval(
                  // to be changed to user image (memory)
                  child: Image.asset(
                    "assets/images/rider.jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5),
                const Column(
                  children: [
                    DefaultText(
                      text: "Apex Logistics",
                      weight: FontWeight.bold,
                      size: 18.0,
                    ),
                    Row(children: [
                      DefaultText(
                        text: "Arrived",
                        weight: FontWeight.bold,
                        fontColor: Constants.primaryNormal,
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.circle, color: Constants.whiteDark, size: 10),
                      SizedBox(width: 5),
                      DefaultText(
                        text: "Waiting",
                        weight: FontWeight.bold,
                        fontColor: Constants.errorNormal,
                      ),
                    ])
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Constants.whiteDark,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.call,
                    color: Constants.primaryNormal,
                    size: 30.0,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 60.0,
              child: SlideAction(
                trackBuilder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Constants.primaryNormal,
                    ),
                    child: Center(
                      child: DefaultText(
                        // Show loading if async operation is being performed
                        text: state.isPerformingAction
                            ? "Loading..."
                            : "Start ride",
                        fontColor: Constants.whiteLight,
                        size: 18.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                thumbBuilder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Constants.whiteLight,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      // Show loading indicator if async operation is being performed
                      child: state.isPerformingAction
                          ? const CupertinoActivityIndicator(
                              color: Constants.whiteDark,
                            )
                          : const Icon(
                              Icons.chevron_right,
                              color: Constants.whiteDark,
                              size: 30.0,
                            ),
                    ),
                  );
                },
                action: () async {
                  await Future.delayed(
                    // call remote method to start ride
                    const Duration(seconds: 2),
                    () {
                      debugPrint("ride started");
                    },
                  );
                },
              ),
            )
          ]),
        ));

    // return showModalBottomSheet(
    //     context: context,
    //     isScrollControlled: true,
    //     isDismissible: false,
    //     shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
    //     builder: (context) {
    //       return
    //     });
  }
}

// buildStartRideModal(context) {
//   return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       isDismissible: false,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
//       builder: (context) {
//         return Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(mainAxisSize: MainAxisSize.min, children: [
//                 Row(
//                   children: [
//                     ClipOval(
//                       // to be changed to user image (memory)
//                       child: Image.asset(
//                         "assets/images/rider.jpg",
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     const Column(
//                       children: [
//                         DefaultText(
//                           text: "Apex Logistics",
//                           weight: FontWeight.bold,
//                           size: 18.0,
//                         ),
//                         Row(children: [
//                           DefaultText(
//                             text: "Arrived",
//                             weight: FontWeight.bold,
//                             fontColor: Constants.primaryNormal,
//                           ),
//                           SizedBox(width: 5),
//                           Icon(Icons.circle,
//                               color: Constants.whiteDark, size: 10),
//                           SizedBox(width: 5),
//                           DefaultText(
//                             text: "Waiting",
//                             weight: FontWeight.bold,
//                             fontColor: Constants.errorNormal,
//                           ),
//                         ])
//                       ],
//                     ),
//                     const Spacer(),
//                     Container(
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         color: Constants.whiteDark,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: const Icon(
//                         Icons.call,
//                         color: Constants.primaryNormal,
//                         size: 30.0,
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 20.0),
//                 SizedBox(
//                   height: 60.0,
//                   child: SlideAction(
//                     trackBuilder: (context, state) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                           color: Constants.primaryNormal,
//                         ),
//                         child: Center(
//                           child: DefaultText(
//                             // Show loading if async operation is being performed
//                             text: state.isPerformingAction
//                                 ? "Loading..."
//                                 : "Start ride",
//                             fontColor: Constants.whiteLight,
//                             size: 18.0,
//                             weight: FontWeight.bold,
//                           ),
//                         ),
//                       );
//                     },
//                     thumbBuilder: (context, state) {
//                       return Container(
//                         margin: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: Constants.whiteLight,
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Center(
//                           // Show loading indicator if async operation is being performed
//                           child: state.isPerformingAction
//                               ? const CupertinoActivityIndicator(
//                                   color: Constants.whiteDark,
//                                 )
//                               : const Icon(
//                                   Icons.chevron_right,
//                                   color: Constants.whiteDark,
//                                   size: 30.0,
//                                 ),
//                         ),
//                       );
//                     },
//                     action: () async {
//                       await Future.delayed(
//                         // call remote method to start ride
//                         const Duration(seconds: 2),
//                         () {
//                           debugPrint("ride started");
//                         },
//                       );
//                     },
//                   ),
//                 )
//               ]),
//             ));
//       });
// }
