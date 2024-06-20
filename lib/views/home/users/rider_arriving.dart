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
                // Confirm address and Stepper
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stepper Title
                      DefaultText(
                        text: "Choose a Rider",
                        fontColor: Constants.whiteNormal,
                        size: 20,
                        weight: FontWeight.bold,
                      ),

                      // Stepper Row
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: DefaultStepper(step: 3),
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
                              text: "Available Ride",
                              size: 20,
                              weight: FontWeight.bold,
                            ),
                          ),

                          // Available Rides
                          Column(
                            children: List.generate(5, (index) {
                              return Card(
                                borderOnForeground: false,
                                margin: const EdgeInsets.only(bottom: 15),
                                color: Constants.whiteNormal,
                                shadowColor: Constants.whiteNormal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: Image.asset(
                                    "assets/images/bike.png",
                                    width: 60,
                                  ),
                                  title: const DefaultText(
                                    text: "Bauchi Mall",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  subtitle: const Row(
                                    children: [
                                      DefaultText(
                                        text: "1 min",
                                        size: 15,
                                      ),
                                      SizedBox(width: 20),
                                      Icon(
                                        Icons.map,
                                        color: Constants.primaryNormal,
                                      ),
                                      SizedBox(width: 8),
                                      DefaultText(
                                        text: "40 km",
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  trailing: const DefaultText(
                                    text: "₦ 4,000",
                                    size: 15,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }),
                          ),

                          // Confirm Ride Button
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 30),
                            child: DefaultButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DefaultText(
                                    text: "Confirm",
                                    fontColor: Constants.whiteNormal,
                                    size: 18,
                                  ),
                                  SizedBox(width: 20),
                                  Icon(Icons.delivery_dining_outlined),
                                ],
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
