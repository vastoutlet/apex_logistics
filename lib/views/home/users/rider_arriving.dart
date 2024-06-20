import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultStepper.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class RiderArriving extends StatefulWidget {
  RiderArriving({super.key});

  @override
  State<RiderArriving> createState() => _RiderArrivingState();
}

class _RiderArrivingState extends State<RiderArriving> {
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
                // Rider Arriving and Stepper
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stepper Title
                      DefaultText(
                        text: "Motorcycle Arriving",
                        fontColor: Constants.whiteNormal,
                        size: 20,
                        weight: FontWeight.bold,
                      ),

                      // Stepper Row
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: DefaultStepper(step: 4),
                      ),
                    ],
                  ),
                ),

                // Current Trip
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Text
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: DefaultText(
                              text: "Ride",
                              size: 20,
                              weight: FontWeight.bold,
                            ),
                          ),

                          // Available Rides
                          Card(
                            borderOnForeground: false,
                            margin: const EdgeInsets.only(bottom: 15),
                            color: Constants.whiteNormal,
                            shadowColor: Constants.whiteNormal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/rider.jpg",
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const DefaultText(
                                text: "TWD 1234 BAUCHI",
                                size: 18,
                                weight: FontWeight.bold,
                              ),
                              subtitle: const DefaultText(
                                text: "Arriving in 2min",
                                size: 15,
                              ),
                              trailing: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.star_border_rounded,
                                    color: Constants.primaryNormal,
                                  ),
                                  SizedBox(width: 10),
                                  DefaultText(
                                    text: "4.8",
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Confirm Ride Button
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 30),
                            child: DefaultButton(
                              onPressed: () {},
                              child: const DefaultText(
                                text: "Cancel request",
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
