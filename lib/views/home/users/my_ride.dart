import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultRideCards.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/my_ride_controller.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRide extends StatelessWidget {
  MyRide({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final controller = Get.put(MyRideController());

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.whiteLight,
      appBar: DefaultAppBar(
        title: "My Ride",
        icon: IconButton(
          onPressed: () {
            // SizedBox(width: MediaQuery.of(context).size.width, child: );
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                builder: (context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            top: 20.0,
                            left: 20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const DefaultText(
                                  text: "Filter Ride",
                                  weight: FontWeight.bold,
                                  size: 20.0),
                              const SizedBox(height: 40.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          controller.deliveryMessage.clear();
                                          controller.deliveryMessage
                                              .add("Cancelled");
                                          Get.close(1);
                                        },
                                        child: const DefaultText(
                                            text: "Cancelled",
                                            weight: FontWeight.bold)),
                                    const SizedBox(height: 30.0),
                                    GestureDetector(
                                        onTap: () {
                                          controller.deliveryMessage.clear();
                                          controller.deliveryMessage
                                              .add("Completed");
                                          Get.close(1);
                                        },
                                        child: const DefaultText(
                                            text: "Completed",
                                            weight: FontWeight.bold)),
                                    const SizedBox(height: 30.0),
                                    GestureDetector(
                                        onTap: () {},
                                        child: const DefaultText(
                                            text: "Ongoing",
                                            weight: FontWeight.bold)),
                                    const SizedBox(height: 30.0),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 10),
                            ])),
                  );
                });
          },
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
              children: [
                Obx(() => ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.deliveryMessage.length,
                      itemBuilder: (context, index) => DefaultRideCards(
                        address: controller.myRideDetailModel.address,
                        timePrice: controller.myRideDetailModel.timePrice,
                        deliveryMessage: controller.deliveryMessage[index],
                        status: controller.deliveryMessage[index] == "Cancelled"
                            ? false
                            : true,
                        onTap: () => Get.toNamed("/myRideDetail", arguments: {
                          'id': controller.myRideDetailModel.id,
                          'address': controller.myRideDetailModel.address,
                          'timePrice': controller.myRideDetailModel.timePrice,
                          'deliveryMessage': controller.deliveryMessage[index],
                          'status': controller.myRideDetailModel.status,
                        }),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
