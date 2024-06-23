import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultRideCards.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/my_ride_controller.dart';
import 'package:apex_logistics/utils/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MyRide extends StatelessWidget {
  MyRide({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final controller = Get.put(MyRideController());

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.whiteLight,
      appBar: const DefaultAppBar(),
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
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.deliveryMessage.length,
                  itemBuilder: (context, index) => DefaultRideCards(
                    address: controller.myRideDetailModel.address,
                    timePrice: controller.myRideDetailModel.timePrice,
                    deliveryMessage: controller.deliveryMessage[index],
                    status:
                        controller.deliveryMessage[index] == "Cancelled Ride"
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
